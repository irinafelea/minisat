#!/bin/bash

# Verificăm dacă folderul și modul (un fisier sau toate) au fost date ca argumente
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Utilizare: $0 <folder> <mod> [nume_fisier]"
    echo "Moduri disponibile:"
    echo "  single  - rulează pe un singur fișier (specificați numele fișierului)"
    echo "  all     - rulează pe toate fișierele din folder"
    exit 1
fi

# Setăm variabilele de argumente
TARGET_FOLDER="$1"
MODE="$2"

# Verificăm dacă folderul există
if [ ! -d "$TARGET_FOLDER" ]; then
    echo "Folderul '$TARGET_FOLDER' nu există."
    exit 1
fi

# Intrăm în folderul specificat
cd "$TARGET_FOLDER" || exit 1

# Verificăm modul de rulare
if [ "$MODE" == "single" ]; then
    # Verificăm dacă numele fișierului a fost specificat
    if [ -z "$3" ]; then
        echo "Pentru modul 'single', trebuie să specificați numele fișierului."
        exit 1
    fi

    CNF_FILE="$3"

    # Verificăm dacă fișierul există
    if [ ! -f "$CNF_FILE" ]; then
        echo "Fișierul '$CNF_FILE' nu există în folderul '$TARGET_FOLDER'."
        exit 1
    fi

    # Rulăm Minisat pe fișierul specificat și redirecționăm outputul
    base_name="${CNF_FILE%.cnf}"
    ../minisat "$CNF_FILE" "${base_name}_output.txt"
    echo "MiniSat a rulat pe fișierul '$CNF_FILE', iar outputul a fost salvat în '${base_name}_output.txt'."

elif [ "$MODE" == "all" ]; then
    # Parcurgem toate fișierele benchmark*.cnf și rulăm Minisat
    for cnf_file in benchmark*.cnf; do
        if [ ! -e "$cnf_file" ]; then
            continue
        fi

        base_name="${cnf_file%.cnf}"
        ../minisat "$cnf_file" "${base_name}_output.txt"
    done
    echo "MiniSat a rulat pe toate fișierele benchmark*.cnf, iar outputul a fost salvat în fișiere separate."

else
    echo "Mod necunoscut: '$MODE'. Folosiți 'single' sau 'all'."
    exit 1
fi
