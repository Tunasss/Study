import csv
import re

suppliers_file = r'd:\Study\ERP\LAB\Project\CSV\suppliers.csv'

# Common country name to ISO mapping (Odoo uses alpha-2)
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

# Mapping for cities/regions to country names if the country isn't explicitly listed
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

def main():
    # Read suppliers
    with open(suppliers_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)

    # Identify column indices
    country_idx = header.index('country')
    addr_idx = header.index('address')
    id_idx = header.index('supplier_id')

    # Update headers: Add country_id after country
    new_header = list(header)
    new_header.insert(country_idx + 1, 'country_id')

    corrected_count = 0
    updated_rows = []

    for row in rows:
        addr = row[addr_idx]
        addr_lower = addr.lower()
        country_current = row[country_idx]
        
        # 1. Look for explicit country in address
        found_country = None
        for name in country_to_iso.keys():
            # check for whole word match to avoid substrings
            if re.search(r'\b' + re.escape(name.lower()) + r'\b', addr_lower):
                found_country = name
                break
        
        # 2. Look for city if country not found
        if not found_country:
            for city, name in city_to_country.items():
                if re.search(r'\b' + re.escape(city.lower()) + r'\b', addr_lower):
                    found_country = name
                    break
        
        # 3. Special case for "UK" or "United Kingdom"
        if not found_country:
            if 'united kingdom' in addr_lower or re.search(r'\buk\b', addr_lower):
                found_country = 'United Kingdom'

        # Determine target country
        target_country = country_current
        if country_current == 'USA' and found_country and found_country != 'USA':
            target_country = found_country
            corrected_count += 1
            print(f"Corrected {row[id_idx]}: {country_current} -> {target_country} (Address: {addr[:30]}...)")
            
        # Standardize United Kingdom
        if target_country == 'UK':
            target_country = 'United Kingdom'
            
        # Get ISO ID
        country_id = country_to_iso.get(target_country, 'US' if target_country == 'USA' else '')
        if not country_id and target_country:
             # Try to find again if standardized name matches
             country_id = country_to_iso.get(target_country, '')
        
        # Final row update
        new_row = list(row)
        new_row[country_idx] = target_country
        new_row.insert(country_idx + 1, country_id)
        updated_rows.append(new_row)

    # Write back to suppliers.csv
    with open(suppliers_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(new_header)
        writer.writerows(updated_rows)

    print(f"\nSuccessfully updated {len(updated_rows)} suppliers.")
    print(f"Corrected {corrected_count} country errors from address analysis.")
    print(f"Added country_id column with ISO codes.")

if __name__ == "__main__":
    main()
