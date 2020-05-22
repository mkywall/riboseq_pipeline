#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=4:00:00
#SBATCH --partition=standard
#SBATCH --account=xxx
#SBATCH --mem=12G

files=$(ls bamfiles)
module load samtools

# first index the bam files (manually oved the bam files from the starmap folder to a new folder called bamfiles to avoid logs etc)

samfunc(){
samtools index -b bamfiles/$1
}

for file in $files; do samfunc $file & done; wait;


# now the psite part
source activate penv
metagene generate myexp_orfs \
                    --landmark cds_start \
                    --annotation_files UCSC_genes.gtf


psite_func(){
pfx=$(cut -d'.' -f 1 <<< $1) 
psite merlin_orfs_rois.txt $pfx_riboprofile \
                             --min_length 29 \
                             --max_length 35 \
                             --require_upstream \
                             --count_files bamfiles/$1
}


for file in $files; do psite_func $file & done; wait
source deactivate
