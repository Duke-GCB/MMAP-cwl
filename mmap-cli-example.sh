#!/bin/bash
#
#SBATCH --job-name=MMAP_cwl_example
#SBATCH --output=MMAP_cwl_example.out
#SBATCH --mail-user=dan.leehr@duke.edu
#SBATCH --mail-type=FAIL
#SBATCH --mem=1024

INPUT_DIR=/home/dcl9/mmap-cwl-data/example/input
INPUT_FILES=($INPUT_DIR/*.fasta)

FASTA_FILE=${INPUT_FILES[0]}
OUTPUT_BASE=$(basename $FASTA_FILE)
OUTPUT_CSV_FILE=${OUTPUT_BASE}.mmap_results.csv
OUTPUT_DIR=/home/dcl9/mmap-cwl-data/example/output/${OUTPUT_BASE}
mkdir -p $OUTPUT_DIR

srun mmap-run-single.sh $FASTA_FILE $OUTPUT_DIR
