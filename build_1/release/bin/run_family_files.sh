#!/bin/bash

# verificam daca numele familiei a fost transmis ca argument
if [ -z "$1" ]; then
    echo "Te rog sa specifici numele unei familii ca argument."
    echo "Utilizare: $0 <nume_familie>"
    exit 1
fi

# setam variabilele
FAMILY_NAME="$1"
FAMILY_DIR="../../../downloaded_files/$FAMILY_NAME"
TIMEOUT_DURATION=300  # 5 minute in secunde

# verificam daca directorul familiei exista
if [ ! -d "$FAMILY_DIR" ]; then
    echo "Directorul pentru familia '$FAMILY_NAME' nu exista."
    exit 1
fi

# director pentru fisierele de output
OUTPUT_DIR="${FAMILY_NAME}_outputs"
mkdir -p "$OUTPUT_DIR"

# parcurgem fiecare fisier din directorul familiei
for file in "$FAMILY_DIR"/*; do
    # numele fisierului de output pentru rezultatul fiecarui fisier de input
    base_name=$(basename "$file" .cnf)
    output_file="$OUTPUT_DIR/${base_name}_result.txt"

    echo "Rulez minisat pentru fisierul $file..." >> "$output_file"
    
    ./minisat -cpu-lim="$TIMEOUT_DURATION" "$file" "$output_file" >> "$output_file" 2>&1

    # verificam daca comanda a fost oprita din cauza timeout-ului
    if [ $? -eq 124 ]; then
        echo "Timeout de 5 minute atins pentru fisierul $file" >> "$output_file"
    fi

    echo "===================" >> "$output_file"
done

echo "Executia s-a finalizat. Rezultatele sunt in directorul '$OUTPUT_DIR'."
