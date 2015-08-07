#!/usr/bin/env cwl-runner

class: CommandLineTool

requirements:
  - class: DockerRequirement
    dockerImageId: 'dukegcb/genovo'
  - class: CreateFileRequirement
    description: 'Symlinks the input file into the output directory because genovo insists on writing files alongside the input directory'
    fileDef:
      - filename: 'dump_file_symlinked.dump.best'
        fileContent:
          engine: "cwl:JsonPointer"
          script: "job/dump_file"

inputs:
  - id: "#cutoff"
    type: int
    default: 250
    inputBinding:
      position: 1
  - id: "#contigs_file_name"
    type: string
    inputBinding:
      position: 2
  - id: "#dump_file"
    type: File
  - id: "#dump_file-symlinked"
    type: string
    default: 'dump_file_symlinked.dump.best'
    inputBinding:
      position: 3

outputs:
  - id: "#log"
    type: File
    outputBinding:
      glob: finalize.txt
  - id: "#contigs_file"
    type: File
    outputBinding:
      glob:
        engine: cwl:JsonPointer
        script: /job/contigs_file_name

baseCommand: finalize
stdout: finalize.txt
