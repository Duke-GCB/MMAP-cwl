#!/bin/bash
#
#SBATCH --job-name=MMAP_cwl_array
#SBATCH --output=MMAP_cwl_%A.out
#SBATCH --mail-user=dan.leehr@duke.edu
#SBATCH --mail-type=FAIL
#SBATCH --mem=250000

FASTQ_FILE=/data/sciencesupport/mmap/Project_MCK_11177_B01_CUS_WGS.2015-11-13/Sample_PcReCp6/analysis/metagenomics/PcReCp6.cleaned.filtered.fastq.gz
OUTPUT_BASE=$(basename $FASTQ_FILE)
OUTPUT_CSV_FILE=${OUTPUT_BASE}.mmap_results.csv
OUTPUT_DIR=/data/sciencesupport/mmap/results/${OUTPUT_BASE}
mkdir -p $OUTPUT_DIR

srun mmap-fastq-run-single.sh $FASTQ_FILE $OUTPUT_DIR
