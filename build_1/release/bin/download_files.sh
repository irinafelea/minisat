#!/bin/bash

# Directorul unde sunt fișierele cu linkuri și directorul de descărcare
LINKS_DIR="family_links"
DOWNLOAD_DIR="downloaded_files"

# Creăm directorul de descărcare dacă nu există
mkdir -p "$DOWNLOAD_DIR"

# Parcurgem fiecare fișier din directorul cu linkuri
for link_file in "$LINKS_DIR"/*.txt; do
    # Extragem numele familiei din numele fișierului (fără extensie și cale)
    family_name=$(basename "$link_file" "_links.txt")

    # Director temporar pentru descărcare specific familiei
    family_dir="$DOWNLOAD_DIR/$family_name"
    mkdir -p "$family_dir"

    # Descarcă toate fișierele din lista de linkuri
    wget --content-disposition -i "$link_file" -P "$family_dir"

    # Contor pentru redenumire
    count=1

    # Parcurgem toate fișierele descărcate pentru familie
    for file in "$family_dir"/*; do
        # Verificăm tipul de fișier și dezarhivăm doar dacă este necesar
        if [[ "$file" == *.xz ]]; then
            # Decomprimăm fișierul .xz direct dacă nu este arhivă tar
            unxz "$file"
            extracted_file="${file%.xz}"  # Numele fișierului după decomprimare
            
            # Redenumim fișierul decomprimat
            new_name="${family_name}_${count}.cnf"
            mv "$extracted_file" "$family_dir/$new_name"
            ((count++))
            
        elif [[ "$file" == *.zip ]]; then
            unzip -j "$file" -d "$family_dir"
            for extracted_file in "$family_dir"/*; do
                # Verificăm dacă e un fișier nou și nu este arhivă
                if [[ "$extracted_file" != "$file" && "$extracted_file" != *.zip ]]; then
                    new_name="${family_name}_${count}.cnf"
                    mv "$extracted_file" "$family_dir/$new_name"
                    ((count++))
                fi
            done
            rm "$file"
        
        elif [[ "$file" == *.tar.gz || "$file" == *.tar ]]; then
            temp_dir="$family_dir/${family_name}_${count}"
            mkdir -p "$temp_dir"
            tar -xf "$file" -C "$temp_dir"
            
            for extracted_file in "$temp_dir"/*; do
                new_name="${family_name}_${count}.cnf"
                mv "$extracted_file" "$family_dir/$new_name"
                ((count++))
            done
            
            rm -rf "$temp_dir"
            rm "$file"
        else
            # Ignorăm fișierele care nu sunt arhive cunoscute
            echo "Ignorăm fișierul necunoscut: $file"
            continue
        fi
    done
done

echo "Descărcarea, dezarhivarea și redenumirea fișierelor s-a finalizat."
