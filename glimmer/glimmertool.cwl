#!/usr/bin/env cwl-runner

class: CommandLineTool

hints:
  - class: DockerRequirement
    dockerImageId: 'dukegcb/glimmer'

inputs:
  - id: "#contigs_file"
    type: File
    inputBinding:
      position: 1
  - id: "#tag"
    type: string
    default: glimmer
    inputBinding:
      position: 2

outputs:
  - id: "#coords_file"
    type: File
    outputBinding:
      glob: '*.coords'

baseCommand: g3-iterated.csh
