#!/usr/bin/env cwl-runner

class: Workflow
description: "MMAP: Microbial Metagenomic Analysis Pipeline"
requirements:
  - class: SubworkflowFeatureRequirement

inputs:
  - id: "#input_fasta_file"
    type: File
    description: "FASTA file containing reads to assemble"
  - id: "#blast_db_dir"
    type: File
    description: 'Directory containing the BLAST database'
  - id: "#blast_db_name"
    type: string
    description: 'Prefix of the BLAST db files'
  - id: "#output_goterms_file_name"
    type: string
    description: "CSV file containing the GO terms and occurrence counts"
outputs:
  - id: "#output_goterms_file"
    type: File
    description: "Results file"
    source: "#blast.output_goterms_file"

steps:
  - id: "#genovo"
    run: { import: genovo/genovo.cwl }
    inputs:
    - { id: "#genovo.input_fasta_file", source: "#input_fasta_file" }
    outputs:
    - { id: "#genovo.output_contigs_file" }
  - id: "#glimmer"
    run: { import: glimmer/glimmer.cwl }
    inputs:
    - { id: "#glimmer.input_contigs_file", source: "#genovo.output_contigs_file" }
    outputs:
    - { id: "#glimmer.output_orfs_file" }
  - id: "#blast"
    run: { import: go-blast/go-blast.cwl }
    inputs:
    - { id: "#blast.input_orfs_file", source: "#glimmer.output_orfs_file" }
    - { id: "#blast.blast_db_name", source: "#blast_db_name" }
    - { id: "#blast.blast_db_dir", source: "#blast_db_dir" }
    - { id: "#blast.output_goterms_file_name", source: "#output_goterms_file_name" }
    outputs:
    - { id: "#blast.output_goterms_file" }
