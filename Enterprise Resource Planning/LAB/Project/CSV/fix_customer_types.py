import csv
import os

def fix_customer_types(file_path):
    company_keywords = [
        'cong ty', 'tnhh', 'co phan', 'dich vu', 'thuong mai', 
        'cong nghe', 'trung tam', 'doanh nghiep', 'shop', 
        'giai phap', 'nha phan phoi', 'tap doan'
    ]
    
    temp_file = file_path + '.tmp'
    
    with open(file_path, mode='r', encoding='utf-8') as infile, \
         open(temp_file, mode='w', encoding='utf-8', newline='') as outfile:
        
        reader = csv.DictReader(infile)
        writer = csv.DictWriter(outfile, fieldnames=reader.fieldnames)
        writer.writeheader()
        
        for row in reader:
            name_lower = row['customer_name'].lower()
            is_company = any(keyword in name_lower for keyword in company_keywords)
            
            if is_company:
                row['type'] = 'company'
            else:
                row['type'] = 'person'
            
            writer.writerow(row)
            
    os.replace(temp_file, file_path)
    print(f"Updated {file_path} successfully.")

if __name__ == "__main__":
    csv_path = r'd:\Study\ERP\LAB\Project\CSV\customers.csv'
    fix_customer_types(csv_path)
