#!/usr/bin/env cwl-runner

class: CommandLineTool

hints:
  - class: DockerRequirement
    dockerImageId: 'dukegcb/go-blast'

requirements:
  - import: ../py-expr-engine/py-expr-engine.cwl

inputs:
  - id: "#db_name"
    type: string
    description: 'Prefix of the BLAST db files'
  - id: "#db_dir"
    type: File
    description: 'Directory containing the BLAST database'
  - id: "#db"
    type: string
    default: ""
    inputBinding:
      position: 1
      prefix: -db
      valueFrom:
        engine: ../py-expr-engine/py-expr-engine.cwl
        script: |
          os.path.join(self.job['db_dir']['path'], self.job['db_name'])
  - id: "#query"
    type: File
    description: 'Input file containing sequences to query'
    inputBinding:
      position: 2
      prefix: -query
  - id: "#results_file_name"
    type: string
    description: 'Output file to put BLAST results'
    default: 'goblast-terms.out'
    inputBinding:
      position: 3
      prefix: -out
  - id: "#evalue"
    type: string
    default: "1e-15"
    inputBinding:
      position: 4
      prefix: -evalue
  - id: "#seg"
    type: string
    default: "yes"
    inputBinding:
      position: 5
      prefix: -seg
  - id: "#outfmt"
    type: string
    default: "10 std stitle"
    inputBinding:
      position: 6
      prefix: -outfmt

outputs:
  - id: "#results_file"
    type: File
    outputBinding:
      glob:
        engine: "cwl:JsonPointer"
        script: "job/results_file_name"

baseCommand: blastx
