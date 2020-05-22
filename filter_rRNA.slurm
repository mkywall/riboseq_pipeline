#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=4:00:00
#SBATCH --partition=largemem
#SBATCH --account=xxx
#SBATCH --mem=36G

module load sortmerna
mkdir rRNA_reads
mkdir no_rRNA_reads 
sortmernaREF=ref_db/silva-euk-28s-id98.fasta,ref_db/index_silva-euk-28s-id98:ref_db/silva-euk-18s-id95.fasta,ref_db/index_silva-euk-18s-id95

files=$(ls trimdata)

runsort(){
filenm=$1
pfx=$(cut -d'.' -f 1 <<< $filenm) 
sortmerna --ref $sortmernaREF --reads trimdata/$filenm --fastx --aligned rRNA_reads/$pfx'_ribo'\
 --other no_rRNA_reads/$pfx'_noribo' --num_alignments 1 
}

for eachfile in $files; do runsort $eachfile & done; wait;
