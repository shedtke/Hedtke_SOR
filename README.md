# Hedtke_SOR
 Repository currently under revision.

 Scripts used to assess <i>Onchocerca volvulus</i> sequence data for sub-optimal response to ivermectin.

Please cite: Hedtke SM, Armoo S, Doyle SR, Abong R, Amombo GN, Mitreva M, Osei-Atweneboana MY, Wanji S, Kuesel AC, Grant WN. Genome-based tools for onchocerciasis elimination: <i>Onchocerca volvulus</i> genetic markers for response to ivermectin and geographic origin. in preparation.
 
 Note that commands are dependent on the program version.
 
 <b>Pipeline</b>
 
 (1) Bash scripts that can be used for data analysis on a computational cluster.
 	gha.trim.map.vc.qs : pipeline for trimming, mapping, and calling variants for a single worm, used on whole-genome sequences of worms from Ghana
  	cam.trim.map.vc.qs : pipeline for trimming, mapping, and calling variants for a single worm, used on reduced representation sequences of worms from Cameroon
		associated files:
			NexteraPE.fa : file used for Ghana trimming
				: file used for Cameroon trimming
(2) Perl scripts for assessing coverage and quality
	calc_cov_per_chrom_Ov.pl : used for all mapped sequences
	assess_target_depths.pl : used to assess depth of individual targets from the reduced representation data set
(3) Identifying repeat sites in the Ov_v3 genome
	
(4)	Calling variants and filtering the data
	gatkGG.qs: commands for calling multi-sample variants
	freebayes.qs: commands for calling multi-sample variants
	isec.qs: commands for finding the intersection of GATK and freebayes variant calls
	filter.qs: commands used for filtering vcf for quality
	xx : used for identifying shared polymorphic sites between the Ghana and Cameroon data
(5) Identifying high-fst variants in the Ghana dataset
		: randomize fst values
	assess_nearness_of_fst_above_5SD.pl : determine how close Fst values are to each other
(6) Plink commands used to assess associations with sub-optimal response in the Cameroon data
		: identify highly associated variants
		: PRS analysis
		associated files:
			chromosome : required for this version of plink
		: haplotype blocks
		: 
(7) Annotation using SNPEff

(8) Analysis and plotting in R
		: map (Figure 1)
		: MDS (Figure #)
		: PCA (Figure #)
		: DAPC (Figure #)
		: Highly associated variants (Suppl. Figs, Figure #)
		: figure 
		: PRS plots (Fig #)