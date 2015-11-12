#!/usr/bin/env cwl-runner

class: CommandLineTool

inputs:
  - id: "#compressed_file"
    type: File
    description: 'Input compressed file'
    inputBinding:
      position: 2

outputs:
  - id: "#decompressed_file"
    type: File
    outputBinding:
      glob:
        decompressed

baseCommand: ["gunzip", "-c"]
stdout: decompressed
