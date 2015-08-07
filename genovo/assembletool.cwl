#!/usr/bin/env cwl-runner

class: CommandLineTool

requirements:
  - class: DockerRequirement
    dockerImageId: 'dukegcb/genovo'
  - class: CreateFileRequirement
    description: 'Symlinks the input file into the output directory because genovo insists on writing files alongside the input directory'
    fileDef:
      - filename: 'fasta_file_symlinked.fasta'
        fileContent:
          engine: "cwl:JsonPointer"
          script: "job/fasta_file"

inputs:
  - id: "#fasta_file"
    type: File
  - id: "#fasta_file_symlinked"
    type: string
    default: 'fasta_file_symlinked.fasta'
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
  - id: "#dump_file"
    type: File
    outputBinding:
      glob: 'fasta_file_symlinked.fasta.dump.best'

baseCommand: assemble
stdout:
  glob:
    engine: cwl:JsonPointer
    script: /job/log_file
