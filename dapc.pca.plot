## number of variants in Cameroon data after pruning for LD and HWE: 12,173

summary(cam.pruned.sor.xval$DAPC)
$n.dim
[1] 1

$n.pop
[1] 2

$assign.prop
[1] 0.9655172

$assign.per.pop
     Mbam      Nkam 
1.0000000 0.8947368 

$prior.grp.size

Mbam Nkam 
  39   19 

$post.grp.size

Mbam Nkam 
  41   17 

s.class(cam.pruned.sor.pca$li,fac=camrbpopfac,col=transp(cam2col,.6),clab=0,pch=19,grid=0,cpoint=1.25)

## very poor differentiation when look at the pca, but there is the ability to discriminate between parasites collected at different river basins.

 

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

ov.sor.pruned.xval$DAPC
        #################################################
        # Discriminant Analysis of Principal Components #
        #################################################
class: dapc
$call: dapc.data.frame(x = as.data.frame(x), grp = ..1, n.pca = ..2, 
    n.da = ..3)

$n.pca: 20 first PCs of PCA used
$n.da: 2 discriminant functions saved
$var (proportion of conserved variance): 0.537

$eig (eigenvalues): 43.92 19.21  vector    length content                   
1 $eig      2      eigenvalues               
2 $grp      47     prior group assignment    
3 $prior    3      prior group probabilities 
4 $assign   47     posterior group assignment
5 $pca.cent 415889 centring vector of PCA    
6 $pca.norm 415889 scaling vector of PCA     
7 $pca.eig  46     eigenvalues of PCA        

  data.frame    nrow   ncol content                                          
1 $tab          47     20   retained PCs of PCA                              
2 $means        3      20   group means                                      
3 $loadings     20     2    loadings of variables                            
4 $ind.coord    47     2    coordinates of individuals (principal components)
5 $grp.coord    3      2    coordinates of groups                            
6 $posterior    47     3    posterior membership probabilities               
7 $pca.loadings 415889 20   PCA loadings of original variables               
8 $var.contr    415889 2    contribution of original variables               

cam.pruned.sor.xval$DAPC
        #################################################
        # Discriminant Analysis of Principal Components #
        #################################################
class: dapc
$call: dapc.data.frame(x = as.data.frame(x), grp = ..1, n.pca = ..2, 
    n.da = ..3)

$n.pca: 25 first PCs of PCA used
$n.da: 1 discriminant functions saved
$var (proportion of conserved variance): 0.581

$eig (eigenvalues): 99.46  vector    length content                   
1 $eig      1      eigenvalues               
2 $grp      58     prior group assignment    
3 $prior    2      prior group probabilities 
4 $assign   58     posterior group assignment
5 $pca.cent 24346  centring vector of PCA    
6 $pca.norm 24346  scaling vector of PCA     
7 $pca.eig  57     eigenvalues of PCA        

  data.frame    nrow  ncol content                                          
1 $tab          58    25   retained PCs of PCA                              
2 $means        2     25   group means                                      
3 $loadings     25    1    loadings of variables                            
4 $ind.coord    58    1    coordinates of individuals (principal components)
5 $grp.coord    2     1    coordinates of groups                            
6 $posterior    58    2    posterior membership probabilities               
7 $pca.loadings 24346 25   PCA loadings of original variables               
8 $var.contr    24346 1    contribution of original variables               

> 

 cam.pruned.sor.pca
Duality diagramm
class: pca dudi
$call: dudi.pca(df = cam.pruned.sor.X, center = TRUE, scale = FALSE, 
    scannf = FALSE, nf = 200)

$nf: 57 axis-components saved
$rank: 57
eigen values: 185.4 170.3 160.9 145.7 122 ...
  vector length mode    content       
1 $cw    24346  numeric column weights
2 $lw    58     numeric row weights   
3 $eig   57     numeric eigen values  

  data.frame nrow  ncol  content             
1 $tab       58    24346 modified array      
2 $li        58    57    row coordinates     
3 $l1        58    57    row normed scores   
4 $co        24346 57    column coordinates  
5 $c1        24346 57    column normed scores
other elements: cent norm 

 

ov.sor.pruned.pca
Duality diagramm
class: pca dudi
$call: dudi.pca(df = ov.sor.pruned.X, center = TRUE, scale = FALSE)

$nf: 5 axis-components saved
$rank: 46
eigen values: 1979 1651 1626 1393 1339 ...
  vector length mode    content       
1 $cw    415889 numeric column weights
2 $lw    47     numeric row weights   
3 $eig   46     numeric eigen values  

  data.frame nrow   ncol   content             
1 $tab       47     415889 modified array      
2 $li        47     5      row coordinates     
3 $l1        47     5      row normed scores   
4 $co        415889 5      column coordinates  
5 $c1        415889 5      column normed scores
other elements: cent norm 

 

### how do I find the % variance again?

## I think this is right:

ov.sor.pruned.pca$eig[1]/sum(ov.sor.pruned.pca$eig)
[1] 0.04152631

ov.sor.pruned.pca$eig[2]/sum(ov.sor.pruned.pca$eig)
[1] 0.0346421

 cam.pruned.sor.pca$eig[1]/sum(cam.pruned.sor.pca$eig)
[1] 0.04257486

 

cam.pruned.sor.pca$eig[2]/sum(cam.pruned.sor.pca$eig)
[1] 0.03911656

s.class(ov.sor.pruned.pca$li,fac=as.factor(gharbpop),col=transp(gha3col,.9),clab=0,pch=15,grid=0,cellipse=0,cstar=0)
s.class(cam.pruned.sor.pca$li,fac=camrbpopfac,col=cam2col,clab=0,pch=17,grid=0,cstar=0,cellipse=0)

scatter(cam.pruned.sor.xval$DAPC,scree.da=FALSE,legend=FALSE,cstar=1,clab=0,cellipse=1,col=cam2col,pch=17)
scatter(ov.sor.pruned.xval$DAPC,scree.da=FALSE,legend=TRUE,cstar=1,clab=0,cellipse=1,col=gha3col,pch=15)

as.data.frame(ov.sor.pruned.xval$DAPC$posterior)->ov.tmp
ov.tmp$location<-gharbpop
ov.tmp$id<-rownames(ov.tmp) #%>% substr(start = 1, stop = 3)
ov.tmp$K<-"K = 3"
ov.tmp3<-melt(ov.tmp,id=c("location","id","K"))
names(ov.tmp3)[4:5]<-c("Group","Posterior")
ggplot(ov.tmp3, aes(x = id, y = Posterior, fill = Group))+geom_bar(stat = "identity")+theme_bw()+ylab("Posterior membership probability")+ theme(legend.position='none')+scale_fill_manual(values=gha3col)+ theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 8))->ov.ggp
ov.ggp+facet_grid(K ~ location, scales = "free_x", space = "free")

as.data.frame(cam.pruned.sor.xval$DAPC$posterior)->ov.tmp
ov.tmp$location<-camrbpop
ov.tmp$id<-rownames(ov.tmp) #%>% substr(start = 1, stop = 3)
ov.tmp$K<-"K = 2"
ov.tmp3<-melt(ov.tmp,id=c("location","id","K"))
names(ov.tmp3)[4:5]<-c("Group","Posterior")
ggplot(ov.tmp3, aes(x = id, y = Posterior, fill = Group))+geom_bar(stat = "identity")+theme_bw()+ylab("Posterior membership probability")+ theme(legend.position='none')+scale_fill_manual(values=cam2col)+ theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 8))->ov.ggp
ov.ggp+facet_grid(K ~ location, scales = "free_x", space = "free")