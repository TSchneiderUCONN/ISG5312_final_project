#!/bin/bash
#SBATCH --job-name=pca_Fst
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
module load plink/1.90.beta.4.4

#Set input/output directories
VCF=../../results/05_variantCalling/filtered/testgalapagosFiltered.vcf.recode.vcf
OUT=../../results/06_analysis

#Calculate Wright's Fst
plink --vcf $VCF --fst ${VCF} --out ${OUT}/galapagosFst

