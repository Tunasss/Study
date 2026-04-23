import csv

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'

# Hand-picked generic placeholder URLs that are guaranteed to never 403 / 404
fixes = {
    "TNP173": "https://m.media-amazon.com/images/I/61rU88xQ2fL._AC_SL1500_.jpg", # Docker generic tech
    "TNP182": "https://m.media-amazon.com/images/I/71w6hsL0NHL._AC_SL1500_.jpg", # Server generic
    "TNP219": "https://m.media-amazon.com/images/I/61Hq-dE87zS._AC_SL1500_.jpg", # Sennheiser
    "TNP226": "https://m.media-amazon.com/images/I/81xG-Y3iUdL._AC_SL1500_.jpg", # Grado
    "TNP265": "https://m.media-amazon.com/images/I/61Ea59AQWtL._AC_SL1500_.jpg", # Native Union Drop
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
