#!/usr/bin/bash
# Script: 03_trim_and_qc.sh
# Description: Trim adapters and reassess quality

RAW_DATA_DIR="../data/raw_data_50"
TRIMMED_DATA_DIR="../data/trimmed_data"
FASTP_REPORT_DIR="../results/fastp_reports"
TRIMMED_QC_DIR="../results/trimmed_fastqc_reports"

mkdir -p "$TRIMMED_DATA_DIR" "$FASTP_REPORT_DIR" "$TRIMMED_QC_DIR"

echo "=== STEP 1: TRIMMING WITH FASTP ==="
for r1 in "$RAW_DATA_DIR"/*_1.fastq.gz; do
    base_name=$(basename "$r1" _1.fastq.gz)
    r2="${RAW_DATA_DIR}/${base_name}_2.fastq.gz"
    
    echo "Processing: $base_name"
    
    fastp \
        -i "$r1" \
        -I "$r2" \
        -o "${TRIMMED_DATA_DIR}/${base_name}_1_trimmed.fastq.gz" \
        -O "${TRIMMED_DATA_DIR}/${base_name}_2_trimmed.fastq.gz" \
        --html "${FASTP_REPORT_DIR}/${base_name}_fastp.html" \
        --json "${FASTP_REPORT_DIR}/${base_name}_fastp.json" \
        --thread 2
done

echo "✓ Trimming complete"

echo "=== STEP 2: POST-TRIM QC ==="
fastqc "$TRIMMED_DATA_DIR"/*.fastq.gz \
  --outdir "$TRIMMED_QC_DIR" \
  --threads 4

multiqc "$TRIMMED_QC_DIR" \
  --outdir "$TRIMMED_QC_DIR" \
  --filename "multiqc_report_trimmed.html"

echo "✓ Trimmed QC complete: $TRIMMED_QC_DIR/multiqc_report_trimmed.html"
