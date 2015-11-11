#!/bin/bash
#
#SBATCH --job-name=MMAP_cwl
#SBATCH --output=MMAP_cwl.out
#SBATCH --mail-user=dan.leehr@duke.edu
#SBATCH --mail-type=FAIL
#SBATCH --mem=16384

source ~/env-cwl/bin/activate
export PATH="/home/dcl9/mmap-bin:$PATH"
srun cwltool --preserve-environment PATH \
  --no-container \
  --outdir /home/dcl9/mmap-cwl-data/output \
  /home/dcl9/mmap-cwl/mmap-align.cwl \
  /home/dcl9/mmap-cwl-data/input/mgm4589537.3.050.json
