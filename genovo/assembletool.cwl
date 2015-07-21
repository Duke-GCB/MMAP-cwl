#!/usr/bin/env cwl-runner

class: CommandLineTool

requirements:
  - class: CreateFileRequirement
    description: 'Symlinks the input file into the output directory because genovo insists on writing files alongside the input directory'
    fileDef:
      - filename: 'dumpfile.dump'
        fileContent:
          engine: "cwl:JsonPointer"
          script: "job/input"

inputs:
  - id: "#input"
    type: File
    inputBinding:
      position: 1
  - id: "#iterations"
    type: int
    default: 1
    inputBinding:
      position: 2

outputs:
  - id: "#log"
    type: File
    outputBinding:
      glob: log.txt

baseCommand: assemble
stdout: log.txt
