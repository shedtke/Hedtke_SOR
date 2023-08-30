#!/usr/bin/perl

my $snpsfile=$ARGV[0];
my $vcffile=$ARGV[1];

open(SNPS,$snpsfile);
my @snps=<SNPS>;
close SNPS;
my $start=0;
my $ontarget=0;
my $offtarget=0;
my $count=0;
my $list_ontarget;
my $list_offtarget;
my %target;
my $targetshit=0;

open(VCF,$ARGV[1]);

while (<VCF>) {
        if ($_=~/^\#/){next;}
        $count++;
        my $decide=0;
        my @line=split(/\t/,$_);
        my $chrom=$line[0];
        my $pos=$line[1];
        for (my $i=0; $i<scalar@snps; $i++) {
                my @info=split(/\t/,$snps[$i]);
                my $snpchrom=$info[0];
                my $snppos=$info[1]+1;
                chomp $snps[$i];
                if ($chrom eq $snpchrom) {
                        if (($pos>$snppos-500 && $pos <=$snppos) || ($pos<$snppos+500 && $pos>=$snppos)) {
                                $ontarget++;
                                $start++;
                                $decide++;
                                $target{$snps[$i]}++;
                                $list_ontarget=$list_ontarget.$chrom."\t".$pos."\n";
                                if ($pos==$snppos) {$targetshit++;}
                                }

                        }
                }
        if ($decide==0) {$offtarget++;$list_offtarget=$list_offtarget.$chrom."\t".$pos."\n";}
}

close VCF;

#print "Chromosome\tPosition\n";
print "\n\n I counted $offtarget off-target snps and $ontarget snps within 500 bp of target snps out of $count total snps in the file.\n\n";
#print "OFFTARGET\n$list_offtarget\n\nONTARGET\n$list_ontarget\n\n";
print "I also calculated that $targetshit were genotyped in $vcffile.\n";
print "Targets that do not have a SNP within 500 bp:";

for (my $i=0; $i<scalar@snps; $i++) {
        if ($target{$snps[$i]}<1) {print "\n$snps[$i]";}
}
print "\n\n";

end;