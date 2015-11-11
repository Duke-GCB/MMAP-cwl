#!/bin/bash
#
#SBATCH --job-name=MMAP_cwl_array
#SBATCH --output=MMAP_cwl_%A_%a.out
#SBATCH --mail-user=dan.leehr@duke.edu
#SBATCH --mail-type=FAIL
#SBATCH --mem=128000
#SBATCH --array=0-3

INPUT_DIR=/data/sciencesupport/mmap/Project_MCK_11177_B01_CUS_WGS.2015-10-30/Sample_LcNi4/fastq
INPUT_FILES=($INPUT_DIR/*.fastq.gz)

FASTA_FILE=${INPUT_FILES[$SLURM_ARRAY_TASK_ID]}
OUTPUT_BASE=$(basename $FASTA_FILE)
OUTPUT_CSV_FILE= ${OUTPUT_BASE}.mmap_results.csv
OUTPUT_DIR=/data/sciencesupport/mmap/results/${OUTPUT_BASE}
mkdir -p $OUTPUT_DIR

srun mmap-run-single.sh $FASTA_FILE $OUTPUT_DIR
