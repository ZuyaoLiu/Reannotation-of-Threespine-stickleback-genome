#!/bin/bash
#SBATCH --job-name="tissue-assemble"
#SBATCH --mail-type=none
#SBATCH --mem-per-cpu=2G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=threads
#SBATCH --time=24:00:00
samtools merge -@ threads -o merged.sorted.bam *.sort.bam


stringtie -p threads -o Final.gtf merged.sorted.bam
rm *.sort.bam


