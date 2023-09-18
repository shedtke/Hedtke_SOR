
module load vcftools-gcc/0.1.14
module load plink/1.90b3
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

vcftools --max-missing .8 --gzvcf OV.Nov15.intersect.recode.vcf --out Ov.Nov15.80s --recode --non-ref-ac-any 1
                vcftools --missing-indv --vcf Ov.Nov15* --out Ov.Nov15.80s.80i
                vcftools --vcf Ov.Nov15* --recode --out Ov.Nov15.*.85i --remove Ov.80i.remove --non-ref-ac-any 1
        (9) Remove indels, for analyses that don't want indels
                vcftools --vcf Ov.Nov15* --recode --remove-indels --out Ov.Nov15.*.noid
        (9) Remove singleton SNPs, for analyses that don't want singletons
                vcftools --singletons --vcf OV.Nov15.80s.80i.recode.vcf --out OV.Nov15.missing80p
                vcftools --exclude-positions OV.Nov15.80s.80i.singletons --vcf OV.Nov15.80s.80i.recode.vcf --out OV.Nov15.80s.80i.nos --recode
        (10) Remove multiallelic sites, for analyses that only want biallelic sites
                vcftools --min-alleles 2 --max-alleles 2 --vcf Ov.Nov15.80s.80i.recode.vcf --out Ov.Nov15.80s.80i.bi --recode
				
				
				https://github.com/shedtke/Hedtke_SOR/tree/main
				
				10 Mar 2022

## the reason the values differ is because I re-did the Fst analysis. I think I used a better pruned file by setting anything less than 0 to 0, or removed indels, or removed the identical individual, or the related individuals, or something. So this is not an error.

## Steve suggested I prune for linked sites when doing the population level analysis... I might also want to remove sites that are not in HWE (i.e., under selection for other reasons):

 

 

what looks like the most recent file is:

vcftools --vcf Ov.Nov15.strict.DP5Q20.Gha.rmi.nos.recode.vcf

VCFtools - v0.1.14
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf Ov.Nov15.strict.DP5Q20.Gha.rmi.nos.recode.vcf

After filtering, kept 47 out of 47 Individuals
After filtering, kept 342064 out of a possible 342064 Sites
Run Time = 2.00 seconds

In the plink folder, there is this file, with fewer variants:

plink --file Ov.Nov15.strict.DP5Q20.Gha.rmi.nos.plink
PLINK v1.90b3 64-bit (11 Jan 2015)         https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to plink.log.
129068 MB RAM detected; reserving 64534 MB for main workspace.
Possibly irregular .ped line.  Restarting scan, assuming multichar alleles.
.ped scan complete (for binary autoconversion).
Performing single-pass .bed write (313090 variants, 47 people).
--file: plink.bed + plink.bim + plink.fam written.

 

 

plink --bfile Ov.Nov15.strict.DP5Q20.Gha.rmi.nos.plink --indep-pairphase 10kb 1kb .08 --out Ov.Nov15.strict.DP5Q20.Gha.rmi.nos.indepp.10kbwin.1kbstep.08r2 --allow-no-sex
PLINK v1.90b3 64-bit (11 Jan 2015)         https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to Ov.Nov15.strict.DP5Q20.Gha.rmi.nos.indepp.10kbwin.1kbstep.08r2.log.
129068 MB RAM detected; reserving 64534 MB for main workspace.
313090 variants loaded from .bim file.
47 people (0 males, 0 females, 47 ambiguous) loaded from .fam.
Ambiguous sex IDs written to
Ov.Nov15.strict.DP5Q20.Gha.rmi.nos.indepp.10kbwin.1kbstep.08r2.nosex .
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 47 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Total genotyping rate is 0.93142.
313090 variants and 47 people pass filters and QC.
Note: No phenotypes present.
--indep-pairphase: Ignoring 15146 chromosome 0 variants.
Pruned 111698 variants from chromosome 1, leaving 4548.
Pruned 36371 variants from chromosome 2, leaving 3721.
Pruned 64283 variants from chromosome 3, leaving 2324.
Pruned 63896 variants from chromosome 4, leaving 2258.
Pruned 8613 variants from chromosome 5, leaving 232.
Pruning complete.  284861 of 297944 variants removed.
Marker lists written to
Ov.Nov15.strict.DP5Q20.Gha.rmi.nos.indepp.10kbwin.1kbstep.08r2.prune.in and
Ov.Nov15.strict.DP5Q20.Gha.rmi.nos.indepp.10kbwin.1kbstep.08r2.prune.out .

hmmm that seems a bit much compared to the block analysis and stuff!

## why is it ignoring chromosome 0? assuming it's mitochondrial? looks like I need to regenerate the file using a chromosome map.

###########SUMMARY OF FILES USED#############

Baseline file:  May 27  2020 Ov.Nov15.strict.DP5Q20.rmi.recode.vcf.gz

For Fst calculations:  May 11  2021 Ov.Nov15.strict.DP5Q20.rmi.nos.recode.vcf

For population structure, within Ghana: [[plink: only biallelic, so can remove sites in LD, using baseline file that has singletons. and sites that fail HWE]]

I found a script here: plink produces does pruning according to log file but prune.in is full of dots (biostars.org)

which I edited to change the default to plink_annot.vcf (as the script wasn't working there) and used this to convert the vcf:

bash convert_chroms_for_plink.sh ../vcfgha/Ov.Nov15.strict.DP5Q20.rmi.recode.vcf

preparing annotation file using bash kung-fu...
compressing using bgzip...
[bgzip] annotation_file.tab.gz already exists; do you wish to overwrite (y or n)? y
indexing using tabix...
annotating using bcftools...
Ready for plink! Have fun :)

 plink --vcf plink_annot.vcf --indep-pairphase 10kb 1kb .8 --out test --allow-no-sex --allow-extra-chr
PLINK v1.90b3 64-bit (11 Jan 2015)         https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to test.log.
129068 MB RAM detected; reserving 64534 MB for main workspace.
--vcf: test-temporary.bed + test-temporary.bim + test-temporary.fam written.
448130 variants loaded from .bim file.
50 people (0 males, 0 females, 50 ambiguous) loaded from .fam.
Ambiguous sex IDs written to test.nosex .
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 50 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Total genotyping rate is 0.925052.
448130 variants and 50 people pass filters and QC.
Note: No phenotypes present.
Pruned 6999 variants from chromosome 27, leaving 12864.
Pruned 61893 variants from chromosome 28, leaving 89162.
Pruned 32613 variants from chromosome 29, leaving 33047.
Pruned 33683 variants from chromosome 30, leaving 55087.
Pruned 32418 variants from chromosome 31, leaving 54483.
Pruned 4690 variants from chromosome 32, leaving 7364.
Pruned 597 variants from chromosome 33, leaving 886.
Pruned 618 variants from chromosome 34, leaving 1004.
Pruned 387 variants from chromosome 35, leaving 791.
Pruned 564 variants from chromosome 36, leaving 846.
Pruned 286 variants from chromosome 37, leaving 446.
Pruned 125 variants from chromosome 38, leaving 146.
Pruned 440 variants from chromosome 39, leaving 638.
Pruned 303 variants from chromosome 40, leaving 268.
Pruned 315 variants from chromosome 41, leaving 488.
Pruned 233 variants from chromosome 42, leaving 315.
Pruned 0 variants from chromosome 43, leaving 5.
Pruned 137 variants from chromosome 44, leaving 110.
Pruned 295 variants from chromosome 45, leaving 173.
Pruned 10 variants from chromosome 46, leaving 23.
Pruned 0 variants from chromosome 47, leaving 1.
Pruned 135 variants from chromosome 48, leaving 138.
Pruned 189 variants from chromosome 49, leaving 141.
Pruned 194 variants from chromosome 50, leaving 40.
Pruned 52 variants from chromosome 51, leaving 49.
Pruned 101 variants from chromosome 52, leaving 83.
Pruned 0 variants from chromosome 53, leaving 1.
Pruned 130 variants from chromosome 54, leaving 46.
Pruned 105 variants from chromosome 55, leaving 52.
Pruned 112 variants from chromosome 56, leaving 65.
Pruned 110 variants from chromosome 57, leaving 91.
Pruned 52 variants from chromosome 58, leaving 19.
Pruned 62 variants from chromosome 59, leaving 42.
Pruned 126 variants from chromosome 60, leaving 64.
Pruned 355 variants from chromosome 61, leaving 334.
Pruned 55 variants from chromosome 62, leaving 34.
Pruned 84 variants from chromosome 63, leaving 83.
Pruned 122 variants from chromosome 64, leaving 24.
Pruned 0 variants from chromosome 65, leaving 1.
Pruned 30 variants from chromosome 66, leaving 43.
Pruned 1 variant from chromosome 67, leaving 1.
Pruned 183 variants from chromosome 68, leaving 29.
Pruned 40 variants from chromosome 69, leaving 54.
Pruned 130 variants from chromosome 70, leaving 132.
Pruned 98 variants from chromosome 71, leaving 134.
Pruned 43 variants from chromosome 72, leaving 57.
Pruned 50 variants from chromosome 73, leaving 32.
Pruned 101 variants from chromosome 74, leaving 75.
Pruned 0 variants from chromosome 75, leaving 1.
Pruned 13 variants from chromosome 76, leaving 21.
Pruned 335 variants from chromosome 77, leaving 160.
Pruned 38 variants from chromosome 78, leaving 17.
Pruned 3 variants from chromosome 79, leaving 4.
Pruned 41 variants from chromosome 80, leaving 8.
Pruned 92 variants from chromosome 81, leaving 145.
Pruned 0 variants from chromosome 82, leaving 1.
Pruned 58 variants from chromosome 83, leaving 183.
Pruned 73 variants from chromosome 84, leaving 37.
Pruned 0 variants from chromosome 85, leaving 2.
Pruned 102 variants from chromosome 86, leaving 87.
Pruned 97 variants from chromosome 87, leaving 18.
Pruned 41 variants from chromosome 88, leaving 88.
Pruned 41 variants from chromosome 89, leaving 8.
Pruned 32 variants from chromosome 90, leaving 11.
Pruned 68 variants from chromosome 91, leaving 63.
Pruned 0 variants from chromosome 92, leaving 2.
Pruned 22 variants from chromosome 93, leaving 14.
Pruned 1 variant from chromosome 94, leaving 4.
Pruned 39 variants from chromosome 95, leaving 47.
Pruned 0 variants from chromosome 96, leaving 1.
Pruned 1 variant from chromosome 97, leaving 2.
Pruned 62 variants from chromosome 98, leaving 39.
Pruned 33 variants from chromosome 99, leaving 31.
Pruned 6 variants from chromosome 100, leaving 16.
Pruned 78 variants from chromosome 101, leaving 64.
Pruned 38 variants from chromosome 102, leaving 56.
Pruned 0 variants from chromosome 103, leaving 1.
Pruned 37 variants from chromosome 104, leaving 64.
Pruned 30 variants from chromosome 105, leaving 26.
Pruned 49 variants from chromosome 106, leaving 90.
Pruned 33 variants from chromosome 107, leaving 32.
Pruned 25 variants from chromosome 108, leaving 23.
Pruned 39 variants from chromosome 109, leaving 27.
Pruned 79 variants from chromosome 110, leaving 60.
Pruned 84 variants from chromosome 111, leaving 47.
Pruned 22 variants from chromosome 112, leaving 18.
Pruned 24 variants from chromosome 113, leaving 36.
Pruned 59 variants from chromosome 114, leaving 23.
Pruned 12 variants from chromosome 115, leaving 8.
Pruned 136 variants from chromosome 116, leaving 55.
Pruned 1 variant from chromosome 117, leaving 3.
Pruned 0 variants from chromosome 118, leaving 1.
Pruned 157 variants from chromosome 119, leaving 103.
Pruned 47 variants from chromosome 120, leaving 40.
Pruned 56 variants from chromosome 121, leaving 58.
Pruned 45 variants from chromosome 122, leaving 19.
Pruned 3 variants from chromosome 123, leaving 10.
Pruned 46 variants from chromosome 124, leaving 23.
Pruned 9 variants from chromosome 125, leaving 6.
Pruned 15 variants from chromosome 126, leaving 6.
Pruned 112 variants from chromosome 127, leaving 65.
Pruned 14 variants from chromosome 128, leaving 21.
Pruned 3 variants from chromosome 129, leaving 2.
Pruned 35 variants from chromosome 130, leaving 55.
Pruned 32 variants from chromosome 131, leaving 39.
Pruned 0 variants from chromosome 132, leaving 2.
Pruned 40 variants from chromosome 133, leaving 14.
Pruned 48 variants from chromosome 134, leaving 26.
Pruned 1 variant from chromosome 135, leaving 3.
Pruned 91 variants from chromosome 136, leaving 32.
Pruned 3 variants from chromosome 137, leaving 3.
Pruned 0 variants from chromosome 138, leaving 1.
Pruned 18 variants from chromosome 139, leaving 17.
Pruned 33 variants from chromosome 140, leaving 60.
Pruned 36 variants from chromosome 141, leaving 14.
Pruned 0 variants from chromosome 142, leaving 5.
Pruned 40 variants from chromosome 143, leaving 15.
Pruned 38 variants from chromosome 144, leaving 27.
Pruned 64 variants from chromosome 145, leaving 43.
Pruned 8 variants from chromosome 146, leaving 13.
Pruned 66 variants from chromosome 147, leaving 79.
Pruned 8 variants from chromosome 148, leaving 10.
Pruned 115 variants from chromosome 149, leaving 85.
Pruned 56 variants from chromosome 150, leaving 79.
Pruned 34 variants from chromosome 151, leaving 44.
Pruned 32 variants from chromosome 152, leaving 44.
Pruned 15 variants from chromosome 153, leaving 12.
Pruned 14 variants from chromosome 154, leaving 31.
Pruned 32 variants from chromosome 155, leaving 27.
Pruned 1 variant from chromosome 156, leaving 7.
Pruned 73 variants from chromosome 157, leaving 99.
Pruned 1 variant from chromosome 158, leaving 2.
Pruned 1 variant from chromosome 159, leaving 11.
Pruned 12 variants from chromosome 160, leaving 7.
Pruned 33 variants from chromosome 161, leaving 16.
Pruned 8 variants from chromosome 162, leaving 12.
Pruned 27 variants from chromosome 163, leaving 19.
Pruned 7 variants from chromosome 164, leaving 29.
Pruned 35 variants from chromosome 165, leaving 35.
Pruned 25 variants from chromosome 166, leaving 22.
Pruned 27 variants from chromosome 167, leaving 35.
Pruned 74 variants from chromosome 168, leaving 31.
Pruned 18 variants from chromosome 169, leaving 42.
Pruned 9 variants from chromosome 170, leaving 15.
Pruned 11 variants from chromosome 171, leaving 17.
Pruned 51 variants from chromosome 172, leaving 43.
Pruned 0 variants from chromosome 173, leaving 1.
Pruned 7 variants from chromosome 174, leaving 20.
Pruned 2 variants from chromosome 175, leaving 10.
Pruned 9 variants from chromosome 176, leaving 21.
Pruned 5 variants from chromosome 177, leaving 3.
Pruned 34 variants from chromosome 178, leaving 41.
Pruned 24 variants from chromosome 179, leaving 10.
Pruned 0 variants from chromosome 180, leaving 5.
Pruned 0 variants from chromosome 181, leaving 1.
Pruned 15 variants from chromosome 182, leaving 16.
Pruned 3 variants from chromosome 183, leaving 6.
Pruned 2 variants from chromosome 184, leaving 2.
Pruned 8 variants from chromosome 185, leaving 3.
Pruned 17 variants from chromosome 186, leaving 18.
Pruned 2 variants from chromosome 187, leaving 1.
Pruned 2 variants from chromosome 188, leaving 8.
Pruned 9 variants from chromosome 189, leaving 13.
Pruned 27 variants from chromosome 190, leaving 11.
Pruned 0 variants from chromosome 191, leaving 3.
Pruned 3 variants from chromosome 192, leaving 5.
Pruned 6 variants from chromosome 193, leaving 4.
Pruned 0 variants from chromosome 194, leaving 1.
Pruned 0 variants from chromosome 195, leaving 2.
Pruned 0 variants from chromosome 196, leaving 1.
Pruned 1 variant from chromosome 197, leaving 2.
Pruned 5 variants from chromosome 198, leaving 11.
Pruned 14 variants from chromosome 199, leaving 5.
Pruned 1 variant from chromosome 200, leaving 3.
Pruned 1 variant from chromosome 201, leaving 12.
Pruned 0 variants from chromosome 202, leaving 1.
Pruned 17 variants from chromosome 203, leaving 17.
Pruned 3 variants from chromosome 204, leaving 5.
Pruned 4 variants from chromosome 205, leaving 12.
Pruned 12 variants from chromosome 206, leaving 26.
Pruned 28 variants from chromosome 207, leaving 13.
Pruned 4 variants from chromosome 208, leaving 8.
Pruned 0 variants from chromosome 209, leaving 2.
Pruned 0 variants from chromosome 210, leaving 6.
Pruned 2 variants from chromosome 211, leaving 13.
Pruned 0 variants from chromosome 212, leaving 2.
Pruned 2 variants from chromosome 213, leaving 7.
Pruned 0 variants from chromosome 214, leaving 1.
Pruned 28 variants from chromosome 215, leaving 30.
Pruned 6 variants from chromosome 216, leaving 12.
Pruned 0 variants from chromosome 217, leaving 1.
Pruned 0 variants from chromosome 218, leaving 3.
Pruned 2 variants from chromosome 219, leaving 2.
Pruned 2 variants from chromosome 220, leaving 8.
Pruned 6 variants from chromosome 221, leaving 15.
Pruned 36 variants from chromosome 222, leaving 35.
Pruned 4 variants from chromosome 223, leaving 11.
Pruned 2 variants from chromosome 224, leaving 11.
Pruned 0 variants from chromosome 225, leaving 2.
Pruned 0 variants from chromosome 226, leaving 1.
Pruned 7 variants from chromosome 227, leaving 6.
Pruned 7 variants from chromosome 228, leaving 8.
Pruned 0 variants from chromosome 229, leaving 1.
Pruned 0 variants from chromosome 230, leaving 2.
Pruned 27 variants from chromosome 231, leaving 17.
Pruned 0 variants from chromosome 232, leaving 2.
Pruned 2 variants from chromosome 233, leaving 3.
Pruned 0 variants from chromosome 234, leaving 3.
Pruned 3 variants from chromosome 235, leaving 10.
Pruned 9 variants from chromosome 236, leaving 8.
Pruned 18 variants from chromosome 237, leaving 3.
Pruned 9 variants from chromosome 238, leaving 11.
Pruned 0 variants from chromosome 239, leaving 1.
Pruned 3 variants from chromosome 240, leaving 1.
Pruned 7 variants from chromosome 241, leaving 6.
Pruned 0 variants from chromosome 242, leaving 1.
Pruned 0 variants from chromosome 243, leaving 1.
Pruned 13 variants from chromosome 244, leaving 13.
Pruned 0 variants from chromosome 245, leaving 7.
Pruned 2 variants from chromosome 246, leaving 1.
Pruned 1 variant from chromosome 247, leaving 2.
Pruned 0 variants from chromosome 248, leaving 3.
Pruned 3 variants from chromosome 249, leaving 13.
Pruned 4 variants from chromosome 250, leaving 15.
Pruned 10 variants from chromosome 251, leaving 10.
Pruned 1 variant from chromosome 252, leaving 2.
Pruned 1 variant from chromosome 253, leaving 4.
Pruned 0 variants from chromosome 254, leaving 3.
Pruned 7 variants from chromosome 255, leaving 11.
Pruned 0 variants from chromosome 256, leaving 2.
Pruned 0 variants from chromosome 257, leaving 1.
Pruned 0 variants from chromosome 258, leaving 1.
Pruned 0 variants from chromosome 259, leaving 2.
Pruned 1 variant from chromosome 260, leaving 2.
Pruned 0 variants from chromosome 261, leaving 9.
Pruned 2 variants from chromosome 262, leaving 1.
Pruned 0 variants from chromosome 263, leaving 4.
Pruned 14 variants from chromosome 264, leaving 30.
Pruned 3 variants from chromosome 265, leaving 8.
Pruned 1 variant from chromosome 266, leaving 5.
Pruned 2 variants from chromosome 267, leaving 9.
Pruned 1 variant from chromosome 268, leaving 3.
Pruned 0 variants from chromosome 269, leaving 1.
Pruned 2 variants from chromosome 270, leaving 1.
Pruned 0 variants from chromosome 271, leaving 2.
Pruned 2 variants from chromosome 272, leaving 2.
Pruned 2 variants from chromosome 273, leaving 9.
Pruned 2 variants from chromosome 274, leaving 2.
Pruned 3 variants from chromosome 275, leaving 15.
Pruned 3 variants from chromosome 276, leaving 7.
Pruned 0 variants from chromosome 277, leaving 2.
Pruned 14 variants from chromosome 278, leaving 11.
Pruned 4 variants from chromosome 279, leaving 13.
Pruned 0 variants from chromosome 280, leaving 2.
Pruned 1 variant from chromosome 281, leaving 3.
Pruned 0 variants from chromosome 282, leaving 7.
Pruned 5 variants from chromosome 283, leaving 10.
Pruned 10 variants from chromosome 284, leaving 18.
Pruned 0 variants from chromosome 285, leaving 2.
Pruned 3 variants from chromosome 286, leaving 8.
Pruned 3 variants from chromosome 287, leaving 4.
Pruned 0 variants from chromosome 288, leaving 1.
Pruned 5 variants from chromosome 289, leaving 17.
Pruned 1 variant from chromosome 290, leaving 3.
Pruned 1 variant from chromosome 291, leaving 6.
Pruned 1 variant from chromosome 292, leaving 7.
Pruned 12 variants from chromosome 293, leaving 13.
Pruned 0 variants from chromosome 294, leaving 1.
Pruned 0 variants from chromosome 295, leaving 1.
Pruned 0 variants from chromosome 296, leaving 3.
Pruned 0 variants from chromosome 297, leaving 1.
Pruned 0 variants from chromosome 298, leaving 7.
Pruned 1 variant from chromosome 299, leaving 3.
Pruned 0 variants from chromosome 300, leaving 1.
Pruned 0 variants from chromosome 301, leaving 1.
Pruned 2 variants from chromosome 302, leaving 1.
Pruned 1 variant from chromosome 303, leaving 1.
Pruned 0 variants from chromosome 304, leaving 2.
Pruned 9 variants from chromosome 305, leaving 14.
Pruned 1 variant from chromosome 306, leaving 3.
Pruned 9 variants from chromosome 307, leaving 10.
Pruned 1 variant from chromosome 308, leaving 7.
Pruned 6 variants from chromosome 309, leaving 7.
Pruned 0 variants from chromosome 310, leaving 1.
Pruned 0 variants from chromosome 311, leaving 1.
Pruned 0 variants from chromosome 312, leaving 1.
Pruned 7 variants from chromosome 313, leaving 8.
Pruned 0 variants from chromosome 314, leaving 1.
Pruned 0 variants from chromosome 315, leaving 1.
Pruned 1 variant from chromosome 316, leaving 3.
Pruned 0 variants from chromosome 317, leaving 1.
Pruned 0 variants from chromosome 318, leaving 1.
Pruned 2 variants from chromosome 319, leaving 6.
Pruned 1 variant from chromosome 320, leaving 7.
Pruned 0 variants from chromosome 321, leaving 3.
Pruned 0 variants from chromosome 322, leaving 1.
Pruned 0 variants from chromosome 323, leaving 1.
Pruned 0 variants from chromosome 324, leaving 1.
Pruned 0 variants from chromosome 325, leaving 1.
Pruned 2 variants from chromosome 326, leaving 6.
Pruned 0 variants from chromosome 327, leaving 1.
Pruned 0 variants from chromosome 328, leaving 1.
Pruned 0 variants from chromosome 329, leaving 1.
Pruned 3 variants from chromosome 330, leaving 4.
Pruned 1 variant from chromosome 331, leaving 1.
Pruned 0 variants from chromosome 332, leaving 1.
Pruned 2 variants from chromosome 333, leaving 2.
Pruned 2 variants from chromosome 334, leaving 5.
Pruned 3 variants from chromosome 335, leaving 1.
Pruned 0 variants from chromosome 336, leaving 1.
Pruned 13 variants from chromosome 337, leaving 2.
Pruned 0 variants from chromosome 338, leaving 2.
Pruned 0 variants from chromosome 339, leaving 2.
Pruned 0 variants from chromosome 340, leaving 1.
Pruned 3 variants from chromosome 341, leaving 2.
Pruned 2 variants from chromosome 342, leaving 4.
Pruned 1 variant from chromosome 343, leaving 2.
Pruned 5 variants from chromosome 344, leaving 14.
Pruned 0 variants from chromosome 345, leaving 1.
Pruned 5 variants from chromosome 346, leaving 14.
Pruned 0 variants from chromosome 347, leaving 1.
Pruned 2 variants from chromosome 348, leaving 4.
Pruned 0 variants from chromosome 349, leaving 2.
Pruned 2 variants from chromosome 350, leaving 2.
Pruned 7 variants from chromosome 351, leaving 8.
Pruned 0 variants from chromosome 352, leaving 3.
Pruned 0 variants from chromosome 353, leaving 4.
Pruned 0 variants from chromosome 354, leaving 2.
Pruned 2 variants from chromosome 355, leaving 3.
Pruned 0 variants from chromosome 356, leaving 2.
Pruned 0 variants from chromosome 357, leaving 7.
Pruned 0 variants from chromosome 358, leaving 1.
Pruned 2 variants from chromosome 359, leaving 1.
Pruned 0 variants from chromosome 360, leaving 1.
Pruned 4 variants from chromosome 361, leaving 10.
Pruned 0 variants from chromosome 362, leaving 2.
Pruned 0 variants from chromosome 363, leaving 3.
Pruned 0 variants from chromosome 364, leaving 1.
Pruned 0 variants from chromosome 365, leaving 1.
Pruned 0 variants from chromosome 366, leaving 3.
Pruned 0 variants from chromosome 367, leaving 1.
Pruned 0 variants from chromosome 368, leaving 1.
Pruned 1 variant from chromosome 369, leaving 2.
Pruned 0 variants from chromosome 370, leaving 1.
Pruned 3 variants from chromosome 371, leaving 1.
Pruned 0 variants from chromosome 372, leaving 3.
Pruned 0 variants from chromosome 373, leaving 1.
Pruned 3 variants from chromosome 374, leaving 6.
Pruned 1 variant from chromosome 375, leaving 3.
Pruned 0 variants from chromosome 376, leaving 2.
Pruned 3 variants from chromosome 377, leaving 1.
Pruned 0 variants from chromosome 378, leaving 3.
Pruned 0 variants from chromosome 379, leaving 1.
Pruned 1 variant from chromosome 380, leaving 1.
Pruned 0 variants from chromosome 381, leaving 5.
Pruned 0 variants from chromosome 382, leaving 1.
Pruned 0 variants from chromosome 383, leaving 2.
Pruned 2 variants from chromosome 384, leaving 1.
Pruned 0 variants from chromosome 385, leaving 6.
Pruned 0 variants from chromosome 386, leaving 1.
Pruned 1 variant from chromosome 387, leaving 3.
Pruned 0 variants from chromosome 388, leaving 2.
Pruned 2 variants from chromosome 389, leaving 1.
Pruned 0 variants from chromosome 390, leaving 2.
Pruned 2 variants from chromosome 391, leaving 6.
Pruned 11 variants from chromosome 392, leaving 4.
Pruned 0 variants from chromosome 393, leaving 4.
Pruned 0 variants from chromosome 394, leaving 2.
Pruned 0 variants from chromosome 395, leaving 1.
Pruning complete.  183708 of 448130 variants removed.
Marker lists written to test.prune.in and test.prune.out .
[13:58:44] shedtke@lims-hpc-m /group/grantlab/scratch/shedtke/SOR/plink $ head test.prune.in
OVOC_OM1a_67
OVOC_OM1a_216
OVOC_OM1a_490
OVOC_OM1a_1124
OVOC_OM1a_1261
OVOC_OM1a_1383
OVOC_OM1a_1953
OVOC_OM1a_2089
OVOC_OM1a_2535
OVOC_OM1a_2952

plink --extract test.prune.in --vcf plink_annot.vcf --genome --recode --out plinkMDS --allow-extra-chr --remove mali.list
PLINK v1.90b3 64-bit (11 Jan 2015)         https://www.cog-genomics.org/plink2
(C) 2005-2015 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to plinkMDS.log.
129068 MB RAM detected; reserving 64534 MB for main workspace.
--vcf: plinkMDS-temporary.bed + plinkMDS-temporary.bim + plinkMDS-temporary.fam
written.
448130 variants loaded from .bim file.
50 people (0 males, 0 females, 50 ambiguous) loaded from .fam.
Ambiguous sex IDs written to plinkMDS.nosex .
--extract: 264422 variants remaining.
--remove: 47 people remaining.
Using up to 15 threads (change this with --threads).
Before main variant filters, 47 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Total genotyping rate in remaining samples is 0.923322.
264422 variants and 47 people pass filters and QC.
Note: No phenotypes present.
--recode to plinkMDS.ped + plinkMDS.map ... done.
IBD calculations complete.
Finished writing plinkMDS.genome .

 

I then converted the prune.in file to a format that could be read by vcftools, and made a vcf with pruned sites

vcftools --vcf ../vcfgha/Ov.Nov15.strict.DP5Q20.rmi.recode.vcf --positions pruned.pos --out ../vcfgha/Ov.Nov15.strict.DP5Q20.rmi.prunedMar2022 --recode --remove-indv OV18 --remove-indv OV42 --remove-indv OV45

VCFtools - v0.1.14
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf ../vcfgha/Ov.Nov15.strict.DP5Q20.rmi.recode.vcf
        --out ../vcfgha/Ov.Nov15.strict.DP5Q20.rmi.prunedMar2022
        --positions pruned.pos
        --recode
        --remove-indv OV18
        --remove-indv OV42
        --remove-indv OV45

Excluding individuals in 'exclude' list
After filtering, kept 47 out of 50 Individuals
Outputting VCF file...
After filtering, kept 252007 out of a possible 448130 Sites
Run Time = 66.00 seconds

## I then removed sites which met HWE with a p<0.01

vcftools --vcf ../vcfgha/Ov.Nov15.strict.DP5Q20.rmi.prunedMar2022.recode.vcf --hwe 0.01 --out mar2022.gha.hwe --recode

VCFtools - v0.1.14
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf ../vcfgha/Ov.Nov15.strict.DP5Q20.rmi.prunedMar2022.recode.vcf
        --max-alleles 2
        --hwe 0.01
        --out mar2022.gha.hwe
        --recode

After filtering, kept 47 out of 47 Individuals
Outputting VCF file...
After filtering, kept 208757 out of a possible 252007 Sites
Run Time = 58.00 seconds

 

For population structure, between countries: [[sites polymorphic in both, remove sites in LD, sites that fail HWE]]
				
				## used my machine to prune cameroon data

vcftools --vcf Ov.Cam.Mar18.

--> 15079 variants meet HWE at p<0.01

vcftools --vcf  --out cam.plink --plink --chrom-map chrom.map.txt

./plink2 --ped-map cam.plink --make-bed --allow-extra-chr

./plink2 --bfile plink2 --indep-pairwise 10kb 1 .8

2906/15079 variants

## removing sites out of HWE with p=0.01 from data

## accidentally wrote over file yay for me

vcftools --vcf Ov.Nov15.strict.DP5Q20.rmi.prunedMar2022.recode.vcf --hwe 0.01 --recode --out Ov.Nov15.strict.DP5Q20.rmi.prunedMar2022

## hopefully I have this backed up somewhere

## well, what I do have is 

cat Ov.Nov15.strict.pruned.nohwe.log

VCFtools - v0.1.14
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf Ov.Nov15.strict.DP5Q20.rmi.prunedMar2022.recode.vcf
        --max-alleles 2
        --hwe 0.05
        --out Ov.Nov15.strict.pruned.nohwe
        --recode

After filtering, kept 47 out of 47 Individuals
Outputting VCF file...
After filtering, kept 193013 out of a possible 252007 Sites
Run Time = 51.00 seconds

## so apparently I already did this. It's even in the above notes. I am an idiot.