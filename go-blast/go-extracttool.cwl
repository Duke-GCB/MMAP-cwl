#!/usr/bin/env cwl-runner

class: CommandLineTool

requirements:
  - class: DockerRequirement
    dockerImageId: 'dukegcb/extract-go-terms'

inputs:
  - id: "#blast_csv"
    type: File
    description: 'File of results from blastx in CSV format (10 std stitle)'
    inputBinding:
      position: 1
  - id: "#goterms_csv_file_name"
    type: string
    description: 'Output file to put extracted terms and counts (CSV)'
    default: 'goterms.csv'
    inputBinding:
      position: 2
      prefix: -out
outputs:
  - id: "#goterms_csv_file"
    type: File
    outputBinding:
      glob:
        engine: "cwl:JsonPointer"
        script: "job/goterms_csv_file_name"

baseCommand: extract-go-terms-cli.py
