#!/bin/bash

# Fișierul original DIMACS
input_dimacs="in.txt"

# Setează variabilele de fixat
variables_to_fix=(1 2 3 4 5)  # Alege câteva variabile pentru fixare
num_combinations=$((2 ** ${#variables_to_fix[@]}))  # Total combinații de valori pentru variabile

# Crează fișiere DIMACS pentru fiecare combinație de valori ale variabilelor
for ((i=0; i<num_combinations; i++)); do
    # Numele fișierului pentru sub-problemă
    output_dimacs="subproblem_$((i + 1)).cnf"

    # Scrie conținutul original în fișierul sub-problemei
    cp "$input_dimacs" "$output_dimacs"

    # Adaugă clauze de fixare pentru fiecare variabilă
    echo "Adaug clauze de fixare pentru $output_dimacs"
    for ((j=0; j<${#variables_to_fix[@]}; j++)); do
        var=${variables_to_fix[$j]}
        # Verificăm dacă variabila va fi `true` sau `false` în această combinație
        if (( (i >> j) & 1 )); then
            echo "$var 0" >> "$output_dimacs"  # Variabila este `true`
        else
            echo "-$var 0" >> "$output_dimacs"  # Variabila este `false`
        fi
    done
done
