import sys
import os
import comtypes.client
import tkinter as tk
from tkinter import filedialog, messagebox

def browse_input():
    folder_selected = filedialog.askdirectory()
    if folder_selected:
        entry_input.delete(0, tk.END)
        entry_input.insert(0, folder_selected)

def browse_output():
    folder_selected = filedialog.askdirectory()
    if folder_selected:
        entry_output.delete(0, tk.END)
        entry_output.insert(0, folder_selected)

def start_conversion():
    input_folder = entry_input.get()
    output_folder = entry_output.get()

    if not input_folder or not output_folder:
        messagebox.showwarning("Chú ý", "Vui lòng chọn đầy đủ thư mục đầu vào và đầu ra!")
        return

    try:
        input_folder_path = os.path.abspath(input_folder)
        output_folder_path = os.path.abspath(output_folder)
        
        if not os.path.exists(output_folder_path):
            os.makedirs(output_folder_path)

        input_file_paths = os.listdir(input_folder_path)

        # Khởi tạo PowerPoint
        powerpoint = comtypes.client.CreateObject("Powerpoint.Application")
        
        converted_count = 0
        skipped_count = 0
        
        for input_file_name in input_file_paths:
            if not input_file_name.lower().endswith((".ppt", ".pptx")):
                continue
            
            # Tạo tên file output dự kiến
            file_name = os.path.splitext(input_file_name)[0]
            output_file_path = os.path.join(output_folder_path, file_name + ".pdf")
            
            # --- DÒNG LỆNH KIỂM TRA TRÙNG LẶP ---
            if os.path.exists(output_file_path):
                skipped_count += 1
                continue 
            # ------------------------------------

            input_file_path = os.path.join(input_folder_path, input_file_name)
            
            # Mở và lưu file
            slides = powerpoint.Presentations.Open(input_file_path)
            slides.SaveAs(output_file_path, 32)
            slides.Close()
            converted_count += 1

        powerpoint.Quit()
        
        msg = f"Hoàn thành!\n- Đã chuyển đổi mới: {converted_count} tệp"
        if skipped_count > 0:
            msg += f"\n- Đã bỏ qua (đã tồn tại): {skipped_count} tệp"
            
        messagebox.showinfo("Kết quả", msg)

    except Exception as e:
        messagebox.showerror("Lỗi", f"Có lỗi xảy ra: {str(e)}")

# --- Thiết lập Giao diện (UI) ---
root = tk.Tk()
root.title("PowerPoint to PDF Converter (Author: _tula.26)")
root.geometry("550x280")

# Thư mục đầu vào
tk.Label(root, text="Thư mục PowerPoint đầu vào:", font=("Arial", 10)).pack(pady=(15, 0))
frame_input = tk.Frame(root)
frame_input.pack(fill="x", padx=20)
entry_input = tk.Entry(frame_input)
entry_input.pack(side="left", expand=True, fill="x", padx=(0, 5))
btn_browse_in = tk.Button(frame_input, text="Duyệt...", command=browse_input)
btn_browse_in.pack(side="right")

# Thư mục đầu ra
tk.Label(root, text="Thư mục lưu PDF đầu ra:", font=("Arial", 10)).pack(pady=(15, 0))
frame_output = tk.Frame(root)
frame_output.pack(fill="x", padx=20)
entry_output = tk.Entry(frame_output)
entry_output.pack(side="left", expand=True, fill="x", padx=(0, 5))
btn_browse_out = tk.Button(frame_output, text="Duyệt...", command=browse_output)
btn_browse_out.pack(side="right")

# Nút thực thi
btn_convert = tk.Button(root, text="BẮT ĐẦU CHUYỂN ĐỔI", bg="#4CAF50", fg="white", 
                        font=("Arial", 10, "bold"), height=2, command=start_conversion)
btn_convert.pack(pady=25)

root.mainloop()