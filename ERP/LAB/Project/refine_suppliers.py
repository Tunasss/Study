import csv
import re

suppliers_file = r'd:\Study\ERP\LAB\Project\CSV\suppliers.csv'

# Common country name to ISO mapping
country_to_iso = {
    'USA': 'US', 'China': 'CN', 'Taiwan': 'TW', 'Austria': 'AT', 'Hong Kong': 'HK',
    'Ireland': 'IE', 'Japan': 'JP', 'Canada': 'CA', 'United Kingdom': 'GB', 'UK': 'GB',
    'Vietnam': 'VN', 'Germany': 'DE', 'South Korea': 'KR', 'Switzerland': 'CH',
    'France': 'FR', 'Sweden': 'SE', 'Italy': 'IT', 'Netherlands': 'NL',
    'Singapore': 'SG', 'Denmark': 'DK', 'Finland': 'FI', 'Norway': 'NO',
    'Spain': 'ES', 'Australia': 'AU', 'New Zealand': 'NZ', 'India': 'IN',
    'Belgium': 'BE', 'Poland': 'PL', 'Israel': 'IL', 'Brazil': 'BR',
    'Russia': 'RU', 'Romania': 'RO', 'Latvia': 'LV', 'Bulgaria': 'BG'
}

# Mapping for cities/regions to country names
city_to_country = {
    'London': 'United Kingdom', 'Manchester': 'United Kingdom', 'Birmingham': 'United Kingdom',
    'Edinburgh': 'United Kingdom', 'Glasgow': 'United Kingdom', 'Liverpool': 'United Kingdom',
    'Dublin': 'Ireland', 'Cork': 'Ireland',
    'Toronto': 'Canada', 'Vancouver': 'Canada', 'Montreal': 'Canada', 'Ottawa': 'Canada',
    'Tokyo': 'Japan', 'Osaka': 'Japan', 'Kyoto': 'Japan', 'Yokohama': 'Japan',
    'Berlin': 'Germany', 'Munich': 'Germany', 'Hamburg': 'Germany',
    'Seoul': 'South Korea', 'Busan': 'South Korea',
    'Paris': 'France', 'Lyon': 'France',
    'Sydney': 'Australia', 'Melbourne': 'Australia',
    'Stockholm': 'Sweden', 'Gothenburg': 'Sweden',
    'Amsterdam': 'Netherlands', 'Rotterdam': 'Netherlands',
    'Zurich': 'Switzerland', 'Geneva': 'Switzerland',
    'Helsinki': 'Finland', 'Oslo': 'Norway', 'Copenhagen': 'Denmark'
}

us_states = [
    'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 
    'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 
    'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 
    'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 
    'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'
]

def main():
    # Read suppliers
    with open(suppliers_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    header = reader.fieldnames

    updated_rows = []

    for row in rows:
        addr = row['address']
        addr_lower = addr.lower()
        country_current = row['country']
        
        # 1. Check for US state indicator (case-insensitive)
        is_us_addr = False
        for state in us_states:
            if re.search(r'\b' + state + r'\b', addr, re.IGNORECASE):
                is_us_addr = True
                break
        
        # 2. Look for explicit country in address
        found_country = None
        for name in country_to_iso.keys():
            if re.search(r'\b' + re.escape(name.lower()) + r'\b', addr_lower):
                found_country = name
                break
        
        # 3. Look for city if country not explicitly found
        if not found_country:
            for city, name in city_to_country.items():
                if re.search(r'\b' + re.escape(city.lower()) + r'\b', addr_lower):
                    # Check if it might be a US false positive (like Birmingham, AL)
                    if is_us_addr and city in ['London', 'Birmingham', 'Manchester', 'Dublin']:
                         continue
                    found_country = name
                    break
        
        # Determine target country
        target_country = country_current
        
        # Case: Found a non-US country in address, but no US state/zip indicators
        if found_country and found_country != 'USA' and not (is_us_addr and found_country in city_to_country.values()):
            target_country = found_country
        elif is_us_addr:
            target_country = 'USA'

        # Standardize United Kingdom
        if target_country == 'UK':
            target_country = 'United Kingdom'
            
        # Get ISO ID
        country_id = country_to_iso.get(target_country, '')
        if not country_id:
             if target_country == 'USA': country_id = 'US'
        
        # Final row update
        row['country'] = target_country
        row['country_id'] = country_id
        updated_rows.append(row)

    # Write back to suppliers.csv
    with open(suppliers_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=header)
        writer.writeheader()
        writer.writerows(updated_rows)

    print(f"Refined {len(updated_rows)} suppliers with case-insensitive state matching.")

if __name__ == "__main__":
    main()
