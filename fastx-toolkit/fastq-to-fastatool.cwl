#!/usr/bin/env cwl-runner

class: CommandLineTool

requirements:
  - import: ../py-expr-engine/py-expr-engine.cwl

inputs:
  - id: "#fastq_file"
    type: File
    description: 'Input FASTQ file, may be compressed'
    inputBinding:
      position: 1
      prefix: -i
  - id: "#fasta_file_name"
    type: string
    default: "output.fasta"
    description: 'Output FASTA file name'
    inputBinding:
      position: 2
      prefix: -o

outputs:
  - id: "#fasta_file"
    type: File
    outputBinding:
      glob:
        engine: "cwl:JsonPointer"
        script: "job/fasta_file_name"

baseCommand: fastq_to_fasta
