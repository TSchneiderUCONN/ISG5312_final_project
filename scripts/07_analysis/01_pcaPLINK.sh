#!/bin/bash
#SBATCH --job-name=pca_plink
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

#Perform linkage pruning VCF file
plink --vcf ${VCF} --double-id --allow-extra-chr \
 --indep-pairwise 50 5 0.5 --out ${OUT}/galapagos

#Perform principle component analysis on pruned file
plink --vcf ${VCF} --double-id --allow-extra-chr \
 --extract ${OUT}/galapagos.prune.in \
 --make-bed --pca 'var-wts' --out ${OUT}/galapagos
