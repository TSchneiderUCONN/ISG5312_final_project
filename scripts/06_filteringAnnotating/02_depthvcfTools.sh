#!/bin/bash
#SBATCH --job-name=vcf_depth
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --mem=30G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rnu24002@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

#Load software
module load vcftools/0.1.16

#Set variables
VCF=../../results/05_variantCalling/filtered/testgalapagosFiltered.vcf.recode.vcf
OUTDIR=../../results/05_variantCalling/filtered

#Calculate mean depth per individual for filtered file
vcftools --vcf ${VCf} --out $OUTDIR --depth
