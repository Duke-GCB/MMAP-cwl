# MMAP-cwl
Common Workflow Language tool and workflow definitions for MMAP pipeline

Implementation of [MMAP](https://github.com/Duke-GCB/MMAP) pipeline using [CWL](https://github.com/common-workflow-language/common-workflow-language), leveraging docker images built under [MMAP-Docker](https://github.com/Duke-GCB/MMAP-Docker) for [docker-pipeline](https://github.com/Duke-GCB/docker-pipeline)

## First-time setup

1. Install Docker
2. Install the [CWL Reference Implementation](https://github.com/common-workflow-language/common-workflow-language/tree/master/reference/)
3. Clone this repo
4. Generate a BLAST+ database of the GO sequences, using [makeblastdb-go](https://github.com/Duke-GCB/MMAP-Docker/tree/master/makeblastdb-go)
5. Write a job definition JSON file, like [this example](https://github.com/Duke-GCB/MMAP-cwl/blob/master/mmap.json)
- Set the path of the `input_fasta_file` to the file containing the data to analyze
- Set the path of the `blast_db_dir` to the directory containing your BLAST+ database
- Set the name of the `output_goterms_file_name` to your desired output file name

## Running

    cwl-runner /path/to/mmap-cwl/mmap.cwl mmap.json 

