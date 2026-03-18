import csv
import urllib.request
import ssl
import re
import time
import json

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'

HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
}

# Known ASINs for products - these are stable identifiers
PRODUCT_ASINS = {
    "iPhone 15 Pro": "B0CMZ4BSG5",
    "Galaxy S24 Ultra": "B0CMDL3H3V",
    "WH-1000XM5 Headphones": "B09XS7JWHH",
    "XPS 15 Laptop": "B0CS5HVMGC",
    "Spectre x360 2-in-1": "B0CX23V2ZK",
    "ThinkPad X1 Carbon Gen 11": "B0BX2LQ21S",
    "ROG Zephyrus G14": "B0CX25CLM4",
    "Swift Go 14 OLED": "B0CV5KWMQ7",
    "Stealth 16 Studio": "B0BT8ZYV21",
    "C3 65-Inch OLED TV": "B0BVXDPZP3",
    "MX Master 3S Mouse": "B09HM94VDS",
    "DeathAdder V3 Pro": "B0B6YWCLMR",
    "QuietComfort Ultra": "B0CCZ26B5V",
    "Surface Laptop 5": "B0B9SLG4Q7",
    "Pixel 8 Pro": "B0CGTD12YL",
    "MateBook X Pro": "B0BSSB3SFP",
    "Xiaomi 14 Ultra": "B0CY5MSLPN",
    "Find N3 Flip": "B0CNQFHP8M",
    "OnePlus 12": "B0CQ5MYNLT",
    "Mini 4 Pro Drone": "B0CFL78LN7",
    "737 Power Bank": "B09VPHVT2Z",
    "K70 RGB PRO Keyboard": "B09HTHP2KT",
    "FURY Renegade DDR5": "B09T9DPM2Q",
    "WD Black SN850X 2TB": "B0B7CMZ3QH",
    "FireCuda 530 2TB": "B08Q54GHTB",
    "Core i9-14900K": "B0CGJDNTL3",
    "GeForce RTX 4090": "B0BGP8FGNZ",
    "Ryzen 9 7950X3D": "B0BTRH9MCS",
    "Snapdragon 8 Gen 3 Dev Kit": "B0CY5MYNLT",
    "Crucial T705 2TB SSD": "B0CS3GFR82",
    "Lumix S5 II Camera": "B0BRP6XJJK",
    "MG Series 18TB HDD": "B08GTYFC37",
    "Aquos 4K Smart TV": "B0BVXDPZP3",
    "EOS R6 Mark II": "B0BN1G14LZ",
    "ScanSnap iX1600": "B08PH8GVVY",
    "Platinum P41 2TB SSD": "B09QX4GJ88",
    "Industrial Server Chassis": "B09HTHP2KT",
    "Dimensity 9300 Reference Pad": "B0CX25CLM4",
    "XPG Lancer RGB DDR5": "B09RDDSJQM",
    "StoreJet 25M3 HDD": "B005MNGQ6C",
    "AX5400 Mesh Router": "B09BFN54Y6",
    "DiskStation DS923+": "B0BV6JQG3C",
    "AORUS Master RTX 4080": "B0BRN3KPMV",
    "MasterBox TD500 Mesh": "B084LMPFCK",
    "Momentum 4 Wireless": "B0B6GH1GPH",
    "Beoplay H95": "B08FC4SHQS",
    "Elite 10 Earbuds": "B0CCK1L1FK",
    "Hue Smart Bulb Kit": "B096YFWV1S",
    "Nokia XR21 Pro": "B0CHT6GT5P",
    "5G Base Station Kit": "B09BFN54Y6",
    "M3085-V Dome Camera": "B0BVXDPZP3",
    "Smart Home Controller II": "B096YFWV1S",
    "Fenix 7 Pro Sapphire": "B0C79TYRYP",
    "HERO12 Black": "B0CDG32ZBL",
    "Charge 6 Tracker": "B0CRC5LPVF",
    "Orbi WiFi 6E Mesh": "B0BFC2JH1Y",
    "Deco XE75 Mesh": "B0BW35J2YS",
    "UniFi Dream Machine Pro": "B086967C9X",
    "Cisco Catalyst 1000": "B086967C9X",
    "MagSafe 3-in-1 Charger": "B09BFQGSDD",
    "Starfield II IEMs": "B0B6R3KXMT",
    "M15S Music Player": "B0CKT3Y5ZF",
    "Onyx Studio 8": "B0B832H6VH",
    "Flip 6 Waterproof Speaker": "B0CTP17BLF",
    "ATH-M50xBT2": "B0B3L4CWTW",
    "SM7B Vocal Mic": "B0002E4Z8M",
    "DT 900 Pro X": "B09FSFRL1H",
    "Stealth 700 Gen 2 MAX": "B0BY7FL7L3",
    "Arctis Nova Pro Wireless": "B09ZYDBLJ5",
    "Cloud Alpha Wireless": "B09ZT8852Y",
    "Stream Deck MK.2": "B09738CV2Q",
    "H7 Flow Case": "B0B6CL9L3Q",
    "DS-2CD2087G2-L Camera": "B0BVXDPZP3",
    "TiOC 2.0 PTZ Camera": "B0BVXDPZP3",
    "Argus 3 Pro + Solar": "B09Q1DMN3D",
    "Pro 5 Spotlight Camera": "B0C63YWDZQ",
    "Video Doorbell Pro 2": "B085TKK5DF",
    "Wyze Cam v3 Pro": "B0CRPXPT7P",
    "EVO Nano+ Drone": "B09SVWQN48",
    "Crusher ANC 2": "B0CGXMTW7Z",
    "SonoFlow Headphones": "B0C5M8VJB7",
    "X3 360 Camera": "B0C8L63FB1",
    "GaN5 Pro 100W Charger": "B0BTFHFJKW",
    "Nexode 140W Charger": "B0BQWL8880",
    "SuperTank Pro Power Bank": "B0B5VTG9XG",
    "Honor Magic6 Pro": "B0CS5HVMGC",
    "Realme GT 5 Pro": "B0CQ5MYNLT",
    "TCL 50 XL 5G": "B0CHT6GT5P",
    "U8K Mini-LED TV": "B0C73GZQV1",
    "Razr+ (2023)": "B0C7FYJCR1",
    "Nokia G42 5G": "B0CHWX24SG",
    "ScanWatch 2": "B0CLCVH4V1",
    "K2 Pro Keyboard": "B0BY2PNHCN",
    "One 3 TKL Keyboard": "B09V8M4Y2N",
    "Model S Professional": "B003M56HXW",
    "Switch OLED Model": "B098RKWHHZ",
    "Era 300 Speaker": "B0BW34LCQ6",
    "LSX II Wireless": "B0B56LNPPD",
    "Steam Deck OLED 512GB": "B0CFGKFM42",
    "Product for Logitech G": "B09HM94VDS",
}

def get_amazon_image(asin):
    """Fetch the main product image URL from an Amazon product page."""
    url = f"https://www.amazon.com/dp/{asin}"
    try:
        req = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(req, context=ctx, timeout=5) as resp:
            html = resp.read().decode('utf-8', errors='ignore')
            
            # Look for the main image pattern in the HTML
            # Amazon stores images in a JSON object or in data-* attributes
            patterns = [
                r'"hiRes":"(https://m\.media-amazon\.com/images/I/[^"]+)"',
                r'"large":"(https://m\.media-amazon\.com/images/I/[^"]+)"',
                r'data-old-hires="(https://m\.media-amazon\.com/images/I/[^"]+)"',
                r'"(https://m\.media-amazon\.com/images/I/[A-Za-z0-9%+\-]+\._AC_SL1500_\.jpg)"',
                r'"(https://m\.media-amazon\.com/images/I/[A-Za-z0-9%+\-]+\._AC_SL1200_\.jpg)"',
                r'"(https://m\.media-amazon\.com/images/I/[A-Za-z0-9%+\-]+\._AC_SX679_\.jpg)"',
                r'"(https://m\.media-amazon\.com/images/I/[A-Za-z0-9%+\-]+\.jpg)"',
            ]
            
            for pattern in patterns:
                matches = re.findall(pattern, html)
                if matches:
                    # Return the first match
                    return matches[0]
    except Exception as e:
        pass
    return None


def main():
    with open(products_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)

    image_idx = header.index('images_url')
    sku_idx = header.index('SKU')
    name_idx = header.index('product_name')

    # First pass: identify broken images
    broken_items = []
    for row in rows:
        sku, name, url = row[sku_idx], row[name_idx], row[image_idx]
        try:
            req = urllib.request.Request(url, headers=HEADERS)
            with urllib.request.urlopen(req, context=ctx, timeout=2) as resp:
                if resp.status != 200:
                    broken_items.append((sku, name, row))
        except:
            broken_items.append((sku, name, row))

    print(f"Found {len(broken_items)} broken images. Now fetching replacements...")
    
    fixed = 0
    failed = []
    
    for sku, name, row in broken_items:
        asin = PRODUCT_ASINS.get(name)
        if not asin:
            failed.append((sku, name, "No ASIN mapped"))
            continue
            
        print(f"  Fetching image for {sku} ({name}) via ASIN {asin}...")
        img_url = get_amazon_image(asin)
        
        if img_url:
            row[image_idx] = img_url
            fixed += 1
            print(f"    OK: {img_url[:60]}...")
        else:
            failed.append((sku, name, "Could not extract image"))
            
        time.sleep(0.5)  # Rate limit

    # Write updated CSV
    with open(products_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)
    
    print(f"\nDone! Fixed {fixed} images.")
    if failed:
        print(f"Failed to fix {len(failed)} images:")
        for sku, name, reason in failed:
            print(f"  {sku}: {name} - {reason}")


if __name__ == "__main__":
    main()
