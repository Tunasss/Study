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

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'

def categorize_product(name, old_category):
    name_lower = name.lower()
    old_cat_lower = old_category.lower()

    # Direct matches by name
    if any(x in name_lower for x in ['phone', 'iphone', 'galaxy s', 'pixel', 'smartphone']):
        if 'headphone' not in name_lower and 'earphone' not in name_lower and 'microphone' not in name_lower:
            return 'Smartphones'
    
    if 'gaming laptop' in name_lower:
        return 'Gaming laptops'
    if 'laptop' in name_lower or 'macbook' in name_lower or 'matebook' in name_lower or 'thinkpad' in name_lower:
        return 'Laptops'
    
    if any(x in name_lower for x in ['tablet', 'ipad', 'galaxy tab']):
        return 'Tablets'
    
    if any(x in name_lower for x in ['watch', 'fenix', 'scanwatch']):
        return 'Smartwatches'
    
    if any(x in name_lower for x in ['headphone', 'headset', 'headphones', 'earspeaker']):
        if 'vr' in name_lower or 'mixed reality' in name_lower or 'virtual reality' in name_lower:
            return 'VR headsets'
        return 'Headphones'
        
    if any(x in name_lower for x in ['earbud', 'earphone', 'iem', 'in-ear']):
        return 'Earbuds'
        
    if any(x in name_lower for x in ['speaker', 'soundbar', 'subwoofer', 'studio monitor', 'home automation', 'music system']):
        if 'home automation' in name_lower or 'smart plug' in name_lower:
            return 'Smart home devices'
        if 'studio monitor' in name_lower:
            return 'Speakers'
        return 'Speakers'
        
    if any(x in name_lower for x in ['console', 'switch', 'steam deck', 'playstation', 'xbox', 'playdate']):
        return 'Gaming consoles'
        
    if any(x in name_lower for x in ['monitor', 'display', 'tv', 'television', 'projector', 'screen']):
        if 'studio' in name_lower and 'monitor' in name_lower:
            return 'Speakers'
        return 'Monitors'
        
    if any(x in name_lower for x in ['keyboard']):
        return 'Keyboards'
        
    if any(x in name_lower for x in ['mouse', 'mice', 'model o']):
        return 'Mice'
        
    if any(x in name_lower for x in ['ssd', 'hdd', 'nvme', 'flash drive', 'storage', 'cfexpress', 'sdxc', 'nas', 'diskstation']):
        return 'Storage devices'
        
    if any(x in name_lower for x in ['power bank', 'portable battery', 'powerstation', 'supertank']):
        return 'Power banks'
        
    if any(x in name_lower for x in ['charger', 'charging', 'power station', 'power adapter']):
        if 'power station' in name_lower:
            return 'Power banks'
        return 'Chargers'
        
    if any(x in name_lower for x in ['cable']):
        return 'Cables'
        
    if any(x in name_lower for x in ['smart home', 'thermostat', 'smart bulb', 'hue', 'light panel', 'smart plug', 'smart lock', 'garage door', 'relay', 'smart relay', 'home automation', 'smart hub', 'miniserver']):
        return 'Smart home devices'
        
    if any(x in name_lower for x in ['router', 'mesh', 'wifi', 'wi-fi', 'gateway', 'switch 8-port']):
        if 'nintendo' in name_lower:
            return 'Gaming consoles'
        if 'network switch' in name_lower or 'catalyst' in name_lower:
            return 'Routers'  # Networking gear goes to routers
        if 'switch' in name_lower:
            pass # might be nintendo switch or network switch or keyboard switch
        else:
            return 'Routers'
            
    if any(x in name_lower for x in ['camera', 'security', 'cctv', 'nvr', 'doorbell', 'cam']):
        if 'hero12' in name_lower or 'action' in name_lower or 'lumix' in name_lower or 'eos' in name_lower or 'dslr' in name_lower:
            return 'Security cameras' # No other camera category
        if 'webcam' in name_lower:
            return 'Computer accessories'
        return 'Security cameras'
        
    if any(x in name_lower for x in ['drone', 'dji', 'quadcopter']):
        return 'Drones'
        
    if any(x in name_lower for x in ['vr', 'ar ', 'mixed reality', 'virtual reality', 'quest', 'glasses', 'holographic']):
        if 'ear' not in name_lower:
            return 'VR headsets'
            
    # Category fallback
    if 'gaming' in old_cat_lower and 'laptop' in old_cat_lower:
        return 'Gaming laptops'
    if 'laptop' in old_cat_lower:
        return 'Laptops'
    if 'storage' in old_cat_lower:
        return 'Storage devices'
    if 'display' in old_cat_lower:
        return 'Monitors'
    if 'wearable' in old_cat_lower:
        return 'Smartwatches'
    if 'camera' in old_cat_lower:
        return 'Security cameras' # Fallback
    if 'drone' in old_cat_lower:
        return 'Drones'
    if 'smart home' in old_cat_lower:
        return 'Smart home devices'
    if 'power' in old_cat_lower:
        return 'Chargers'
    if 'security' in old_cat_lower:
        return 'Security cameras'
    if 'router' in old_cat_lower or 'networking' in old_cat_lower:
        return 'Routers'
    
    # Catch-all for PC components, software, equipment, etc.
    return 'Computer accessories'

def main():
    with open(products_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)

    cat_i = header.index('category')
    name_i = header.index('product_name')

    updated = 0
    for row in rows:
        old_cat = row[cat_i]
        new_cat = categorize_product(row[name_i], old_cat)
        if new_cat not in allowed_categories:
            print(f"ERROR: Invalid category mapped '{new_cat}' for {row[name_i]}")
            continue
            
        row[cat_i] = new_cat
        updated += 1

    with open(products_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)

    print(f"Updated {updated} product categories to match master data strictly.")

if __name__ == "__main__":
    main()
