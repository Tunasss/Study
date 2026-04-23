import urllib.request
import json
import time
import csv
import os

OUTPUT_DIR = r"d:\Study\ERP\LAB\Project\CSV"
SUPPLIERS_CSV = os.path.join(OUTPUT_DIR, "suppliers.csv")

# Ensure the directory exists
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Tech/Electronics related SIC codes
TECH_SICS = {
    '3571', '3572', '3575', '3577', '3578', '3579', # Computers & office equipment
    '3661', '3663', '3669', # Communications equipment
    '3670', '3672', '3674', '3677', '3678', '3679', # Electronic components & semiconductors
    '3823', '3825', '3826', '3827', '3829', # Measuring & analysis instruments
    '7370', '7371', '7372', '7373', '7374'  # Software & services
}

headers = {'User-Agent': 'DataScript admin@example.com'}

def fetch_companies():
    print("Fetching SEC company list...")
    req = urllib.request.Request('https://www.sec.gov/files/company_tickers.json', headers=headers)
    with urllib.request.urlopen(req) as response:
        data = json.loads(response.read().decode())
    
    # data is like {"0": {"cik_str": 320193, "ticker": "AAPL", "title": "Apple Inc."}, ...}
    # We will iterate and grab exactly 500 tech companies.
    
    companies = []
    
    # We'll also keep track of names to avoid duplicates
    seen_names = set()
    
    keys = list(data.keys())
    
    print(f"Total companies available: {len(keys)}. Scanning for top 500 electronics/tech vendors...")
    
    for k in keys:
        if len(companies) >= 500:
            break
            
        cik_str = str(data[k]['cik_str']).zfill(10)
        req2 = urllib.request.Request(f'https://data.sec.gov/submissions/CIK{cik_str}.json', headers=headers)
        
        try:
            with urllib.request.urlopen(req2) as resp2:
                comp_data = json.loads(resp2.read().decode())
                
                sic = str(comp_data.get('sic', ''))
                if sic in TECH_SICS:
                    base_name = comp_data.get('name', '').title()
                    # skip duplicates or empty names
                    if not base_name or base_name.lower() in seen_names:
                        continue
                        
                    phone = str(comp_data.get('phone', ''))
                    if not phone or phone == 'None':
                        continue
                    
                    # Normalize phone a bit
                    phone = phone.replace('.', '-').replace(' ', '-')
                    
                    addr = comp_data.get('addresses', {}).get('business', {})
                    street1 = addr.get('street1', '')
                    city = addr.get('city', '')
                    state = addr.get('stateOrCountryDescription', addr.get('stateOrCountry', ''))
                    
                    if not street1 or not city:
                        continue
                        
                    address_str = f"{street1.title()}, {city.title()}, {state.title()}"
                    
                    # Synthesize email and website based on name (SEC doesn't have email natively)
                    # We drop spaces and non-alnum for a realistic domain
                    domain_part = "".join([c for c in base_name if c.isalnum()]).lower()
                    if not domain_part:
                        continue
                    
                    email = f"contact@{domain_part}.com"
                    website = f"https://www.{domain_part}.com"
                    country = "USA" # SEC filings mostly US addresses
                    
                    row = [base_name, email, phone, address_str, country, website]
                    companies.append(row)
                    seen_names.add(base_name.lower())
                    
                    if len(companies) % 50 == 0:
                        print(f"Collected {len(companies)} / 500 ... (Last: {base_name})")
                        
        except Exception as e:
            # Safely ignore HTTP errors for missing files or rate limits
            pass
            
        # Strict rate limit of 10 requests per sec
        time.sleep(0.12)
        
    print(f"Finished collecting. Total collected: {len(companies)}")
    return companies

def main():
    companies = fetch_companies()
    
    with open(SUPPLIERS_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(["supplier_name", "email", "phone", "address", "country", "website"])
        writer.writerows(companies)
    print(f"Successfully generated {SUPPLIERS_CSV} with {len(companies)} real tech companies.")

if __name__ == "__main__":
    main()
