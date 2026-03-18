import csv
import re

allowed_categories = [
    "Smartphones", "Laptops", "Tablets", "Smartwatches", "Headphones",
    "Earbuds", "Speakers", "Gaming laptops", "Gaming consoles",
    "Computer accessories", "Monitors", "Keyboards", "Mice",
    "Storage devices", "Power banks", "Chargers", "Cables",
    "Smart home devices", "Routers", "Security cameras", "Drones",
    "VR headsets"
]

def get_correct_category(name, supplier):
    n = name.lower()
    s = supplier.lower()
    
    # 1. Smartphones (Specific models + distinct phone keywords)
    if any(x in n for x in ['iphone', 'galaxy s', 'pixel 8', 'xiaomi 14', 'find n3', 'oneplus 12', 'realme gt', 'magic6', 'razr', 'nokia xr', 'nokia g42', 'fairphone', 'nothing phone']):
        return "Smartphones"
    if 'smartphone' in n:
        return "Smartphones"
    # match phone as a word
    if re.search(r'\bphone\b', n) and 'headset' not in n and 'headphone' not in n:
        return "Smartphones"
            
    # 2. Gaming Laptops
    if 'gaming laptop' in n or any(x in n for x in ['zephyrus', 'stealth 16', 'razer blade', 'strix', 'predator', 'legion 5', 'victus']):
        return "Gaming laptops"
    
    # 2b. Laptops
    if any(x in n for x in ['laptop', 'macbook', 'spectre x360', 'thinkpad', 'matebook', 'surface laptop', 'lemur pro', 'nightsky']):
        return "Laptops"
        
    # 3. Tablets
    if any(x in n for x in ['ipad', 'galaxy tab', 'tablet']):
        return "Tablets"
    if re.search(r'\bpad\b', n) and 'mousepad' not in n and 'cooling pad' not in n and 'notebook' not in n:
        return "Tablets"
        
    # 4. Smartwatches
    if any(x in n for x in ['watch', 'fenix 7', 'fitbit', 'smartwatch', 'vantage v3', 'amazfit t-rex', 'ticwatch', 'oura ring', 'whoop 4.0']):
        if 'switch' not in n:
            return "Smartwatches"
        
    # 5. Headphones
    if any(x in n for x in ['wh-1000xm5', 'quietcomfort', 'momentum 4', 'beoplay h95', 'ath-m50x', 'dt 900', 'stealth 700', 'nova pro', 'cloud alpha', 'crusher', 'sonoflow', 'px8', 'ie 600', 'mw75', 'arya', 'motif', 'sr325', '109 pro', 'trifecta', 'atrium', 'stealth planar', 'diana tc', 'kublai khan', 'pc38x', 'headphone', 'earspeaker']):
        if 'earbud' not in n and 'buds' not in n:
            return "Headphones"
            
    # 6. Earbuds
    if any(x in n for x in ['earbud', 'buds', 'airpods', 'elite 10', 'starfield', 'between 3anc', 'ze8000', 'air pro', 'track air', 'blessing 3', 'zs10 pro', 'zero iem', 'oxygen', 'zex pro']):
        return "Earbuds"
        
    # 7. Speakers
    if any(x in n for x in ['speaker', 'soundbar', 'onyx studio', 'flip 6', 'era 300', 'lsx ii', 'signa s4', 'hs8 studio', 'phantom i', 'r410', 'c10 mkii', 'vifa oslo', 'monolith 10']):
        return "Speakers"
        
    # 9. Gaming consoles
    if any(x in n for x in ['switch oled', 'steam deck', 'handheld', 'playdate', 'analogue pocket']):
        return "Gaming consoles"
    if any(x in n for x in ['controller', 'joystick']) and ('xbox' in n or 'ps5' in n or 'switch' in n or 'gaming' in n or 'bluetooth' in s):
        return "Gaming consoles"
        
    # 11. Monitors
    if any(x in n for x in ['monitor', 'c3 65-inch', 'oled tv', 'sharp aquos', 'tv', '4k tv', 'u7k', 'sue9300', 'u5 series', 'planar pxl', 'dm240', 'bvb07', 'ninja v', 'gnv34', 'px277', 'cq27g2', '27c1u', 'm27t20']):
        if 'studio monitor' not in n:
            return "Monitors"
        else:
            return "Speakers"
        
    # 12. Keyboards
    if 'keyboard' in n or 'vulcan ii mini' in n:
        return "Keyboards"
        
    # 13. Mice
    if any(x in n for x in ['mouse', 'mx master', 'deathadder', 'model o', 'superlight', 'm4 rgb', 'starlight-12', 'outset ax', 'atlantis mini', 'sora v2', 'xm2we', 'x2v2']):
        return "Mice"
        
    # 14. Storage devices
    if any(x in n for x in ['ssd', 'hdd', 'hard drive', 'storage', 'diskstation', 'sn850x', 'firecuda', 't705', 'p41', 'mg series', 'nas', 'storejet', 'rocket 4', 'cfexpress', 'sdxc', 'xs70', 'vp4300', 'thunderblade', 'rugged ssd', 'cs3140', 'g-drive', 'armoratd', 'usb flash', 'canvio', 'nem-pa', 'satadom', 'as340']):
        return "Storage devices"
        
    # 15. Power banks
    if any(x in n for x in ['power bank', 'portable battery', 'powerstation', 'supertank', 'omni 20', 'explorer 1000', 'yeti 1000', 'ac200max', 'superbase', 'champ portable']):
        return "Power banks"
        
    # 16. Chargers
    if any(x in n for x in ['charger', 'gan charger', 'nexode', '3-in-1 wireless', 'base one max', 'archybrid', 'magmount', 'power station', '65w fast', 'ups pro', 'vps', 'lcd 1500va']):
        return "Chargers"
        
    # 17. Cables
    if 'cable' in n:
        return "Cables"
        
    # 18. Smart home devices
    if any(x in n for x in ['smart home', 'thermostat', 'smart bulb', 'hue', 'light kit', 'light panel', 'smart lock', 'Shapes', 'dimmer', 'smart plug', 'garage door', 'relay', 'smart relay', 'hubitat', 'homey pro', 'miniserver', 'curtain rod', 'shelly rgbw2', 'iota security kit']):
        return "Smart home devices"
        
    # 19. Routers
    if any(x in n for x in ['router', 'mesh router', 'mesh system', 'deco xe75', 'orbi', 'dream machine', 'catalyst 1000', 'velo pro', 'nova mw12', 'halo h80x', 'vigor 2865', 'fritz!box', 'nwa50ax', 'beryl ax', 'balance 20x', 'ecw220']):
        return "Routers"
        
    # 20. Security cameras
    if any(x in n for x in ['camera', 'doorbell', 'cam', 'nvr', 'security system', 'floodlight', 'gimbal', 'stabilizer']):
        if any(x in n for x in ['eos r6', 'lumix s5', 'insta360', 'brave 7', 'spectacles', 'cv503']):
             return "Computer accessories"
        return "Security cameras"
        
    # 21. Drones
    if any(x in n for x in ['drone', 'mini 4 pro', 'matrice', 'skydio', 'anafi', 'alta x', 'zino', 'poweregg', 'ev200d', 'cetus pro', 'hs720e', 'atom 3-axis', 'tello', 'fimi x8']):
        return "Drones"
        
    # 22. VR headsets
    if any(x in n for x in ['vr headset', 'quest', 'vive xr', 'pico 4', 'magic leap', 'varjo aero', 'tilt five', 'holographic', 'beyond vr', 'blade 2', 'smart glasses', 'ar 2 glasses', 'mixed reality', 'tactsuit']):
        return "VR headsets"

    return "Computer accessories"

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'

def main():
    with open(products_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)

    cat_i = header.index('category')
    name_i = header.index('product_name')
    supp_i = header.index('supplier')

    updated = 0
    for row in rows:
        old_cat = row[cat_i]
        new_cat = get_correct_category(row[name_i], row[supp_i])
        
        # Verify and apply
        if new_cat != old_cat:
            row[cat_i] = new_cat
            updated += 1
            print(f"Update: {row[0]} | {row[1][:30]} | {old_cat} -> {new_cat}")

    with open(products_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)

    print(f"\nFinal: Updated {updated} categories for better accuracy and strict master data alignment.")

if __name__ == "__main__":
    main()
