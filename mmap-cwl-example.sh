#!/bin/bash
#
#SBATCH --job-name=MMAP_cwl_example
#SBATCH --output=MMAP_cwl_example.out
#SBATCH --mail-user=dan.leehr@duke.edu
#SBATCH --mail-type=FAIL
#SBATCH --mem=1024

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
export PATH="$BASEPATH/mmap-bin:$PATH"

## BLAST
# blastx
export PATH="$BASEPATH/ncbi-blast-2.2.31+/bin:$PATH"
# extract_go_terms-cli.py
export PATH="$BASEPATH/extract-go-terms:$PATH"

# CWL is installed in python virtualenv
source ~/env-cwl/bin/activate

srun cwltool --preserve-environment PATH \
  --no-container \
  --outdir /home/dcl9/mmap-cwl-data/example/output \
  /home/dcl9/mmap-cwl/mmap.cwl \
  /home/dcl9/mmap-cwl-data/example/input/MMAP_example.json

