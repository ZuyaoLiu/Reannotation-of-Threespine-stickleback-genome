#!/bin/bash

#Please make sure Hisat 2.2.1, Stringtie 2.2.1 and samtools are installed in your environment
#read_file_list formant:
#Sample_name"\t"trimmed_R1_reads"\t"trimmed_R2_reads
##### 
#Commond "bash map_and_assemble.sh tissue your_read_file_list theads Library_type(PEorSE)"
#E.g: bash map_and_assemble.sh Tissue read.list  20 PE

name=$1
index=$2
read_file_list=$3
threads=$4
lib=$5
partition=$6

num=`cat $read_file_list |wc -l`
cat mapping.sh |sed -e "s!index!$index!g" -e "s!tissue!$name!g" -e "s!read_file_list!$read_file_list!g" -e "s!threads!$threads!g" -e "s!library!$lib!g" -e "s!final!$num!g" > mapping.submit.sh
cat assembling_transcripts.sh | sed -e "s/tissue/$name/g"  -e "s/threads/$threads/g" > assembling_transcripts.submit.sh

sbatch --wait -p $partition mapping.submit.sh
sbatch --wait -p $partition assembling_transcripts.submit.sh
