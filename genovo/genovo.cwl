#!/usr/bin/env cwl-runner

class: Workflow
description: "Megagenomic de novo Sequencing"

requirements:
  - class: DockerRequirement
    dockerImageId: 'dukegcb/genovo'

inputs:
  - id: "#input"
    type: File
    description: "FASTA file containing reads to assemble"
  - id: "#assemble_iterations"
    type: int
    default: 1
    description: "The number of iterations to run when assembling"
  - id: "#finalize_cutoff"
    type: int
    default: 250
    description: "The minimum length to use when outputting assembled contigs"

outputs:
  - id: "#output"
    type: File
    description: "Results file, to contain contigs"
    source: "#assemble.log"

steps:
  - inputs:
    - { id: "#assemble.input", source: "#input" }
    - { id: "#assemble.iterations", source: "#assemble_iterations" }
    outputs:
    - { id: "#assemble.log" }
    run: { import: assembletool.cwl }
