#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=4:00:00
#SBATCH --partition=largemem
#SBATCH --account=xxx         
#SBATCH --mem=36G

module load sortmerna

indexdb_rna --ref ref_db/silva-euk-28s-id98.fasta,ref_db/index_silva-euk-28s-id98
indexdb_rna --ref ref_db/silva-euk-18s-id95.fasta,ref_db/index_silva-euk-18s-id95
