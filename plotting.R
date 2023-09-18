Ov.Cam.Mar18.rmi.mds20 <- read.csv(Ov.Cam.Mar18.rmi.mds20.mds", sep="")

plot(Ov.Cam.Mar18.rmi.mds20$C1,Ov.Cam.Mar18.rmi.mds20$C2,col=pop_col,xlab="C1",ylab="C2",pch=20,cex=2)
legcol<-c("red","green","orange","yellow","purple","blue")
legend("topright",legend=c("MBD0NA","NKD0NA","MBD80SOR","MB80GR","NK80GR","NK80SOR"),fill=legcol,cex=.75)
