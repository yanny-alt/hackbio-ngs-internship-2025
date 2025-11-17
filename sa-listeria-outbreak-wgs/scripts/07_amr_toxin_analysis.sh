#!/usr/bin/bash
# Script: 07_amr_toxin_analysis.sh
# Description: Detect AMR and virulence genes with ABRicate

ASSEMBLY_DIR="../results/assembly"
ABRICATE_DIR="../results/abricate_results"

mkdir -p "$ABRICATE_DIR/amr" "$ABRICATE_DIR/toxin" "$ABRICATE_DIR/summary"

echo "=== AMR AND TOXIN GENE DETECTION ==="

for assembly_dir in "$ASSEMBLY_DIR"/*; do
    sample_name=$(basename "$assembly_dir")
    contigs_file="$assembly_dir/contigs.fasta"
    
    if [ -f "$contigs_file" ]; then
        echo "Processing: $sample_name"
        
        # AMR detection (CARD database)
        abricate --db card \
            --quiet \
            "$contigs_file" > "$ABRICATE_DIR/amr/${sample_name}_amr.tsv"
        
        # Virulence detection (VFDB database)
        abricate --db vfdb \
            --quiet \
            "$contigs_file" > "$ABRICATE_DIR/toxin/${sample_name}_toxin.tsv"
        
        echo "✓ Completed"
    fi
done

echo "Generating summary reports..."
abricate --summary "$ABRICATE_DIR/amr"/*.tsv > "$ABRICATE_DIR/summary/amr_summary.csv"
abricate --summary "$ABRICATE_DIR/toxin"/*.tsv > "$ABRICATE_DIR/summary/toxin_summary.csv"

cat "$ABRICATE_DIR/amr"/*.tsv > "$ABRICATE_DIR/summary/all_amr_results.tsv"
cat "$ABRICATE_DIR/toxin"/*.tsv > "$ABRICATE_DIR/summary/all_toxin_results.tsv"

echo "✓ Results saved to: $ABRICATE_DIR/summary/"
