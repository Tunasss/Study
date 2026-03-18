import csv

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'
categories_file = r'd:\Study\ERP\LAB\Project\CSV\product_categories.csv'

def main():
    # 1. Load category mapping
    cat_mapping = {}
    with open(categories_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            cat_mapping[row['category'].strip()] = row['category_id'].strip()

    # 2. Read products
    with open(products_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)

    # Identify column indices
    sku_idx = header.index('SKU')
    cat_idx = header.index('category')

    # 3. Update headers
    new_header = list(header)
    new_header[sku_idx] = 'product_id'
    # Insert category_id after category
    new_header.insert(cat_idx + 1, 'category_id')

    # 4. Update rows
    new_rows = []
    for i, row in enumerate(rows, start=1):
        new_row = list(row)
        
        # Update product_id
        new_row[sku_idx] = f'PID_{i:04d}'
        
        # Get category_id
        category_name = row[cat_idx].strip()
        category_id = cat_mapping.get(category_name, 'UNKNOWN')
        
        if category_id == 'UNKNOWN':
            print(f"Warning: Category '{category_name}' not found in master list for product {new_row[sku_idx]}")
            
        # Insert category_id
        new_row.insert(cat_idx + 1, category_id)
        new_rows.append(new_row)

    # 5. Write back to products.csv
    with open(products_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(new_header)
        writer.writerows(new_rows)

    print(f"Successfully refactored {len(new_rows)} products.")
    print(f"SKU changed to product_id (PID_xxxx).")
    print(f"category_id column added after category.")

if __name__ == "__main__":
    main()
