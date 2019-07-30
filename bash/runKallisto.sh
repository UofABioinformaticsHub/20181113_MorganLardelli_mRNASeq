#!/bin/bash

## Directories
PROJROOT=/data/biohub/20181113_MorganLardelli_mRNASeq
TRIMDATA=${PROJROOT}/1_trimmedData

## Setup for kallisto output
mkdir -p ${PROJROOT}/3_kallisto

## Fire off the alignments
FQ=$(ls ${TRIMDATA}/fastq/*R1.fq.gz | egrep '[0-9]+_(FS|FAD|_-)_[0-9]_R1.fq.gz')
echo -e "Found:\n\t${FQ}"

for F1 in ${FQ}
	do 
	sbatch ${PROJROOT}/bash/kallisto.sh ${F1}
done




