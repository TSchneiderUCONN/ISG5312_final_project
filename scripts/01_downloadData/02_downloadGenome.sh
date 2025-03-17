#!/bin/bash
#SBATCH --job-name=ISG5312_get_genome
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 2
#SBATCH --mem=10G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rnu24002@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

#####################################
#Download genome from NCBI
#####################################

#Load software
module load samtools/1.16.1

#Specifiy output directory
GENOMEDIR=../../genome
	mkdir -p $GENOMEDIR

#This project will be utilizing the genome of Abingdon island giant tortoise (Chelonoidis abingdonii)
#Pulling genome from NCBI database, as specified in original publication
	#https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_003597395.1/

#Download the genome
wget -P ${GENOMEDIR} https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/597/395/GCF_003597395.1_ASM359739v1/GCF_003597395.1_ASM359739v1_genomic.fna.gz | gunzip *gz
