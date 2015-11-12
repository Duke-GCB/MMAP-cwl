#!/bin/bash

FASTQ_FILE=$1
OUTPUT_DIR=$2
OUTPUT_FILE=$(basename $FASTQ_FILE).mmap_results.csv
echo "Starting MMAP for $FASTQ_FILE, results in $OUTPUT_FILE"

# All command-line binaries must be in PATH for CWL baseCommand to find them
BASEPATH="/winhomes/dcl9/mmap-bin/"

## fastx-toolkit
# fastq_to_fasta
export PATH="$BASEPATH/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64/bin:$PATH"

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
  /home/dcl9/mmap-cwl/mmap-fastq.cwl \
  --input_fastq-gz_file $FASTQ_FILE \
  --blast_db_dir /home/dcl9/mmap-cwl-data/input/go-blastdb \
  --blast_db_name go-seqdb \
  --output_goterms_file_name $OUTPUT_FILE


