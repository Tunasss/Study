import csv

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'
suppliers_file = r'd:\Study\ERP\LAB\Project\CSV\suppliers.csv'

def main():
    # 1. Load supplier name to ID mapping
    supplier_mapping = {}
    with open(suppliers_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            # Use strip() to handle any accidental whitespace
            name = row['supplier_name'].strip()
            sid = row['supplier_id'].strip()
            supplier_mapping[name] = sid

    # 2. Read products
    with open(products_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)

    # Identify column indices
    try:
        supp_name_idx = header.index('supplier')
    except ValueError:
        print("Error: 'supplier' column not found in products.csv")
        return

    # 3. Update headers: Add supplier_id after supplier
    new_header = list(header)
    new_header.insert(supp_name_idx + 1, 'supplier_id')

    matched_count = 0
    missing_suppliers = set()
    new_rows = []

    for row in rows:
        name = row[supp_name_idx].strip()
        sid = supplier_mapping.get(name, 'UNKNOWN')
        
        if sid == 'UNKNOWN':
            missing_suppliers.add(name)
        else:
            matched_count += 1
            
        new_row = list(row)
        new_row.insert(supp_name_idx + 1, sid)
        new_rows.append(new_row)

    # 4. Write back to products.csv
    with open(products_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(new_header)
        writer.writerows(new_rows)

    print(f"Successfully processed {len(new_rows)} products.")
    print(f"Matched {matched_count} supplier IDs.")
    
    if missing_suppliers:
        print(f"Warning: {len(missing_suppliers)} suppliers not found in mapping:")
        for s in sorted(list(missing_suppliers)):
            print(f"  - {s}")
    else:
        print("All suppliers matched successfully!")

if __name__ == "__main__":
    main()
