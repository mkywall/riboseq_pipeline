#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=4:00:00
#SBATCH --partition=largemem
#SBATCH --account=xxx
#SBATCH --mem=36G

module load trimmomatic
files=$(ls data)
mkdir trimdata

trimfunc() { 
java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar SE -phred33 data/$1 trimdata/$2 adapters.fa LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:27 MAXLEN:34   
}

for eachfile in $files; do trimfunc $eachfile $eachfile & done; wait;

