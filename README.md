# Hedtke_SOR
 Repository currently under revision.
 Scripts used to assess <i>Onchocerca volvulus sequence data<\i> for sub-optimal response to ivermectin.
 Note that commands are dependent on the program version.
 
 
 (1) Bash scripts that can be used for data analysis on a computational cluster.
 	gha.trim.map.vc.qs : pipeline used on whole-genome sequences of worms from Ghana
  	cam.trim.map.vc.qs : pipeline used on reduced representation sequences of worms from Cameroon
 
 (2) Perl scripts
 These are written to assess various outputs.
	
 	assess_target_depths.pl
  	assess_nearness_of_fst_above_5SD.pl
   	calc_cov_per_chrom_Ov.pl

(3) Multi-sample variant calling 
Bash script for using GATK and freebayes to call variants, and then taking the intersection of the two callers.

(4) Plink commands used to assess associations with sub-optimal response
Commands used are listed.

(5) R scripts
These can be used to produce plots from the MDS outputs, for PCA, and for discriminant analysis of principal components.
