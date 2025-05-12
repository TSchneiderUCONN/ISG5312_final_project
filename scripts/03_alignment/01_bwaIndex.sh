#!/bin/bash 
#SBATCH --job-name=bwa_index
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --mem=90G
#SBATCH --qos=general
#SBATCH --partition=xeon
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

######################################
#Index the reference genome using bwa
######################################

#Load software
module load bwa-mem2/2.1

#Set directories
INDEXDIR=../../results/03_alignment/bwa_index
	mkdir -p $INDEXDIR
GENOME=../../genome/GCF_003597395.1_ASM359739v1_genomic.fna.gz

#Create an index for the reference genome
bwa-mem2 index\
-p $INDEXDIR/ASM359739\
$GENOME
