#!/bin/bash
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=24:00:00
#SBATCH --mem=32GB
#SBATCH -o /data/biohub/20181113_MorganLardelli_mRNASeq/slurm/%x_%j.out
#SBATCH -e /data/biohub/20181113_MorganLardelli_mRNASeq/slurm/%x_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=stephen.pederson@adelaide.edu.au

## Cores
CORES=16

## Modules
module load kallisto/0.43.1-foss-2017a
module load SAMtools/1.3.1-GCC-5.3.0-binutils-2.25

## Reference Files
IDX=/data/biorefs/reference_genomes/ensembl-release-94/danio-rerio/kallisto/Danio_rerio.GRCz11.cdna.inc.psen2mutants
GTF=/data/biorefs/reference_genomes/ensembl-release-94/danio-rerio/Danio_rerio.GRCz11.94.inc.psen2mutants.gtf

## Directories
PROJROOT=/data/biohub/20181113_MorganLardelli_mRNASeq
TRIMDATA=${PROJROOT}/1_trimmedData

## Setup for kallisto output
ALIGNDATA=${PROJROOT}/3_kallisto
mkdir -p ${ALIGNDATA}

##--------------------------------------------------------------------------------------------##
## Aligning trimmed data to the kallisto index
##--------------------------------------------------------------------------------------------##

## Aligning, filtering and sorting
R1=(ls ${TRIMDATA}/fastq/*R1.fq.gz | egrep '[0-9]+_(FS|FAD|_-)_[0-9]_R1.fq.gz')
echo -e "Found:\n\t${R1}"

exit

kallisto quant \
	-t ${CORES} \
	--pseudobam \
	--single \
	--fr-stranded \
	-i ${IDX} \
	-o ${ALIGNDATA}




