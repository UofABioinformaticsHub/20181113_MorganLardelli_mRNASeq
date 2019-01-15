#!/bin/bash
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=2:00:00
#SBATCH --mem=4GB
#SBATCH -o /data/biohub/20181113_MorganLardelli_mRNASeq/slurm/%x_%j.out
#SBATCH -e /data/biohub/20181113_MorganLardelli_mRNASeq/slurm/%x_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=stephen.pederson@adelaide.edu.au

# This script is to check the alleles of the psen2 allele in all samples to 
# ensure that no sample mislabelling has occurred
WT=GTGCTCAACACTCTGGTC
FAD=AACATGATCAGTCTGATC
FS=TCGGTGCTCTGGTCATGA

PROJDIR=/data/biohub/20181113_MorganLardelli_mRNASeq
OUTDIR=${PROJDIR}/1_trimmedData/psen2checks
mkdir -p ${OUTDIR}
# Clean up any other files which may be lying around
rm -f ${OUTDIR}/*

FILES=$(ls ${PROJDIR}/1_trimmedData/fastq/*R1.fq.gz)

for F in $FILES
  do
  
  echo -e "Currently checking ${F}"
  N=$(zcat ${F} | egrep -c ${WT})
  echo -e "$(basename ${F})\t${N}" >> ${OUTDIR}/wt.txt
  N=$(zcat ${F} | egrep -c ${FAD})
  echo -e "$(basename ${F})\t${N}" >> ${OUTDIR}/fad.txt
  N=$(zcat ${F} | egrep -c ${FS})
  echo -e "$(basename ${F})\t${N}" >> ${OUTDIR}/fs.txt
  
  done
