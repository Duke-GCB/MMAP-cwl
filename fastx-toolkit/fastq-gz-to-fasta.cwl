#!/usr/bin/env cwl-runner

class: Workflow
description: "Decompresses .fastq.gz and converts to fasta"

inputs:
  - id: "#input_fastq-gz_file"
    type: File
    description: 'Compressed fastq.gz file to convert'

outputs:
  - id: "#output_fasta_file"
    type: File
    description: "Uncompressed fasta from fastq.gz"
    source: "#fastq-to-fasta.fasta_file"

steps:
  - id: "#gunzip"
    run: { import: gunziptool.cwl }
    inputs:
    - { id: "#gunzip.compressed_file", source: "#input_fastq-gz_file" }
    outputs:
    - { id: "#gunzip.decompressed_file" }
  - id: "#fastq-to-fasta"
    run: { import: fastq-to-fastatool.cwl }
    inputs:
    - { id: "#fastq-to-fasta.fastq_file", source: "#gunzip.decompressed_file" }
    outputs:
    - { id: "#fastq-to-fasta.fasta_file" }
