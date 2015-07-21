#!/usr/bin/env cwl-runner

class: CommandLineTool

requirements:
  - class: DockerRequirement
    dockerImageId: 'dukegcb/genovo'

description: "Megagenomic de novo Sequencing"

inputs:
  - id: "#reads"
    type: File
    inputBinding:
      position: 1
  - id: "#assemble_iterations"
    type: int
    default: 1
    inputBinding:
      position: 2

outputs:
  - id: "#log_file"
    type: File
    outputBinding:
      glob: log.txt
  - id: "#dump_file"
    type: File
    outputBinding:
      glob: '*.dump.best'

baseCommand: assemble
stdout: log.txt
