#!/bin/bash
#SBATCH --job-name="tissue-array"
#SBATCH --mail-type=none
#SBATCH --mem-per-cpu=2G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=threads
#SBATCH --time=24:00:00
#SBATCH --array=1-final


cat read_file_list|awk '{print $1}' > input.list
SAMPLE_LIST=($(<input.list))
SAMPLE=${SAMPLE_LIST[${SLURM_ARRAY_TASK_ID}-1]}
read1=`cat read_file_list | grep "$SAMPLE" | awk '{print $2}'`
read2=`cat read_file_list | grep "$SAMPLE" | awk '{print $3}'`
out_bam=$SAMPLE".sort.bam"
lib="library"



if [ "$lib" == "PE" ];then
	hisat2 -p threads --dta --very-sensitive -x index -1 $read1 -2 $read2 |samtools sort -@ threads - -o $out_bam

elif [ "$lib" == "SE" ];then
	hisat2 -p threads --dta --very-sensitive -x index -U $read1|samtools sort -@ threads - -o $out_bam
fi

