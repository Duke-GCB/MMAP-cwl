#!/usr/bin/env cwl-runner

class: Workflow
description: "Megagenomic de novo Sequencing"

inputs:
  - id: "#input_fasta_file"
    type: File
    description: "FASTA file containing reads to assemble"
  - id: "#assemble_iterations"
    type: int
    default: 10
    description: "The number of iterations to run when assembling"
  - id: "#finalize_cutoff"
    type: int
    default: 250
    description: "The minimum length to use when outputting assembled contigs"
  - id: "#output_contigs_file_name"
    type: string
    description: "The name of the results file to contain contigs after assembly"

outputs:
  - id: "#output_contigs_file"
    type: File
    description: "Results file, to contain contigs"
    source: "#finalize.contigs_file"

steps:
  - id: "#assemble"
    run: { import: assembletool.cwl }
    inputs:
    - { id: "#assemble.fasta_file", source: "#input_fasta_file" }
    - { id: "#assemble.iterations", source: "#assemble_iterations" }
    outputs:
    - { id: "#assemble.dump_file" }
  - id: "#finalize"
    run: { import: finalizetool.cwl }
    inputs:
    - { id: "#finalize.dump_file", source: "#assemble.dump_file" }
    - { id: "#finalize.cutoff", source: "#finalize_cutoff" }
    - { id: "#finalize.contigs_file_name", source: "#output_contigs_file_name" }
    outputs:
    - { id: "#finalize.contigs_file" }

