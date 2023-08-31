#!/bin/bash
#SBATCH --time=250:00:00
#SBATCH --partition=long
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=16384

module load gatk/3.4_46
module load freebayes-gcc/20140603

gatk -nt 2 -T GenotypeGVCFs -R Ov_wOv_refs.fa --variant OV01.hc.gvcf --variant OV02.hc.gvcf --variant OV03.hc.gvcf --variant OV04.hc.gvcf --variant OV06.hc.gvcf --variant OV07.hc.gvcf --variant OV08.hc.gvcf --variant OV09.hc.gvcf --variant OV10.hc.gvcf --variant OV11.hc.gvcf --variant OV12.hc.gvcf --variant OV14.hc.gvcf --variant OV15.hc.gvcf --variant OV16.hc.gvcf --variant OV17.hc.gvcf --variant OV20.hc.gvcf --variant OV23.hc.gvcf --variant OV25.hc.gvcf --variant OV26.hc.gvcf --variant OV27.hc.gvcf --variant OV28.hc.gvcf --variant OV30.hc.gvcf --variant OV31.hc.gvcf --variant OV32.hc.gvcf --variant OV33.hc.gvcf --variant OV34.hc.gvcf --variant OV35.hc.gvcf --variant OV36.hc.gvcf --variant OV37.hc.gvcf --variant OV38.hc.gvcf --variant OV39.hc.gvcf --variant OV44.hc.gvcf --variant OV46.hc.gvcf --variant OV47.hc.gvcf --variant OV51.hc.gvcf --variant OV53.hc.gvcf --variant OV57.hc.gvcf --variant OV58.hc.gvcf --variant OV59.hc.gvcf --variant OV60.hc.gvcf --variant OV61.hc.gvcf --variant OV62.hc.gvcf --variant OV63.hc.gvcf --variant OV64.hc.gvcf --variant OV65.hc.gvcf --variant OV66.hc.gvcf --variant OV67.hc.gvcf --variant OV68.hc.gvcf --variant OV69.hc.gvcf --variant OV70.hc.gvcf --variant OV71.hc.gvcf --variant OV72.hc.gvcf --variant OV73.hc.gvcf --variant OV74.hc.gvcf --variant OV75.hc.gvcf --variant OV76.hc.gvcf --variant OV77.hc.gvcf --variant OV78 -o OV.nuc.hc-gg.vcf

freebayes -f Ov_wOv_refs.fa -L bamlist -= -O  > OV.11Nov15.nuc.fb.vcf