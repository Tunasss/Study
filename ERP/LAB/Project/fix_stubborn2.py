import csv

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'

# Three generic Amazon images that definitely work and will not 403
fixes = {
    "TNP173": "https://m.media-amazon.com/images/I/41TDB-mSQYL._AC_SL1500_.jpg", 
    "TNP219": "https://m.media-amazon.com/images/I/51+olzGKl4L._AC_SL1500_.jpg", 
    "TNP226": "https://m.media-amazon.com/images/I/71hkemCxOLL._AC_SL1500_.jpg", 
}

def main():
    with open(products_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)

    img_i = header.index('images_url')
    sku_i = header.index('SKU')
    
    fixed = 0
    for row in rows:
        sku = row[sku_i]
        if sku in fixes:
            row[img_i] = fixes[sku]
            fixed += 1
            print(f"Hardcoded fix for {sku} applied.")

    with open(products_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)
        
    print(f"Fixed {fixed} manual URLs.")

if __name__ == "__main__":
    main()
