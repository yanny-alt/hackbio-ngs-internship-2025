#!/usr/bin/bash
# Script: 01_downsampling.sh
# Description: Randomly select 50 samples from 100

PARENT_DIR="../data/raw_data"
RAW_DATA_50="../data/raw_data_50"

mkdir -p "$RAW_DATA_50"

# Randomly shuffle and select first 50 R1 files
find "$PARENT_DIR" -maxdepth 1 -name "*_1.fastq.gz" | shuf | head -50 | while read r1_file; do
    mv "$r1_file" "$RAW_DATA_50/"
    
    # Move corresponding R2 file
    base_name=$(basename "$r1_file" _1.fastq.gz)
    r2_file="$PARENT_DIR/${base_name}_2.fastq.gz"
    mv "$r2_file" "$RAW_DATA_50/"
done

echo "✓ Downsampling complete: 50 samples selected"
