#!/usr/bin/perl

## I want to determine the probability that, given the observed distribution of fst values, two high-fst values would be adjacent to each other
## I believe that randomizing the values relative to SNP position and determining how many are by random chance adjacent (or within a certain range)
## S Hedtke 7 June 2016 LTU

## usage: perl randomize_fst_values.pl $fstfile $numiterations
## where $fstfile = tab-delimited file with chromosome\tposition\tfst-value (as output e.g. by vcftools)
## and $numiterations is the number of files you want to generate with randomized data
## then pipe the output to assess

my $fstfile=$ARGV[0];
my $numiterations=$ARGV[1];
my @values;
my @positions;
#my $numiterations=100;
my %results;

## (1) input the fst values and positions

open(DATA,$fstfile);

while (<DATA>) {
        if ($_=~/^CHROM/) {next;}
        my @info=split(/\t/,$_);
        if ($info[2]=~/nan/) {next;}
        my $pos="$info[0]\t$info[1]";
        my $fst=$info[2];
        push (@positions,$chrom.$pos);
        push (@values,$fst);
}

close DATA;


for (my $j=0; $j<$numiterations; $j++) {
        my $outfile=$ARGV[0].".randomized.$j";
        open(OUT,">$outfile");
for (my $i=0; $i<scalar@positions; $i++) {
        my $random=int(rand(scalar@positions));
#print $random;
        $results{$positions[$i]}=$values[$random];
        print OUT "$positions[$i]\t$results{$positions[$i]}";
}
}


end;