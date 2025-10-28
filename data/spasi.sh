# Loop melalui semua item di folder ini yang namanya mengandung spasi
for file in *\ *; do
  # Buat nama baru dengan mengganti spasi menjadi _
  newname=$(echo "$file" | tr ' ' '_') 
  # Cek jika nama baru berbeda DAN nama baru belum ada
  if [[ "$file" != "$newname" ]] && [[ ! -e "$newname" ]]; then
    # Ganti nama file/folder
    mv -- "$file" "$newname" 
    echo "Renamed '$file' -> '$newname'"
  elif [[ -e "$newname" ]]; then
    echo "Skipped '$file': '$newname' already exists"
  fi
done
