import csv
import urllib.request
import ssl
import time

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'
log_file = r'd:\Study\ERP\LAB\Project\broken_report.csv'

try:
    with open(products_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)

    image_idx = header.index('images_url')
    sku_idx = header.index('SKU')
    name_idx = header.index('product_name')

    results = []
    print(f'Starting deep check of 100 images...')

    for row in rows:
        sku, name, url = row[sku_idx], row[name_idx], row[image_idx]
        status = "OK"
        try:
            # More realistic headers
            req = urllib.request.Request(url, headers={
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
            })
            with urllib.request.urlopen(req, context=ctx, timeout=5) as resp:
                if resp.status != 200:
                    status = f"HTTP {resp.status}"
        except Exception as e:
            status = str(e)
        
        results.append([sku, name, url, status])
        if status != "OK":
            print(f'BROKEN: {sku} - {status}')
        
        time.sleep(0.05) # Be slightly gentle

    with open(log_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['SKU', 'Name', 'URL', 'Status'])
        writer.writerows(results)
    
    print(f'\nFinished. Report written to {log_file}')

except Exception as e:
    print(f'Script Error: {e}')
