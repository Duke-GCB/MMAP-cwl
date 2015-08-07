#!/usr/bin/env cwl-runner

class: Workflow
description: "Glimmer is a system for finding genes in microbial DNA, especially the genomes of bacteria, archaea, and viruses"

inputs:
  - id: "#input_contigs_file"
    type: File
    description: "FASTA file containing contigs"
  - id: "#output_orfs_file_name"
    type: string
    description: "The name of the results file to contain ORFs after "

outputs:
  - id: "#output_orfs_file"
    type: File
    description: "Results file, to contain ORFs"
    source: "#number.numbered_orfs_file"

steps:
  - id: "#glimmer"
    run: { import: glimmertool.cwl }
    inputs:
    - { id: "#glimmer.contigs_file", source: "#input_contigs_file" }
    outputs:
    - { id: "#glimmer.coords_file" }
  - id: "#extract"
    run: { import: extracttool.cwl }
    inputs:
    - { id: "#extract.contigs_file", source: "#input_contigs_file" }
    - { id: "#extract.coords_file", source: "#glimmer.coords_file" }
    outputs:
    - { id: "#extract.extract_file" }
  - id: "#number"
    run: { import: numbertool.cwl }
    inputs:
    - { id: "#number.extract_file", source: "#extract.extract_file" }
    - { id: "#number.numbered_orfs_file_name", source: "#output_orfs_file_name" }
    outputs:
    - { id: "#number.numbered_orfs_file" }

