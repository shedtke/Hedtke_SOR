library(ggplot2)

convertprobes<-read.table("probes.try2")

probestest<-data.frame(dens=convertprobes$V3,chrom=convertprobes$V2)

probescol<-c("#440154FF","#31688EFF","#35B779FF","white")

ggplot(probestest, aes(x = dens, fill = chrom)) + geom_density(alpha = 0.5) + scale_fill_manual(values=probescol) + xlab("Chromosome position")

ggplot(probestest, aes(x = dens, fill = chrom)) + geom_density(alpha = 0.5,adjust=1/4) + scale_fill_manual(values=probescol) + xlab("Chromosome position")