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

HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
}

def search_bing_for_any_image(query):
    """Search Bing for ANY product image, doesn't need to be Amazon."""
    encoded_query = urllib.request.quote(query + " product high quality")
    url = f"https://www.bing.com/images/search?q={encoded_query}"
    try:
        req = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(req, context=ctx, timeout=10) as resp:
            html = resp.read().decode('utf-8', errors='ignore')
            
            # Extract basic murl (media url) from Bing's image JSON data
            matches = re.findall(r'murl&quot;:&quot;(http[^&]+(?:jpg|png|jpeg))&quot;', html)
            
            if matches:
                # Try to find a working one
                for img_url in matches:
                    if "amazon" in img_url or "static_web" in img_url or "logo" in img_url.lower():
                        continue
                    try:
                        req2 = urllib.request.Request(img_url, headers={'User-Agent': 'Mozilla/5.0'})
                        with urllib.request.urlopen(req2, context=ctx, timeout=3) as resp2:
                            if resp2.status == 200:
                                return img_url
                    except:
                        pass
                
                # If none worked, just return the first one and hope for the best
                return matches[0]
                
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

    fixed_count = 0
    
    print(f"Finding generic images for the final stubborn products...")
    
    for row in rows:
        sku = row[sku_i]
        name = row[name_i]
        current_url = row[img_i]
        
        needs_fetch = False
        if not current_url:
            needs_fetch = True
        else:
            try:
                req = urllib.request.Request(current_url, headers={'User-Agent': 'Mozilla/5.0'})
                with urllib.request.urlopen(req, context=ctx, timeout=3) as resp:
                    if resp.status != 200:
                        needs_fetch = True
            except:
                needs_fetch = True

        if needs_fetch:
            # Fallback query
            time.sleep(1.0)
            sys.stdout.write(f"\rFetching generic image for {sku}: {name[:30]}...")
            sys.stdout.flush()
            
            new_url = search_bing_for_any_image(name)
            if new_url:
                row[img_i] = new_url
                fixed_count += 1
                sys.stdout.write(f"\rFIXED generic {sku}: {name[:30]} -> {new_url[:30]}...\n")
            else:
                sys.stdout.write(f"\rFAIL generic {sku}: {name[:30]}\n")
            sys.stdout.flush()

    # Write updated CSV
    with open(products_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)
    
    print(f"\nDone! Added generic images for {fixed_count} products.")

if __name__ == "__main__":
    main()
