
module load vcftools-gcc/1.1.3
module load plink
module load bedtools
module load blast


## identified missingness
vcftools --vcf Ov.Cam.Mar18.intersect.vcf --missing-indv

## removed individuals with more than 50% missing data
## then removed sites with more than 20% missing data
vcftools --vcf Ov.Cam.Mar18.intersect.vcf --remove the_worst_missing.txt --remove more_than_50_percent_missing.txt --max-missing .8
##After filtering, kept 43747 out of a possible 66273 Sites

## formatted file for plink. This version of plink did not accept more than 60 chromosomes, so only scaffolded contigs were used.
vcftools --vcf Ov.Cam.Mar18.intersect.vcf --remove the_worst_missing.txt --remove more_than_50_percent_missing.txt --max-missing .8 --plink --out Ov.Cam.Mar18.plink --chrom-map chromosome.converted.txt  --chr OVOC_OM1a --chr OVOC_OM1b --chr OVOC_OM2 --chr OVOC_OM3 --chr OVOC_OM4 --chr OVOC_OM5
plink --make-bed --file Ov.Cam.Mar18.plink --out Ov.Cam.Mar18.plink
##Total genotyping rate is 0.949417.
##40095 variants and 58 people pass filters and QC.

vcftools --vcf Ov.Cam.Mar18.intersect.vcf --remove the_worst_missing.txt --remove more_than_50_percent_missing.txt --max-missing 0.8 --singletons

vcftools --vcf Ov.Cam.Mar18.intersect.vcf --remove the_worst_missing.txt --remove more_than_50_percent_missing.txt --max-missing 0.8 --exclude-positions Ov.Cam.singletons.pos --out Ov.Cam.Mar18.rmi.nos --recode --non-ref-ac-any 1
## After filtering, kept 58 out of 95 Individuals; After filtering, kept 16547 out of a possible 66273 Sites

perl assess_off_target_hits.pl target_ST2021G_1_973.bed Ov.Cam.Mar18.rmi.nos.recode.vcf
##I counted 132 off-target snps and 16415 snps within 500 bp of target snps out of 16547 total snps in the file.

plink --bfile Ov.Cam.Mar18.plink --allow-no-sex --remove removed_inds.txt --cluster --mds-plot 20 --out Ov.Cam.Mar18.rmi.mds20

vcftools --vcf Ov.Cam.Mar18.rmi.nos.recode.vcf --chr OVOC_OM1a --chr OVOC_OM1b --chr OVOC_OM2 --chr OVOC_OM3 --chr OVOC_OM4 --chr OVOC_OM5 --chrom-map chromosome.converted.txt --plink --out Ov.Cam.Mar18.rmi.nos.plink
plink --make-bed --file Ov.Cam.Mar18.rmi.nos.plink --out Ov.Cam.Mar18.rmi.nos.plink --allow-no-sex

plink --bfile Ov.Cam.Mar18.rmi.nos.plink --assoc --pheno Ov.Mar18.onlyD80.txt --remove samples_D0.txt --allow-no-sex --adjust --all-pheno

samtools depth -a $i\.sorted.bam | grep "OVOC_OM" | perl calc_percent_with_x_cov.pl

