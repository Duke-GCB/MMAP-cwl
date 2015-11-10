#!/bin/bash
#
#SBATCH --job-name=MMAP_cwl_array
#SBATCH --output=MMAP_cwl_%A_%a.out
#SBATCH --error=MMAP_cwl_%A_%a.out
#SBATCH --mail-user=dan.leehr@duke.edu
#SBATCH --mail-type=FAIL
#SBATCH --mem=128000
#SBATCH --array=0-3

# All command-line binaries must be in PATH for CWL baseCommand to find them
BASEPATH="/winhomes/dcl9/mmap-bin/"

## Genovo
# assemble and finalize
export PATH="$BASEPATH/genovo-0.4:$PATH"

## Glimmer
# g3-iterated.csh
export PATH="$BASEPATH/glimmer3.02/scripts:$PATH"
# extract
export PATH="$BASEPATH/glimmer3.02/bin:$PATH"
# number_orfs.py
export PATH="$BASEPATH:$PATH"

## BLAST
# blastx
export PATH="$BASEPATH/ncbi-blast-2.2.31+/bin:$PATH"
# extract_go_terms-cli.py
export PATH="$BASEPATH/extract-go-terms:$PATH"

# CWL is installed in python virtualenv
source ~/env-cwl/bin/activate

inputs=(/data/sciencesupport/mmap/Project_MCK_11177_B01_CUS_WGS.2015-10-30/Sample_LcNi4/fastq/*.fastq.gz)

FASTA_FILE=${inputs[$SLURM_ARRAY_TASK_ID]}
OUTPUT_FILE=$(basename $FASTA_FILE).mmap_results.csv

echo "Starting MMAP for $FASTA_FILE, results in $OUTPUT_FILE"

srun cwltool --preserve-environment PATH \
  --no-container \
  --outdir /home/dcl9/mmap-cwl-data/Sample_LcNi4/output \
  /home/dcl9/mmap-cwl/mmap.cwl \
  --input_fasta_file $FASTA_FILE \
  --blast_db_dir /home/dcl9/mmap-cwl-data/input/go-blastdb \
  --output_goterms_file_name $OUTPUT_FILE

