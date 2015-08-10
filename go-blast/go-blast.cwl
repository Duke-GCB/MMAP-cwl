#!/usr/bin/env cwl-runner

class: Workflow
description: "NCBI BLAST+ querying local blast protein database of GO terms"

inputs:
  - id: "#input_orfs_file"
    type: File
    description: "File containing sequence ORFs to query"
  - id: "#blast_db_name"
    type: string
    description: 'Prefix of the BLAST db files'
  - id: "#blast_db_dir"
    type: File
    description: 'Directory containing the BLAST database'
  - id: "#output_goterms_file_name"
    type: string
    description: "The name of the results file containing GO terms extracted"
outputs:
  - id: "#output_goterms_file"
    type: File
    description: "Results file"
    source: "#go_extract.goterms_csv_file"

steps:
  - id: "#go_blast"
    run: { import: go-blasttool.cwl }
    inputs:
    - { id: "#go_blast.db_name", source: "#blast_db_name" }
    - { id: "#go_blast.db_dir", source: "#blast_db_dir" }
    - { id: "#go_blast.query", source: "#input_orfs_file" }
    outputs:
    - { id: "#go_blast.results_file" }
  - id: "#go_extract"
    run: { import: go-extracttool.cwl }
    inputs:
    - { id: "#go_extract.blast_csv", source: "#go_blast.results_file" }
    - { id: "#go_extract.goterms_csv_file_name", source: "#output_goterms_file_name" }
    outputs:
    - { id: "#go_extract.goterms_csv_file" }

