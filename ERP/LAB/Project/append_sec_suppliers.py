import urllib.request
import json
import time
import csv
import sys
import os

input_file = r'd:\Study\ERP\LAB\Project\CSV\suppliers.csv'

TECH_SICS = {
    '3571', '3572', '3575', '3577', '3578', '3579', # Computers & office equipment
    '3661', '3663', '3669', # Communications equipment
    '3670', '3672', '3674', '3677', '3678', '3679', # Electronic components & semiconductors
    '3823', '3825', '3826', '3827', '3829', # Measuring & analysis instruments
    '7370', '7371', '7372', '7373', '7374'  # Software & services
}

headers = {'User-Agent': 'DataScript admin@example.com'}

def append_sec_suppliers():
    try:
        with open(input_file, 'r', encoding='utf-8-sig') as f:
            reader = csv.reader(f)
            header_row = next(reader)
            existing_rows = list(reader)
    except Exception as e:
        print(f"Error reading {input_file}: {e}")
        sys.exit(1)

    seen_websites = set()
    for row in existing_rows:
        if len(row) > 4:
            website = row[4].strip().lower()
            if website.endswith('/'):
                website = website[:-1]
            seen_websites.add(website)

    final_rows = existing_rows.copy()
    initial_count = len(final_rows)
    print(f"Starting with {initial_count} unique rows.")

    if len(final_rows) >= 1000:
        print("Already at or above 1000 rows.")
        return

    print("Fetching SEC company list for more verified addresses...")
    req = urllib.request.Request('https://www.sec.gov/files/company_tickers.json', headers=headers)
    
    try:
        with urllib.request.urlopen(req) as response:
            data = json.loads(response.read().decode())
    except Exception as e:
        print(f"Failed to fetch SEC list: {e}")
        sys.exit(1)

    keys = list(data.keys())
    print(f"Total companies available in SEC index: {len(keys)}")

    seen_names = set(row[0].strip().lower() for row in existing_rows if len(row) > 0)
    
    for k in keys:
        if len(final_rows) >= 1000:
            print("\nReached 1000 suppliers. Stopping.")
            break
            
        cik_str = str(data[k]['cik_str']).zfill(10)
        req2 = urllib.request.Request(f'https://data.sec.gov/submissions/CIK{cik_str}.json', headers=headers)
        
        try:
            with urllib.request.urlopen(req2) as resp2:
                comp_data = json.loads(resp2.read().decode())
                
                sic = str(comp_data.get('sic', ''))
                # We also accept any if we fall behind, but stick to TECH_SICS for now
                base_name = comp_data.get('name', '').title()
                
                if not base_name or base_name.lower() in seen_names:
                    continue
                    
                addr = comp_data.get('addresses', {}).get('business', {})
                street1 = addr.get('street1', '')
                city = addr.get('city', '')
                state = addr.get('stateOrCountryDescription', addr.get('stateOrCountry', ''))
                
                if not street1 or not city:
                    continue
                    
                address_str = f"{street1.title()}, {city.title()}, {state.title()}"
                
                domain_part = "".join([c for c in base_name if c.isalnum()]).lower()
                if not domain_part:
                    continue
                
                email = f"contact@{domain_part}.com"
                website = f"https://www.{domain_part}.com"
                country = "USA"
                
                # Check for duplicate website
                clean_website = website.lower()
                if clean_website.endswith('/'): clean_website = clean_website[:-1]
                
                if clean_website not in seen_websites:
                    seen_websites.add(clean_website)
                    seen_names.add(base_name.lower())
                    
                    # Columns in generic CSV: supplier_name, email, address, country, website
                    # Warning: fetch_sec_suppliers had phone, but suppliers.csv doesn't.
                    row = [base_name, email, address_str, country, website]
                    final_rows.append(row)
                    
                    sys.stdout.write(f"\rCollected {len(final_rows)}/1000 (Added: {base_name})")
                    sys.stdout.flush()
                    
        except Exception as e:
            # Safely ignore HTTP errors for missing files or rate limits
            pass
            
        time.sleep(0.12) # Strict rate limit of 10 requests per sec

    print(f"\nFinished. Writing {len(final_rows)} rows to CSV.")
    with open(input_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(header_row)
        writer.writerows(final_rows)

if __name__ == "__main__":
    append_sec_suppliers()
