#!/bin/bash

# directorul unde sunt fisierele cu linkuri si directorul de descarcare
LINKS_DIR="family_links"
DOWNLOAD_DIR="downloaded_files"

# cream directorul de descarcare daca nu exista
mkdir -p "$DOWNLOAD_DIR"

# parcurgem fiecare fisier din directorul cu linkuri
for link_file in "$LINKS_DIR"/*.txt; do
    # extragem numele familiei din numele fisierului (fara extensie si cale)
    family_name=$(basename "$link_file" "_links.txt")

    # director temporar pentru descarcare specific familiei
    family_dir="$DOWNLOAD_DIR/$family_name"
    mkdir -p "$family_dir"

    # descarca toate fisierele din lista de linkuri
    wget --content-disposition -i "$link_file" -P "$family_dir"

    # contor pentru redenumire
    count=1

    # parcurgem toate fisierele descarcate pentru familie
    for file in "$family_dir"/*; do
        # verificam tipul de fisier si dezarhivam doar daca este necesar
        if [[ "$file" == *.xz ]]; then
            # decomprimam fisierul .xz direct daca nu este arhiva tar
            unxz "$file"
            extracted_file="${file%.xz}"  # numele fisierului dupa decomprimare
            
            # redenumim fisierul decomprimat
            new_name="${family_name}_${count}.cnf"
            mv "$extracted_file" "$family_dir/$new_name"
            ((count++))
            
        elif [[ "$file" == *.zip ]]; then
            unzip -j "$file" -d "$family_dir"
            for extracted_file in "$family_dir"/*; do
                # verificam daca e un fisier nou si nu este arhiva
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
            # ignoram fisierele care nu sunt arhive cunoscute
            echo "ignoram fisierul necunoscut: $file"
            continue
        fi
    done
done

echo "descarcarea, dezarhivarea si redenumirea fisierelor s-a finalizat."
