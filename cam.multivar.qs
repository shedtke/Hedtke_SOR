#!/bin/bash
#SBATCH --time=250:00:00
#SBATCH --partition=long
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=16384

module load gatk/3.4_46
module load freebayes-gcc/1.0.2

gatk -nt 2 -T GenotypeGVCFs -R Ov_wOv_refs.fa --variant 01_02_N1_F1_D0.hc.gvcf --variant 01_08_N1_F2_D0.hc.gvcf --variant 01_19_N1_F2_D80.hc.gvcf --variant 01_21_N2_F1_D0.hc.gvcf --variant 01_24_N1_F1_D80.hc.gvcf --variant 01_28_N1_F1_D80.hc.gvcf --variant 01_28_N1_F2_D80.hc.gvcf --variant 01_35_N1_F1_D80.hc.gvcf --variant 01_35_N1_F2_D80.hc.gvcf --variant 01_51_N1_F1_D0.hc.gvcf --variant 01_51_N1_F2_D80.hc.gvcf --variant 02_08_N1_F1_D0.hc.gvcf --variant 02_08_N1_F1_D80.hc.gvcf --variant 02_08_N1_F2_D0.hc.gvcf --variant 02_08_N1_F3_D0.hc.gvcf --variant 02_08_N1_F6_D0.hc.gvcf --variant 02_08_N3_F1_D80.hc.gvcf --variant 02_08_N3_F2_D80.hc.gvcf --variant 02_08_N3_F3_D80.hc.gvcf --variant 02_13_N1_F1_D0.hc.gvcf --variant 02_15_N1_F1_D0.hc.gvcf --variant 03_09_N1_F1_D80.hc.gvcf --variant 03_09_N2_F1_D80.hc.gvcf --variant 03_09_N2_F2_D80.hc.gvcf --variant 03_35_N1_F2_D0.hc.gvcf --variant 03_48_N1_F1_D0.hc.gvcf --variant 04_15_N1_F2_D80.hc.gvcf --variant 04_15_N1_F3_D80.hc.gvcf --variant 04_38_N1_F2_D80.hc.gvcf --variant 04_89_N1_F1_D80.hc.gvcf --variant 05_04_N1_F1_D80.hc.gvcf --variant 05_04_N2_F1_D80.hc.gvcf --variant 05_07_N1_F1_D80.hc.gvcf --variant 05_07_N2_F1_D80.hc.gvcf --variant 05_08_N1_F1_D80.hc.gvcf --variant 05_08_N1_F3_D80.hc.gvcf --variant 05_08_N3_F1_D80.hc.gvcf --variant 05_18_N1_F1_D80.hc.gvcf --variant 05_21_N1_F1_D0.hc.gvcf --variant 05_21_N1_F1_D80.hc.gvcf --variant 05_21_N1_F2_D80.hc.gvcf --variant 05_34_N1_F1_D80.hc.gvcf --variant 05_34_N1_F2_D0.hc.gvcf --variant 05_39_N1_F1_D80.hc.gvcf --variant 05_42_N1_F1_D0.hc.gvcf --variant 05_48_N1_F5_D0.hc.gvcf --variant 05_54_N1_F1_D0.hc.gvcf --variant 05_54_N1_F3_D0.hc.gvcf --variant 05_54_N2_F2_D0.hc.gvcf --variant 05_57_N2_F1_D0.hc.gvcf --variant 05_58_N1_F1_D0.hc.gvcf --variant 05_59_N1_F1_D80.hc.gvcf --variant 05_89_N1_F1_D80.hc.gvcf --variant 05_92_N1_F1_D0.hc.gvcf --variant 06_07_N3_F1_D80.hc.gvcf --variant 06_12_N2_F1_D80.hc.gvcf --variant 06_27_N1_F1_D80.hc.gvcf --variant 06_27_N1_F2_D80.hc.gvcf --variant 06_27_N1_F3_D80.hc.gvcf --variant 06_57_N1_F3_D80.hc.gvcf --variant 07_23_N1_F1_D0.hc.gvcf --variant 07_39_N1_F1_D80.hc.gvcf --variant 08_02_N1_F1_D80.hc.gvcf --variant 08_02_N2_F1_D80.hc.gvcf --variant 08_10_N2_F1_D80.hc.gvcf --variant 08_32_N1_F1_D0.hc.gvcf --variant 09_06_N1_F1_D80.hc.gvcf --variant 09_11_N1_F1_D80.hc.gvcf --variant 09_24_N1_F1_D0.hc.gvcf --variant 09_24_N1_F1_D80.hc.gvcf --variant 09_45_N1_F1_D0.hc.gvcf --variant 10_06_N1_F1_D80.hc.gvcf --variant 10_06_N1_F2_D80.hc.gvcf --variant 10_45_N1_F1_D0.hc.gvcf --variant 10_45_N1_F1_D80.hc.gvcf --variant 10_52_N1_F1_D80.hc.gvcf --variant 10_52_N1_F2_D80.hc.gvcf --variant 11_73_N1_F1_D0.hc.gvcf --variant 12_04_N1_F2_D80.hc.gvcf --variant 12_24_N1_F3_D80.hc.gvcf --variant 12_30_N1_F1_D0.hc.gvcf --variant 12_30_N2_F2_D0.hc.gvcf --variant 13_01_N1_F3_D80.hc.gvcf --variant 13_27_N1_F1_D80.hc.gvcf --variant 13_27_N2_F1_D80.hc.gvcf --variant 13_32_N2_F1_D80.hc.gvcf --variant 13_43_N1_F1_D80.hc.gvcf --variant 13_44_N2_F1_D80.hc.gvcf --variant 13_62_N1_F1_D80.hc.gvcf --variant 13_62_N1_F2_D80.hc.gvcf --variant 13_62_N1_F3_D80.hc.gvcf --variant 13_62_N2_F1_D80.hc.gvcf --variant 13_78_N2_F2_D80.hc.gvcf --variant 14_08_N1_F1_D80.hc.gvcf --variant 14_08_N2_F1_D80.hc.gvcf -o CameroonNugen12Mar2018.hcgg.vcf


freebayes -f Ov_wOv_refs.fa -L bamlist.txt -C 5 -= --min-coverage 20 -q 30 > CameroonNugen12Mar2018.fb.vcf