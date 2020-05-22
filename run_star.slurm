#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=4:00:00
#SBATCH --partition=largemem
#SBATCH --account=xxx
#SBATCH --mem=36G

module load gcc star/2.5.3a

files=$(ls no_rRNA_reads)
mkdir starmap 

runstar(){
filenm=$1
pfx=$(cut -d'.' -f 1 <<< $filenm) 

STAR --genomeDir /project/genomes/Mus_musculus/UCSC/mm10/Sequence/STAR2Index/ --genomeLoad LoadAndExit
time STAR --runThreadN 8 --genomeDir /project/genomes/Mus_musculus/UCSC/mm10/Sequence/STAR2Index/ --genomeLoad LoadAndKeep\
 --outFileNamePrefix starmap/$pfx\
 --readFilesIn no_rRNA_reads/$filenm\
 --outSAMstrandField intronMotif\
 --outSAMtype BAM SortedByCoordinate\
 --limitBAMsortRAM 98000000000
}

for eachfile in $files; do runstar $eachfile; done;
