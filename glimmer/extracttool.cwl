#!/usr/bin/env cwl-runner

class: CommandLineTool

requirements:
  - class: DockerRequirement
    dockerImageId: 'dukegcb/glimmer'

inputs:
  - id: "#contigs_file"
    type: File
    inputBinding:
      position: 1
  - id: "#coords_file"
    type: File
    inputBinding:
      position: 2

outputs:
  - id: "#extract_file"
    type: File
    outputBinding:
      glob: '*.extract'

baseCommand: extract
stdout: glimmer.extract
