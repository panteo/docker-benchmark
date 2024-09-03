#!/bin/bash

dest="host"
source="/app/input"
if [[ $1 == "cached" ]]; then
  dest="cached"
  cd /benchmark/cached
elif [[ $1 == "default" ]]; then
  dest="default"
  cd /benchmark/default
elif [[ $1 == "delegated" ]]; then
  dest="delegated"
  cd /benchmark/delegated
else
  source="../input"
  cd ./output
fi

echo
echo "Benchmarking $dest..."
sync
inputDirectory=$source
start_time=$(date +%s%3N)
file_count=0
for file in "$inputDirectory"/*.txt; do
  filename=$(basename "$file")
  inputFile="$inputDirectory/$filename"
  outputFile=$filename
  data=$(cat "$inputFile")
  processedData=$(echo "$data" | tr '[:upper:]' '[:lower:]')
  echo "$processedData" > "$outputFile"
  ((file_count++))
done
end_time=$(date +%s%3N)
elapsed_time_ms=$((end_time - start_time))
if (( elapsed_time_ms > 0 )); then
  files_per_second=$(($file_count * 1000 / $elapsed_time_ms))
else
  files_per_second=0
fi
echo "Speed: $files_per_second files per second."
rm *.txt
