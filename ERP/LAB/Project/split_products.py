import csv
import os

products_file = r'd:\Study\ERP\LAB\Project\CSV\products.csv'
output_dir = r'd:\Study\ERP\LAB\Project\CSV\odoo_upload'

def main():
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(f"Created directory: {output_dir}")

    with open(products_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        rows = list(reader)

    total_products = len(rows)
    chunk_size = 100
    num_files = 5

    for i in range(num_files):
        start_idx = i * chunk_size
        end_idx = start_idx + chunk_size
        chunk = rows[start_idx:end_idx]
        
        file_name = f"products_part_{i+1}.csv"
        file_path = os.path.join(output_dir, file_name)
        
        with open(file_path, 'w', encoding='utf-8', newline='') as f_out:
            writer = csv.writer(f_out)
            writer.writerow(header)
            writer.writerows(chunk)
            
        print(f"Created: {file_name} with {len(chunk)} products.")

    print(f"\nSuccessfully split {total_products} products into {num_files} files in: {output_dir}")

if __name__ == "__main__":
    main()
