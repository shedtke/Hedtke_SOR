PRS
read.table("D:/Research backup 22Oct20/Hedtke_et_al_SOR/P6.Oct.prs.0.profile.d80",header=TRUE)->p6

p6df<-data.frame(pheno=log(p6$PHENO[p6$PHENO>-1]+1),score=p6$SCORE[p6$PHENO>-1])

 

read.table("D:/Research backup 22Oct20/Hedtke_et_al_SOR/P6_Oct_prs.0.profile.pheno.D0",header=TRUE)->p6.d0

p6d0df<-data.frame(pheno=log(p6.d0$smf+1),score=p6.d0$score)

ggscatter(p6df,x="pheno",y="score",add="reg.line",conf.int=TRUE)+xlab("Log count stretched mf + 1") + ylab("PRS")+geom_point()+geom_point(data=p6d0df,col="blue")
## to get the correlation coefficient, I just did

ggscatter(p6df,x="pheno",y="score",add="reg.line",conf.int=TRUE,cor.coef=TRUE)