import csv
import urllib.request
import ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'
report_file = r'd:\Study\ERP\LAB\Project\CSV\image_report.txt'

with open(products_file, 'r', encoding='utf-8') as f:
    reader = csv.reader(f)
    header = next(reader)
    rows = list(reader)

img_i = header.index('images_url')
sku_i = header.index('SKU')
name_i = header.index('product_name')

broken = []
working = []

for row in rows:
    sku = row[sku_i]
    name = row[name_i]
    url = row[img_i]
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'})
        with urllib.request.urlopen(req, context=ctx, timeout=3) as resp:
            if resp.status == 200:
                working.append(sku)
            else:
                broken.append((sku, name, url))
    except Exception as e:
        broken.append((sku, name, url))

lines = []
lines.append(f"Working: {len(working)}")
lines.append(f"Broken: {len(broken)}")
lines.append("")
for sku, name, url in broken:
    lines.append(f"{sku}|{name}|{url}")

with open(report_file, 'w', encoding='utf-8') as f:
    f.write('\n'.join(lines))
