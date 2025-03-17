#!/bin/bash
#SBATCH --job-name=ISG5312_fasterq_dump
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --mem=20G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rnu24002@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

#################################################################
# Download fastq files from SRA 
#################################################################

#Temp directory
export TMPDIR=/scratch/tschneider/tempdir

#Load software
module load parallel/20180122
module load sratoolkit/3.0.1

#Data comes from this study
	#https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA761229
	#https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=761229

#Set variables
OUTDIR=../../data/fastq
	mkdir -p ${OUTDIR}
ACCLIST=../../metadata/accessionlist.txt

#Use parallel to download 5 accession files at a time and place them in the out directory
cat ${ACCLIST} | parallel -j 5 "fasterq-dump -O ${OUTDIR}"

#Compress files
ls ${OUTDIR}/*fastq | parallel -j 39 gzip
