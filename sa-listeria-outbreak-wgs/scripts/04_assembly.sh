#!/usr/bin/bash
# Script: 04_assembly.sh
# Description: De novo genome assembly with SPAdes

TRIMMED_DATA_DIR="../data/trimmed_data"
ASSEMBLY_DIR="../results/assembly"

mkdir -p "$ASSEMBLY_DIR"

echo "=== GENOME ASSEMBLY WITH SPADES ==="
sample_count=0

for r1 in "$TRIMMED_DATA_DIR"/*_1_trimmed.fastq.gz; do
    base_name=$(basename "$r1" _1_trimmed.fastq.gz)
    r2="${TRIMMED_DATA_DIR}/${base_name}_2_trimmed.fastq.gz"
    
    sample_count=$((sample_count + 1))
    echo "[$sample_count/50] Assembling: $base_name"
    
    sample_outdir="${ASSEMBLY_DIR}/${base_name}"
    mkdir -p "$sample_outdir"
    
    spades.py \
        -1 "$r1" \
        -2 "$r2" \
        -o "$sample_outdir" \
        --careful \
        --isolate \
        --phred-offset 33 \
        -t 4 \
        --memory 32
    
    if [ -f "${sample_outdir}/contigs.fasta" ]; then
        echo "✓ Assembly successful"
    else
        echo "✗ Assembly failed"
    fi
done

echo "=== Assembly Summary: $sample_count samples processed ==="
