## running fst by river basin using the pruned data

#!/bin/bash
#SBATCH --partition=week
#SBATCH --time=120:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=S.Hedtke@latrobe.edu.au

module load VCFtools

#echo 'running fst for Ghana river basins'
#vcftools --vcf ../vcfgha/Ov.Nov15.strict.pruned.nohwe.recode.vcf --weir-fst-pop bv.list --weir-fst-pop pru.list --out ghana.pruned.nohwe.BVvsPru.fst
#vcftools --vcf ../vcfgha/Ov.Nov15.strict.pruned.nohwe.recode.vcf --weir-fst-pop bv.list --weir-fst-pop daka.list --out ghana.pruned.nohwe.BVvsDaka.fst
#vcftools --vcf ../vcfgha/Ov.Nov15.strict.pruned.nohwe.recode.vcf --weir-fst-pop daka.list --weir-fst-pop pru.list --out ghana.pruned.nohwe.PruvDaka.fst

echo 'running fst for Cameroon river basins'
vcftools --vcf Ov.Cam.Mar18.rmi.nos.nohwe.le.recode.vcf --weir-fst-pop mbam.list --weir-fst-pop nkam.list --out cameroon.pruned.nohwe.fst

VCFtools - 0.1.16
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf ../vcfgha/Ov.Nov15.strict.pruned.nohwe.recode.vcf
        --weir-fst-pop bv.list
        --weir-fst-pop pru.list
        --keep bv.list
        --keep pru.list
        --out ghana.pruned.nohwe.BVvsPru.fst

Keeping individuals in 'keep' list
After filtering, kept 29 out of 47 Individuals
Outputting Weir and Cockerham Fst estimates.
Weir and Cockerham mean Fst estimate: 0.0013935
Weir and Cockerham weighted Fst estimate: 0.0022018
After filtering, kept 193013 out of a possible 193013 Sites
Run Time = 1.00 seconds

VCFtools - 0.1.16
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf ../vcfgha/Ov.Nov15.strict.pruned.nohwe.recode.vcf
        --weir-fst-pop bv.list
        --weir-fst-pop daka.list
        --keep bv.list
        --keep daka.list
        --out ghana.pruned.nohwe.BVvsDaka.fst

Keeping individuals in 'keep' list
After filtering, kept 35 out of 47 Individuals
Outputting Weir and Cockerham Fst estimates.
Weir and Cockerham mean Fst estimate: 0.0015702
Weir and Cockerham weighted Fst estimate: 0.0021974
After filtering, kept 193013 out of a possible 193013 Sites
Run Time = 2.00 seconds

## found this work and need to make the figures (why didn't I? I don't know that!)

scatter(ov.sor.pruned.xval$DAPC,scree.da=FALSE,legend=TRUE,cstar=1,clab=0,cex=1.5,cellipse=1,col=gha3col,pch=15)

 

summary(ov.sor.pruned.xval$DAPC)

$n.dim
[1] 2

$n.pop
[1] 3

$assign.prop
[1] 0.787234

$assign.per.pop
     BV/T      Daka       Pru 
0.7647059 0.7777778 0.8333333 

$prior.grp.size

BV/T Daka  Pru 
  17   18   12 

$post.grp.size

BV/T Daka  Pru 
  18   15   14 

 

 


VCFtools - 0.1.16
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
        --vcf ../vcfgha/Ov.Nov15.strict.pruned.nohwe.recode.vcf
        --weir-fst-pop daka.list
        --weir-fst-pop pru.list
        --keep daka.list
        --keep pru.list
        --out ghana.pruned.nohwe.PruvDaka.fst

Keeping individuals in 'keep' list
After filtering, kept 30 out of 47 Individuals
Outputting Weir and Cockerham Fst estimates.
Weir and Cockerham mean Fst estimate: 7.3247e-05
Weir and Cockerham weighted Fst estimate: 0.0022687
After filtering, kept 193013 out of a possible 193013 Sites
Run Time = 2.00 seconds

 (2) test for isolation-by-distance

## using adegenet, convert genind to genpop

ov.sor.pruned.gi@pop<-as.factor(gharbpop)
ov.sor.pruned.gp<-genind2genpop(ov.sor.pruned.gi)

ov.sor.pruned.gdist<-dist.genpop(ov.sor.pruned.gp,method=2)
ov.sor.pruned.gdist


          BV/T      Daka
Daka 0.1043179          
Pru  0.1140941 0.1126096
 

## okay, looks like I need to calculate the distance between the three locations.

## took the average lat and average lon across different communities

gha.rb.coord.df<-data.frame(name=c("BV","Daka","Pru"),lat=c(8.17711725,8.33993444,7.9970639),lon=c(-2.11978225,-0.1857442,-0.864222))

 

gha.rb.coord.df
  name      lat        lon
1   BV 8.177117 -2.1197823
2 Daka 8.339934 -0.1857442
3  Pru 7.997064 -0.8642220

distHaversine(c(gha.rb.coord.df$lat[1],gha.rb.coord.df$lon[1]),c(gha.rb.coord.df$lat[2],gha.rb.coord.df$lon[2]))
[1] 216057.3
distHaversine(c(gha.rb.coord.df$lat[1],gha.rb.coord.df$lon[1]),c(gha.rb.coord.df$lat[3],gha.rb.coord.df$lon[3]))
[1] 141197.2
distHaversine(c(gha.rb.coord.df$lat[2],gha.rb.coord.df$lon[2]),c(gha.rb.coord.df$lat[3],gha.rb.coord.df$lon[3]))
[1] 84623.4

 

gha.rb.dist<-matrix(nrow=3,ncol=3,data=c(c(0,216057.3,141197.2),c(216057.3,0,84623.4),c(141197.2,84623.4,0)))
gha.rb.dist
         [,1]     [,2]     [,3]
[1,]      0.0 216057.3 141197.2
[2,] 216057.3      0.0  84623.4
[3,] 141197.2  84623.4      0.0

as.dist(gha.rb.dist)->gha.rb.dist

mantel.randtest(m1=ov.sor.pruned.gdist,m2=gha.rb.dist)
Monte-Carlo test
Call: mantel.randtest(m1 = ov.sor.pruned.gdist, m2 = gha.rb.dist)

Observation: -0.8338212 

Based on 999 replicates
Simulated p-value: 0.837 
Alternative hypothesis: greater 

    Std.Obs Expectation    Variance 
 -1.2147189   0.0205926   0.4947490 

 

## isolation by distance is not supported by the data

plot(mantel.randtest(m1=ov.sor.pruned.gdist,m2=gha.rb.dist))