#!/bin/bash
#SBATCH --job-name=align_pipe
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --mem=50G
#SBATCH --qos=general
#SBATCH --partition=xeon
#SBATCH --mail-user=rnu24002@uconn.edu
#SBATCH --mail-type=ALL
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --array=[0-40]

hostname
date

# load required software
module load samtools/1.16.1
module load samblaster/0.1.24
module load bwa-mem2/2.1

#set directories
SAMPDIR=../../results/02_qc/trimmed_fastq

OUTDIR=../../results/03_Alignment/bwa_align
mkdir -p $OUTDIR

INDEX=../../results/03_Alignment/bwa_index/ASM359739

# sample ID list
SAMPLELIST=(SRR15734410 SRR15734411 SRR15734412 SRR15734413 SRR15734414 SRR15734415 SRR15734416 SRR15734417 SRR15734418 SRR15734419 SRR15734420 SRR15734421 SRR15734422 SRR15734423 SRR15734424 SRR15734425 SRR15734426 SRR15734427 SRR15734428 SRR15734429 SRR15734430 SRR15734431 SRR15734432 SRR15734433 SRR15734434 SRR15734435 SRR15734436 SRR15734437 SRR15734438 SRR15734439 SRR15734440 SRR15734441 SRR15734442 SRR15734443 SRR15734444 SRR15734445 SRR17619844 SRR17619845 SRR17407396 SRR17408317 SRR17408318)

# extract one sample ID
SAMPLE=${SAMPLELIST[$SLURM_ARRAY_TASK_ID]}

# create read group string
RG=$(echo \@RG\\tID:$SAMPLE\\tSM:$SAMPLE)

# execute the alignment pipe:
bwa-mem2 mem -t 7 -R ${RG} ${INDEX} ${SAMPDIR}/${SAMPLE}_trim.1.fq.gz $SAMPDIR/${SAMPLE}_trim.2.fq.gz | \
        samblaster | \
        samtools view -S -h -u - | \
        samtools sort -T ${OUTDIR}/${SAMPLE}.temp -O BAM >$OUTDIR/${SAMPLE}.bam

# index alignment file
samtools index ${OUTDIR}/${SAMPLE}.bam
