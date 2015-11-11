#!/bin/bash

FASTA_FILE=$1
OUTPUT_DIR=$2
OUTPUT_FILE=$(basename $FASTA_FILE).mmap_results.csv
echo "Starting MMAP for $FASTA_FILE, results in $OUTPUT_FILE"

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

cwltool --preserve-environment PATH \
  --no-container \
  --outdir $OUTPUT_DIR \
  /home/dcl9/mmap-cwl/mmap.cwl \
  --input_fasta_file $FASTA_FILE \
  --blast_db_dir /home/dcl9/mmap-cwl-data/input/go-blastdb \
  --blast_db_name go-seqdb \
  --output_goterms_file_name $OUTPUT_FILE


