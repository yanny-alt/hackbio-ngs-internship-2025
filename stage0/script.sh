#!/bin/bash

# HackBio Stage 0 Biocomputing Assignment
# Author: Favour Igwezeke
# GitHub: https://github.com/yanny-alt/hackbio-ngs-internship-2025/tree/main/stage0
# LinkedIn Video: [YOUR_LINKEDIN_VIDEO_LINK]

# PROJECT 1: BASH BASICS

# 1. Print your name
echo "Favour Igwezeke"

# 2. Create a folder titled your name
mkdir "Favour_Igwezeke"

mkdir biocomputing && cd biocomputing

# 4. Download the 3 files
curl -O https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna
curl -O https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
curl -O https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk

# 5. Move .fna file to name folder
mv wildtype.fna ../Favour_Igwezeke/

# 6. Delete duplicate gbk file
rm wildtype.gbk.1

# 7. Check if .fna file is mutant or wildtype
cd ../Favour_Igwezeke/
grep -q "tatatata" wildtype.fna && echo "MUTANT" || echo "WILDTYPE"

# 8. If mutant, print matching lines to new file
if grep -q "tatatata" wildtype.fna; then
    grep "tatatata" wildtype.fna > mutant_sequences.txt
fi

cd ../biocomputing/

# 9. Count lines in .gbk file (excluding header)
tail -n +2 wildtype.gbk | wc -l

# 10. Print sequence length from LOCUS tag
grep "^LOCUS" wildtype.gbk | awk '{print $3}'

# 11. Print source organism
grep "^  ORGANISM" wildtype.gbk | sed 's/^  ORGANISM  *//'

# 12. List all gene names
grep '/gene=' wildtype.gbk | sed 's/.*\/gene="\([^"]*\)".*/\1/'

# 13. Clear terminal and show command history
clear
history

# 14. List files in both folders
ls -la
ls -la ../Favour_Igwezeke/

# PROJECT 2: BIOINFORMATICS SOFTWARE INSTALLATION

# 1. Activate base conda environment
conda activate base

# 2. Create conda environment named funtools
conda create -n funtools python=3.10 -y

# 3. Activate funtools environment
conda activate funtools

# 4. Install Figlet
conda install -c conda-forge figlet -y

# 5. Run figlet with your name
figlet "Favour Igwezeke"

# 6-13. Install bioinformatics tools
conda install -c bioconda bwa -y
conda install -c bioconda blast -y
conda install -c bioconda samtools -y
conda install -c bioconda bedtools -y
conda install -c bioconda spades -y
conda install -c bioconda bcftools -y
conda install -c bioconda fastp -y
conda install -c bioconda multiqc -y

echo "All bioinformatics tools installed successfully!"

