#!/usr/bin/env cwl-runner

class: CommandLineTool

requirements:
  - class: DockerRequirement
    dockerImageId: 'dukegcb/genovo'
  - class: CreateFileRequirement
    description: 'Symlinks the input file into the output directory because genovo insists on writing files alongside the input directory'
    fileDef:
      - filename: 'genovo-input-symlinked.fasta'
        fileContent:
          engine: "cwl:JsonPointer"
          script: "job/input"

inputs:
  - id: "#input"
    type: File
  - id: "#input-symlinked"
    type: string
    default: 'genovo-input-symlinked.fasta'
    inputBinding:
      position: 1
  - id: "#iterations"
    type: int
    default: 10
    inputBinding:
      position: 2

outputs:
  - id: "#log"
    type: File
    outputBinding:
      glob: log.txt
  - id: "#dump"
    type: File
    outputBinding:
      glob: 'genovo-input-symlinked.fasta.dump.best'

baseCommand: assemble
stdout: log.txt
