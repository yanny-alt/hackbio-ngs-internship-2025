#!/bin/bash
# Script: 05_quast_quality.sh
# Description: Assess assembly quality with QUAST

ASSEMBLY_DIR="../results/assembly"
QUAST_DIR="../results/quast_reports"

mkdir -p "$QUAST_DIR"

echo "=== GENOME QUALITY ASSESSMENT WITH QUAST ==="

for assembly_dir in "$ASSEMBLY_DIR"/*; do
    sample_name=$(basename "$assembly_dir")
    contigs_file="$assembly_dir/contigs.fasta"
    
    if [ -f "$contigs_file" ]; then
        echo "Running QUAST for: $sample_name"
        
        quast.py \
            -o "$QUAST_DIR/$sample_name" \
            "$contigs_file" \
            --threads 2 \
            --silent
        
        echo "✓ QUAST completed"
    fi
done

echo "✓ Quality reports saved to: $QUAST_DIR"
