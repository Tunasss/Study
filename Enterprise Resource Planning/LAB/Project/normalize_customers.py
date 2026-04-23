import csv
import re
import os

# Paths
INPUT_FILE = r'd:\Study\ERP\LAB\Project\CSV\customers.csv'
OUTPUT_FILE = r'd:\Study\ERP\LAB\Project\CSV\customers_normalized.csv'

# Common country name to ISO mapping (alpha-2)
country_to_iso = {
    'Vietnam': 'VN', 'USA': 'US', 'China': 'CN', 'Taiwan': 'TW', 'Japan': 'JP',
    'Germany': 'DE', 'France': 'FR', 'United Kingdom': 'GB', 'UK': 'GB',
    'South Korea': 'KR', 'Singapore': 'SG', 'Australia': 'AU'
}

def remove_vietnamese_accents(text):
    if not isinstance(text, str):
        return text
    
    # Mapping of accented characters to non-accented ones
    s1 = u'ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚÝàáâãèéêìíòóôõùúýĂăĐđĨĩŨũƠơƯưẠạẢảẤấẦầẨẩẪẫẬậẮắẰằẲẳẴẵẶặẸẹẺẻẼẽẾếỀềỂểỄễỆệỈỉỊịỌọỎỏỐốỒồỔổỖỗỘộỚớỜờỞởỠỡỢợỤụỦủỨứỪừỬửỮữỰựỲỳỴỵỶỷỸỹ'
    s0 = u'AAAAEEEIIOOOOUUYaaaaeeeiioooouuyAaDdIiUuOoUuAaAaAaAaAaAaAaAaAaAaAaAaEeEeEeEeEeEeEeEeIiIiOoOoOoOoOoOoOoOoOoOoOoOoUuUuUuUuUuUuUuYyYyYyYy'
    
    s = ''
    for char in text:
        if char in s1:
            s += s0[s1.index(char)]
        else:
            s += char
    return s

def main():
    if not os.path.exists(INPUT_FILE):
        print(f"Error: {INPUT_FILE} not found.")
        return

    print(f"Reading {INPUT_FILE}...")
    
    with open(INPUT_FILE, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        fieldnames = list(reader.fieldnames)
        # Place country_id after country
        if 'country_id' not in fieldnames:
            if 'country' in fieldnames:
                idx = fieldnames.index('country')
                fieldnames.insert(idx + 1, 'country_id')
            else:
                fieldnames.append('country_id')
        rows = list(reader)

    print(f"Normalizing {len(rows)} rows and adding country_id...")
    
    normalized_rows = []
    for row in rows:
        new_row = row.copy()
        
        # 1. Accent Removal for name, email, and address
        target_fields = ['customer_name', 'email', 'address']
        for field in target_fields:
            if field in new_row and new_row[field]:
                new_row[field] = remove_vietnamese_accents(new_row[field])
        
        # 2. Email Formatting (already handled by accent removal, but ensure lowercase)
        if 'email' in new_row and new_row['email']:
            new_row['email'] = new_row['email'].lower()
        
        # 3. Standardize 'type' field for Odoo
        # Mapping: Individual -> person, Business -> company
        if 'type' in new_row:
            orig_type = new_row['type'].strip().lower()
            if orig_type == 'individual':
                new_row['type'] = 'person'
            elif orig_type == 'business':
                new_row['type'] = 'company'
        
        # 4. Standardize 'phone' field to international format (+84)
        if 'phone' in new_row and new_row['phone']:
            phone = new_row['phone'].strip()
            # Remove any non-numeric characters except leading +
            phone = re.sub(r'[^0-9+]', '', phone)
            
            if phone.startswith('0'):
                phone = '+84' + phone[1:]
            elif len(phone) == 9 and phone.isdigit():
                phone = '+84' + phone
            elif not phone.startswith('+'):
                # Basic fallback if it doesn't match and isn't international already
                phone = '+84' + phone
            
            new_row['phone'] = phone
            
        # 5. Add country_id mapping
        country_name = new_row.get('country', '').strip()
        new_row['country_id'] = country_to_iso.get(country_name, '') # Default to empty if not found
            
        normalized_rows.append(new_row)

    print(f"Writing normalized data to {OUTPUT_FILE}...")
    
    with open(OUTPUT_FILE, 'w', encoding='utf-8', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(normalized_rows)

    print("Success! Customer data has been normalized with country_id.")
    print(f"File saved to: {OUTPUT_FILE}")

if __name__ == "__main__":
    main()
