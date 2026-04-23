import csv
import urllib.request
import ssl
import re
import time
import sys

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'
report_file = r'd:\Study\ERP\LAB\Project\CSV\fix_report_final.txt'

HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
}

SEARCH_QUERIES = {
    "TNP016": ["Huawei MateBook X Pro 2024 laptop buy", "Huawei MateBook laptop ultrabook premium", "HUAWEI matebook x pro intel core"],
    "TNP018": ["OPPO Find N3 Flip foldable phone buy", "OPPO Find N3 Flip smartphone", "OPPO foldable flip phone N3"],
    "TNP029": ["Qualcomm Snapdragon mobile platform dev kit", "Qualcomm developer kit hardware", "Snapdragon 8 Gen 3 reference phone"],
    "TNP038": ["MediaTek Dimensity chip processor", "MediaTek Dimensity 9300 SoC", "MediaTek chipset mobile processor"],
    "TNP050": ["Ericsson 5G radio unit telecom", "Ericsson AIR 6419 5G", "5G base station radio unit equipment"],
    "TNP058": ["Ubiquiti UniFi Dream Machine SE router", "Ubiquiti UDM Pro network", "UniFi Dream Machine Pro gateway"],
    "TNP059": ["Cisco Catalyst 1000 switch network", "Cisco switch 8-port managed", "Cisco network switch enterprise"],
    "TNP085": ["Zendure SuperTank Pro 100W power bank", "Zendure portable charger 26800", "Zendure SuperTank Pro OLED"],
    "TNP087": ["Realme GT5 Pro 5G phone buy", "Realme flagship smartphone 2024", "Realme GT Neo 6 SE phone"],
    "TNP093": ["Keychron K2 Pro wireless keyboard buy", "Keychron K2 Pro QMK keyboard", "Keychron mechanical wireless keyboard K2"],
    "TNP095": ["Das Keyboard Model S Professional mechanical", "Das Keyboard professional wired", "Das Keyboard cherry MX mechanical"],
}


def search_bing_for_amazon_image(query):
    encoded_query = urllib.request.quote(query + " amazon")
    url = f"https://www.bing.com/images/search?q={encoded_query}"
    try:
        req = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(req, context=ctx, timeout=10) as resp:
            html = resp.read().decode('utf-8', errors='ignore')
            
            patterns = [
                r'https://m\.media-amazon\.com/images/I/([A-Za-z0-9\-_%.+]+)\._[A-Z_0-9]+_\.jpg',
                r'https://m\.media-amazon\.com/images/I/([A-Za-z0-9\-_%.+]+)\.jpg',
            ]
            
            for pattern in patterns:
                matches = re.findall(pattern, html)
                if matches:
                    seen = set()
                    for img_id in matches:
                        if img_id in seen or len(img_id) < 6:
                            continue
                        seen.add(img_id)
                        
                        candidate = f"https://m.media-amazon.com/images/I/{img_id}._AC_SL1500_.jpg"
                        try:
                            req2 = urllib.request.Request(candidate, headers={'User-Agent': 'Mozilla/5.0'})
                            with urllib.request.urlopen(req2, context=ctx, timeout=3) as resp2:
                                if resp2.status == 200:
                                    return candidate
                        except:
                            pass
                        
                        candidate2 = f"https://m.media-amazon.com/images/I/{img_id}.jpg"
                        try:
                            req3 = urllib.request.Request(candidate2, headers={'User-Agent': 'Mozilla/5.0'})
                            with urllib.request.urlopen(req3, context=ctx, timeout=3) as resp3:
                                if resp3.status == 200:
                                    return candidate2
                        except:
                            pass
    except:
        pass
    return None


def main():
    with open(products_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)

    img_i = header.index('images_url')
    sku_i = header.index('SKU')
    name_i = header.index('product_name')

    report = []
    fixed = 0
    
    for idx, row in enumerate(rows):
        sku = row[sku_i]
        if sku not in SEARCH_QUERIES:
            continue
        
        name = row[name_i]
        queries = SEARCH_QUERIES[sku]
        found = False
        
        print(f"Fixing {sku} ({name})...")
        
        for q in queries:
            print(f"  Trying: {q}")
            img_url = search_bing_for_amazon_image(q)
            if img_url:
                row[img_i] = img_url
                fixed += 1
                report.append(f"{sku}: FIXED -> {img_url}")
                print(f"    FIXED: {img_url[:80]}")
                found = True
                break
            time.sleep(2.0)
        
        if not found:
            report.append(f"{sku}: STILL BROKEN")
            print(f"    ALL QUERIES FAILED")
    
    with open(products_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)
    
    report.append(f"\nFixed {fixed} out of {len(SEARCH_QUERIES)} remaining images.")
    
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(report))
    
    print(f"\nDone. Fixed {fixed}/{len(SEARCH_QUERIES)}. Report: {report_file}")


if __name__ == "__main__":
    main()
