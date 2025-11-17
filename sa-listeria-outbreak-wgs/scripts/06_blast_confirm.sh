#!/bin/bash
# Script: 06_blast_confirm.sh
# Description: Confirm organism identity using BLAST

ASSEMBLY_DIR="../results/assembly"
BLAST_DIR="../results/blast"

mkdir -p "$BLAST_DIR"

echo "=== ORGANISM IDENTIFICATION WITH BLAST ==="

# Select first successful assembly as representative
REPRESENTATIVE_ASSEMBLY=$(find "$ASSEMBLY_DIR" -name "contigs.fasta" | head -1)
SAMPLE_NAME=$(basename $(dirname "$REPRESENTATIVE_ASSEMBLY"))

echo "Using representative sample: $SAMPLE_NAME"

# Extract largest contig for BLAST
head -n 200 "$REPRESENTATIVE_ASSEMBLY" > "$BLAST_DIR/representative_contig.fasta"

echo "Running BLAST against NCBI nt database..."
blastn \
    -query "$BLAST_DIR/representative_contig.fasta" \
    -db nt \
    -remote \
    -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle" \
    -max_target_seqs 5 \
    -evalue 1e-50 \
    -out "$BLAST_DIR/blast_results.tsv"

echo "✓ BLAST complete"
echo "Top 5 hits:"
head -5 "$BLAST_DIR/blast_results.tsv" | awk -F'\t' '{printf "%-60s | %s%%\n", $13, $3}'
