#!/bin/bash 
#SBATCH --job-name=bcftools_ISG5312
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 60
#SBATCH --mem=100G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

#Load software
module load bcftools/1.19
module load htslib/1.19.1
module load parallel/20180122
module load vcflib/1.0.13

#Specify input/output directories
INDIR=../../results/03_Alignment/bwa_align/ 
OUTDIR=../../results/05_variantCalling/bcftools
	mkdir -p ${OUTDIR}

#Make a list of bam files
ls ${INDIR}/*.bam >${INDIR}/bam_list.txt

#Set reference genome location
GEN=../../genome/GCF_003597395.1_ASM359739v1_genomic.fna

#Identify regions file
regionsfile=../../genome/1000kbWin.bed

#Call variants in parallel
(cat "$regionsfile" | parallel -k -j 30 \
 "bcftools mpileup -f ${GEN} -b ${INDIR}/bam_list.txt -q 25 -Q 25 -r {} | bcftools call -m -v"
) | 
vcffirstheader |
vcfstreamsort -w 1000 |
vcfuniq |
bgzip >${OUTDIR}/galapagos1000kbWin.vcf.gz

#Index vcf
tabix -p vcf ${OUTDIR}/galapagos1000kbWin.vcf.gz

