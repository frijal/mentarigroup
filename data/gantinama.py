import os
from pathlib import Path

# ==== 🛠️ SETTING ====
# Folder awal yang ingin dirapikan
ROOT_DIR = Path(".")  # "." artinya folder tempat skrip dijalankan

# Ubah ke True kalau mau simulasi dulu tanpa mengganti nama
DRY_RUN = False

def rename_recursive(root: Path):
    # Gunakan topdown=False supaya rename folder dari bawah dulu
    for dirpath, dirnames, filenames in os.walk(root, topdown=False):
        # === Ganti nama file ===
        for filename in filenames:
            old_path = Path(dirpath) / filename
            new_name = filename.replace(" ", "_")
            if new_name == filename:
                continue  # skip kalau tidak ada spasi
            new_path = Path(dirpath) / new_name
            if new_path.exists():
                print(f"⚠️  Lewati (sudah ada): {new_path}")
                continue
            print(f"📝 File: {old_path} → {new_path}")
            if not DRY_RUN:
                old_path.rename(new_path)

        # === Ganti nama folder ===
        for dirname in dirnames:
            old_dir = Path(dirpath) / dirname
            new_name = dirname.replace(" ", "_")
            if new_name == dirname:
                continue
            new_dir = Path(dirpath) / new_name
            if new_dir.exists():
                print(f"⚠️  Lewati folder (sudah ada): {new_dir}")
                continue
            print(f"📁 Folder: {old_dir} → {new_dir}")
            if not DRY_RUN:
                old_dir.rename(new_dir)

if __name__ == "__main__":
    print(f"🚀 Memulai rename di: {ROOT_DIR.resolve()}")
    if DRY_RUN:
        print("🔍 Mode: DRY RUN (simulasi saja, tidak mengganti nama sebenarnya)\n")
    rename_recursive(ROOT_DIR)
    print("\n✅ Selesai!")
