#!/bin/bash

# Verifica se il numero di argomenti è corretto
if [ $# -ne 1 ]; then
  echo "Usage: $0 input_file.md"
  exit 1
fi

input_file="$1"
output_file="${input_file%.md}.tex"

# Verifica se il file di input esiste
if [ ! -e "$input_file" ]; then
  echo "File not found: $input_file"
  exit 1
fi

# Converti il file da Markdown a LaTeX utilizzando Pandoc
pandoc -f markdown -t latex "$input_file" -o "$output_file"

# Verifica se la conversione è stata eseguita con successo
if [ $? -eq 0 ]; then
  echo "Conversion completed: $output_file"
else
  echo "Conversion failed"
  exit 1
fi
