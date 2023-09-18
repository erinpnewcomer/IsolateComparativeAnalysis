#!/bin/bash
#===============================================================================
#
# File Name    : s00_gubbins.sh
# Description  : This script will run run_gubbins.py from the conda environment.
# Usage        : sbatch s00_gubbins.sh
# Author       : Erin Newcomer, erin.newcomer@wustl.edu
# Version      : 1.0
# Created On   : Mon Sep 18 08:35:21 CDT 2023
# Last Modified: Mon Sep 18 08:35:21 CDT 2023
#===============================================================================
#
#Submission script for HTCF
#SBATCH --time=0-00:00:00 # days-hh:mm:ss
#SBATCH --job-name=gubbins
#SBATCH --cpus-per-task=12
#SBATCH --array=1
#SBATCH --mem=32G
#SBATCH --output=slurm_out/gubbins/gubbins_%a_%A.out
#SBATCH --error=slurm_out/gubbins/gubbins_%a_%A.err

eval $( spack load --sh miniconda3 )
source activate /ref/gdlab/software/envs/gubbins

eval $( spack load --sh snp-dists )

#basedir if you want
basedir="${PWD}"

indir="${basedir}/d09_panaroo"
outdir="${basedir}/d10_gubbins"

echo "Started: `date`"
echo "Host: `hostname`"
echo "Threads: ${SLURM_CPUS_PER_TASK}"

#start debug mode (will send commands to outfile)
set -x

#generate_ska_alignment.py --reference ${refdir}/${reference}/assembly.fasta --input ${input} --out ${outdir}/out.aln

run_gubbins.py ${indir}/core_gene_alignment.aln

mask_gubbins_aln.py --aln ${indir}/core_gene_alignment.aln --gff recombination_predictions.gff --out ${outdir}/out.masked.aln

snp-dists -m ${outdir}/out.masked.aln > ${outdir}/pairwise_distances.tsv


#save error code for command
RC=$?
#exit debug mode
set +x

#output if job was successful
if [ $RC -eq 0 ]
then
  echo "Job completed successfully"
else
  echo "Error Occurred!"
  exit $RC
fi
