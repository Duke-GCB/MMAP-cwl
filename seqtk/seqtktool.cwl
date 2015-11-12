#!/usr/bin/env cwl-runner

class: CommandLineTool

inputs:
  - id: "#input_fastq_file"
    type: File
    description: 'Input FASTQ file'
    inputBinding:
      position: 1

outputs:
  - id: "#output_fasta_file"
    type: File
    outputBinding:
      glob:
        output.fasta

baseCommand: ["seqtk", "seq", "-A"]
stdout: output.fasta
