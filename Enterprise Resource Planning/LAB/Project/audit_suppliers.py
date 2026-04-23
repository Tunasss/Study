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
    'Belgium': 'BE', 'Poland': 'PL', 'Israel': 'IL', 'Brazil': 'BR'
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

def audit():
    with open(suppliers_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        mismatches = []
        for row in reader:
            addr = row['address']
            addr_lower = addr.lower()
            country_current = row['country']
            
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

            # Determine predicted country
            predicted = found_country if found_country else country_current
            
            # Standardize names
            if predicted == 'UK': predicted = 'United Kingdom'
            
            if country_current == 'USA' and predicted != 'USA':
                mismatches.append({
                    'id': row['supplier_id'],
                    'name': row['supplier_name'],
                    'address': addr,
                    'current': country_current,
                    'predicted': predicted
                })

    print(f"Audit Complete. Found {len(mismatches)} potential 'USA' label errors.")
    for m in mismatches[:15]:
        print(f"{m['id']} | {m['name']} | Actual: {m['predicted']} (from address) | Was labeled: {m['current']}")

if __name__ == "__main__":
    audit()
