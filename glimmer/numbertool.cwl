#!/usr/bin/env cwl-runner

class: CommandLineTool

hints:
  - class: DockerRequirement
    dockerImageId: 'dukegcb/glimmer'

inputs:
  - id: "#extract_file"
    type: File
    inputBinding:
      position: 1
  - id: "#numbered_orfs_file_name"
    type: string
    default: 'numbered_orfs'
    inputBinding:
      position: 2

outputs:
  - id: "#numbered_orfs_file"
    type: File
    outputBinding:
      glob:
        engine: "cwl:JsonPointer"
        script: "job/numbered_orfs_file_name"

baseCommand: number_orfs.py
