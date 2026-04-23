import csv
import urllib.request
import ssl
import re
import time
import sys
import threading

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'
report_file = r'd:\Study\ERP\LAB\Project\CSV\fix_report_400.txt'

HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
}

def search_bing_for_amazon_image(query):
    """Search Bing for Amazon product image."""
    encoded_query = urllib.request.quote(query + " amazon")
    url = f"https://www.bing.com/images/search?q={encoded_query}"
    try:
        req = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(req, context=ctx, timeout=10) as resp:
            html = resp.read().decode('utf-8', errors='ignore')
            
            # Extract Amazon image IDs
            pattern = r'https://m\.media-amazon\.com/images/I/([A-Za-z0-9\-_%.+]+)\._[A-Z_0-9]+_\.jpg'
            matches = re.findall(pattern, html)
            
            if not matches:
                pattern2 = r'https://m\.media-amazon\.com/images/I/([A-Za-z0-9\-_%.+]+)\.jpg'
                matches = re.findall(pattern2, html)
            
            if matches:
                seen = set()
                for img_id in matches:
                    if img_id in seen or len(img_id) < 6:
                        continue
                    seen.add(img_id)
                    
                    # Try _AC_SL1500_ suffix first (high quality)
                    candidate = f"https://m.media-amazon.com/images/I/{img_id}._AC_SL1500_.jpg"
                    try:
                        req2 = urllib.request.Request(candidate, headers={'User-Agent': 'Mozilla/5.0'})
                        with urllib.request.urlopen(req2, context=ctx, timeout=3) as resp2:
                            if resp2.status == 200:
                                return candidate
                    except:
                        pass
                    
                    # Try plain .jpg
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

class ThreadSafeWriter:
    def __init__(self, filename):
        self.filename = filename
        self.lock = threading.Lock()
    
    def log(self, text):
        with self.lock:
            with open(self.filename, 'a', encoding='utf-8') as f:
                f.write(text + "\n")

def process_product(idx, row, img_i, sku_i, name_i, supp_i, results_lock, fixed_count, failed_count, logger):
    sku = row[sku_i]
    name = row[name_i]
    supplier = row[supp_i]
    current_url = row[img_i]
    
    # Only process if URL is empty or broken
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
            
    if not needs_fetch:
        return

    # Use brand + product name for max precision
    query = f"{supplier} {name}"
    
    # Very minor rate limiting logic applied via thread sleeping later
    img_url = search_bing_for_amazon_image(query)
    
    with results_lock:
        if img_url:
            row[img_i] = img_url
            fixed_count[0] += 1
            logger.log(f"{sku}: OK -> {img_url}")
            sys.stdout.write(f"\rFIXED {sku}: {name[:30]} -> {img_url[-25:]}\n")
        else:
            failed_count[0] += 1
            logger.log(f"{sku}: FAILED")
            sys.stdout.write(f"\rFAIL  {sku}: {name[:30]}\n")
        sys.stdout.flush()

def main():
    open(report_file, 'w').close()  # clear report
    logger = ThreadSafeWriter(report_file)

    with open(products_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)

    img_i = header.index('images_url')
    sku_i = header.index('SKU')
    name_i = header.index('product_name')
    supp_i = header.index('supplier')

    fixed_count = [0]
    failed_count = [0]
    results_lock = threading.Lock()
    
    threads = []
    
    print(f"Checking images for 500 products...")
    
    # Use a thread pool limit so we don't get IP banned
    from concurrent.futures import ThreadPoolExecutor
    
    # 5 concurrent workers max to avoid aggressive Bing blocking
    with ThreadPoolExecutor(max_workers=5) as executor:
        for idx, row in enumerate(rows):
            executor.submit(process_product, idx, row, img_i, sku_i, name_i, supp_i, results_lock, fixed_count, failed_count, logger)

    # Write updated CSV
    with open(products_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)
    
    summary = f"\nDone! Fetched/Updated: {fixed_count[0]}, Failed: {failed_count[0]}"
    logger.log(summary)
    print(summary)
    print(f"Report: {report_file}")


if __name__ == "__main__":
    main()
