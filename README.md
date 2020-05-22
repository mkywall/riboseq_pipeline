# riboseq_pipeline
code for running riboseq analysis starting with fastq
### steps
1. Trim small RNA adapters / primers and filter by read length (trimmomatic)
2. remove rRNA sequences (sortmeRNA)
3. map to a genome (STAR)
4. index BAM files (samtools)
5. Identify P-site (plastid)
6. Identify open reading frames with ORF RATER

