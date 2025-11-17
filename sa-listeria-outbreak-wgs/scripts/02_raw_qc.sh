#!/usr/bin/bash
# Script: 02_raw_qc.sh
# Description: Quality assessment of raw sequencing data

RAW_DATA_DIR="../data/raw_data_50"
QC_OUTPUT_DIR="../results/raw_fastqc_reports"

mkdir -p "$QC_OUTPUT_DIR"

echo "Running FastQC on raw data..."
fastqc "$RAW_DATA_DIR"/*.fastq.gz \
  --outdir "$QC_OUTPUT_DIR" \
  --threads 4 \
  --quiet

echo "Generating MultiQC report..."
multiqc "$QC_OUTPUT_DIR" \
  --outdir "$QC_OUTPUT_DIR" \
  --filename "multiqc_report_raw.html" \
  --quiet

echo "✓ Raw QC complete: $QC_OUTPUT_DIR/multiqc_report_raw.html"
