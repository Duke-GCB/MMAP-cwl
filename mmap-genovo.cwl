#!/usr/bin/env cwl-runner

class: Workflow
description: "MMAP: Microbial Metagenomic Analysis Pipeline"
requirements:
  - class: SubworkflowFeatureRequirement

inputs:
  - id: "#input_fasta_file"
    type: File
    description: "FASTA file containing reads to assemble"
  - id: "#output_contigs_file_name"
    type: string
    description: "Output contigs file"
outputs:
  - id: "#output_contigs_file"
    type: File
    description: "Results file"
    source: "#genovo.output_contigs_file"

steps:
  - id: "#genovo"
    run: { import: genovo/genovo.cwl }
    inputs:
    - { id: "#genovo.input_fasta_file", source: "#input_fasta_file" }
    - { id: "#genovo.output_contigs_file_name", source: "#output_contigs_file_name" }
    outputs:
    - { id: "#genovo.output_contigs_file" }

