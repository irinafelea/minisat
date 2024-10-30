#!/bin/bash

# Verificăm dacă un argument (folder) a fost dat
if [ -z "$1" ]; then
    echo "Utilizare: $0 <folder>"
    exit 1
fi

# Definim variabila pentru folderul de intrare
TARGET_FOLDER="$1"

# Verificăm dacă folderul există
if [ ! -d "$TARGET_FOLDER" ]; then
    echo "Folderul '$TARGET_FOLDER' nu există."
    exit 1
fi

# Intra in folderul specificat
cd "$TARGET_FOLDER" || exit 1

# Initializam un contor pentru redenumirea fișierelor dezarhivate
counter=1

# Parcurgem toate fișierele .xz din folder
for archive in *.xz; do
    # Verificăm dacă există fișiere care corespund acestui pattern
    if [ ! -e "$archive" ]; then
        continue
    fi

    # Extragem fișierul .xz
    xz -d "$archive"

    # Obținem numele fișierului dezarhivat
    original_name="${archive%.xz}"

    # Redenumim fișierul extrat cu formatul benchmark<counter>.cnf
    mv "$original_name" "benchmark${counter}.cnf"

    # Incrementăm contorul
    counter=$((counter + 1))
done

echo "Fișierele au fost dezarhivate și redenumite cu succes!"
