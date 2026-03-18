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
report_file = r'd:\Study\ERP\LAB\Project\CSV\fix_report_all.txt'

HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
}

# Map SKU -> [list of search queries], using brand + exact product name for accuracy
SEARCH_QUERIES = {
    "TNP001": ["Apple iPhone 15 Pro"],
    "TNP002": ["Samsung Galaxy S24 Ultra"],
    "TNP003": ["Sony WH-1000XM5 headphones"],
    "TNP004": ["Dell XPS 15 laptop 2024"],
    "TNP005": ["HP Spectre x360 laptop 2-in-1"],
    "TNP006": ["Lenovo ThinkPad X1 Carbon Gen 11"],
    "TNP007": ["ASUS ROG Zephyrus G14 2024 laptop"],
    "TNP008": ["Acer Swift Go 14 OLED laptop"],
    "TNP009": ["MSI Stealth 16 Studio laptop"],
    "TNP010": ["LG C3 65 inch OLED TV"],
    "TNP011": ["Logitech MX Master 3S mouse"],
    "TNP012": ["Razer DeathAdder V3 Pro mouse"],
    "TNP013": ["Bose QuietComfort Ultra headphones"],
    "TNP014": ["Microsoft Surface Laptop 5"],
    "TNP015": ["Google Pixel 8 Pro phone"],
    "TNP016": ["Huawei MateBook X Pro laptop"],
    "TNP017": ["Xiaomi 14 Ultra smartphone"],
    "TNP018": ["OPPO Find N3 Flip phone"],
    "TNP019": ["OnePlus 12 smartphone"],
    "TNP020": ["DJI Mini 4 Pro drone"],
    "TNP021": ["Anker 737 power bank charger"],
    "TNP022": ["Corsair K70 RGB PRO keyboard"],
    "TNP023": ["Kingston FURY Renegade DDR5 RAM"],
    "TNP024": ["WD Black SN850X 2TB NVMe SSD"],
    "TNP025": ["Seagate FireCuda 530 2TB SSD"],
    "TNP026": ["Intel Core i9-14900K processor"],
    "TNP027": ["NVIDIA GeForce RTX 4090 Founders Edition"],
    "TNP028": ["AMD Ryzen 9 7950X3D processor"],
    "TNP029": ["Qualcomm Snapdragon dev kit"],
    "TNP030": ["Crucial T705 2TB NVMe SSD"],
    "TNP031": ["Panasonic Lumix S5 II camera"],
    "TNP032": ["Toshiba MG Series 18TB HDD"],
    "TNP033": ["Sharp Aquos 4K Smart TV"],
    "TNP034": ["Canon EOS R6 Mark II camera"],
    "TNP035": ["Fujitsu ScanSnap iX1600 scanner"],
    "TNP036": ["SK Hynix Platinum P41 2TB SSD"],
    "TNP037": ["server chassis rackmount 4U"],
    "TNP038": ["MediaTek Dimensity 9300 chipset"],
    "TNP039": ["ADATA XPG Lancer RGB DDR5"],
    "TNP040": ["Transcend StoreJet 25M3 portable HDD"],
    "TNP041": ["D-Link AX5400 mesh WiFi router"],
    "TNP042": ["Synology DiskStation DS923+ NAS"],
    "TNP043": ["Gigabyte AORUS Master RTX 4080 graphics card"],
    "TNP044": ["Cooler Master MasterBox TD500 Mesh case"],
    "TNP045": ["Sennheiser Momentum 4 wireless headphones"],
    "TNP046": ["Bang Olufsen Beoplay H95 headphones"],
    "TNP047": ["Jabra Elite 10 earbuds"],
    "TNP048": ["Philips Hue starter kit smart bulbs"],
    "TNP049": ["Nokia XR21 rugged smartphone"],
    "TNP050": ["Ericsson 5G base station equipment"],
    "TNP051": ["Axis M3085-V dome security camera"],
    "TNP052": ["Bosch smart home controller"],
    "TNP053": ["Garmin Fenix 7 Pro Sapphire Solar watch"],
    "TNP054": ["GoPro HERO12 Black action camera"],
    "TNP055": ["Fitbit Charge 6 fitness tracker"],
    "TNP056": ["Netgear Orbi WiFi 6E mesh system"],
    "TNP057": ["TP-Link Deco XE75 mesh WiFi system"],
    "TNP058": ["Ubiquiti UniFi Dream Machine Pro"],
    "TNP059": ["Cisco Catalyst 1000 series switch"],
    "TNP060": ["Belkin MagSafe 3-in-1 wireless charger"],
    "TNP061": ["Moondrop Starfield II IEM earphones"],
    "TNP062": ["FiiO M15S digital audio player"],
    "TNP063": ["Harman Kardon Onyx Studio 8 speaker"],
    "TNP064": ["JBL Flip 6 portable waterproof speaker"],
    "TNP065": ["Audio-Technica ATH-M50xBT2 headphones"],
    "TNP066": ["Shure SM7B dynamic microphone"],
    "TNP067": ["Beyerdynamic DT 900 Pro X headphones"],
    "TNP068": ["Turtle Beach Stealth 700 Gen 2 MAX headset"],
    "TNP069": ["SteelSeries Arctis Nova Pro wireless headset"],
    "TNP070": ["HyperX Cloud Alpha wireless gaming headset"],
    "TNP071": ["Elgato Stream Deck MK.2 controller"],
    "TNP072": ["NZXT H7 Flow computer case"],
    "TNP073": ["Hikvision DS-2CD2087G2 security camera"],
    "TNP074": ["Dahua TiOC PTZ security camera"],
    "TNP075": ["Reolink Argus 3 Pro solar security camera"],
    "TNP076": ["Arlo Pro 5 spotlight security camera"],
    "TNP077": ["Ring Video Doorbell Pro 2"],
    "TNP078": ["Wyze Cam v3 Pro security camera"],
    "TNP079": ["Autel EVO Nano Plus drone"],
    "TNP080": ["Skullcandy Crusher ANC 2 headphones"],
    "TNP081": ["1MORE SonoFlow SE headphones"],
    "TNP082": ["Insta360 X3 360 action camera"],
    "TNP083": ["Baseus GaN 100W USB-C charger"],
    "TNP084": ["UGREEN Nexode 140W USB-C charger"],
    "TNP085": ["Zendure SuperTank Pro 26800mAh power bank"],
    "TNP086": ["HONOR Magic6 Pro smartphone"],
    "TNP087": ["Realme GT 5 Pro smartphone"],
    "TNP088": ["TCL 50 XL 5G phone"],
    "TNP089": ["Hisense U8K Mini-LED 4K TV"],
    "TNP090": ["Motorola razr plus 2023 foldable phone"],
    "TNP091": ["Nokia G42 5G smartphone"],
    "TNP092": ["Withings ScanWatch 2 smartwatch"],
    "TNP093": ["Keychron K2 Pro mechanical keyboard"],
    "TNP094": ["Ducky One 3 TKL mechanical keyboard"],
    "TNP095": ["Das Keyboard Model S Professional"],
    "TNP096": ["Nintendo Switch OLED Model console"],
    "TNP097": ["Sonos Era 300 spatial audio speaker"],
    "TNP098": ["KEF LSX II wireless speakers"],
    "TNP099": ["Valve Steam Deck OLED 512GB"],
    "TNP100": ["Logitech G Pro X gaming headset"],
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
    failed = 0
    total = len(rows)
    
    print(f"Re-searching images for ALL {total} products...")

    for idx, row in enumerate(rows):
        sku = row[sku_i]
        name = row[name_i]
        
        queries = SEARCH_QUERIES.get(sku, [name])
        
        found = False
        for q in queries:
            sys.stdout.write(f"\r[{idx+1}/{total}] {sku}: {name[:40]}...")
            sys.stdout.flush()
            
            img_url = search_bing_for_amazon_image(q)
            if img_url:
                row[img_i] = img_url
                fixed += 1
                report.append(f"{sku}: OK -> {img_url}")
                found = True
                break
            time.sleep(1.5)
        
        if not found:
            failed += 1
            report.append(f"{sku}: FAILED (kept old URL)")
        
        time.sleep(1.0)

    # Write updated CSV
    with open(products_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)
    
    summary = f"\n\nDone! Updated: {fixed}, Failed: {failed}, Total: {total}"
    report.append(summary)
    print(summary)
    
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(report))
    
    print(f"Report: {report_file}")


if __name__ == "__main__":
    main()
