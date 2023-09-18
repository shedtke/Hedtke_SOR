
## getting the figures sorted

midvalue<-25755000

startplot=midvalue-15000
endplot=midvalue+15000

chrom="OVOC_OM1b"

plot(fst$POS[fst$CHROM=="OVOC_OM1b"],scale(fst$WEIR_AND_COCKERHAM_FST[fst$CHROM=="OVOC_OM1b"]),xlim=c(startplot,endplot),pch=19,xlab=chrom,ylab="value",ylim=c(0,14),col=transp("black",.8))
##points(probes$V3[probes$V1=="OVOC_OM1b"],y=rep(14,6345),pch=15,col="lightgrey")

abline(h=5,col="red",lw=1.5)

points(ov.cam.nstrmf.p6$POS[ov.cam.nstrmf.p6$CHR==3],scale(-log10(ov.cam.nstrmf.p6$UNADJ[ov.cam.nstrmf.p6$CHR==3])),col=transp("slateblue",.8),pch=19)

points(ov.cam.ncoimf.p4$POS[ov.cam.ncoimf.p4$CHR==3],scale(-log10(ov.cam.ncoimf.p4$UNADJ[ov.cam.ncoimf.p4$CHR==3])),col=transp("brown",.8),pch=19)

