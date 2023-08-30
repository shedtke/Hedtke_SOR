#!/usr/bin/perl

my $bedfile="target_ST2021G_1_973.bed";
my $cutoff=20;

my @chroms;
my @pos;
my $file=$ARGV[0];
my $num_targets=0;
my $start=0;
my $num_targets_hit=0;
my $total_depth_targets=0;
my $avg_depth_targets=0;
my $avg_depth_targets_hit=0;
my $num_targets_over_cutoff=0;
my %targets;

open(BED,$bedfile);

my @bed=<BED>;
close BED;
for (my $i=0; $i<scalar@bed; $i++) {
        my @line=split(/\t/,$bed[$i]);
        push (@chroms,$line[0]); push (@pos,$line[1]);
        $num_targets++;
}

open(DATA,$file);


while (<DATA>) {
        if ($_=~/^\#/) {next;}
        my @line=split(/\t/,$_);
        my $chrom=$line[0];
        my $position=$line[1];
#       my $depth=$line[2];
#       if ($depth==0) {next;}
        for (my $i=$start; $i<scalar@chroms; $i++) {
                if ($chrom eq $chroms[$i] && $position==$pos[$i]) {
#                       print "$chrom\t$position\t$depth";
                        $num_targets_hit++;
#                       $total_depth_targets=$total_depth_targets+$depth;
#                       if ($depth>=$cutoff) {
#                               $num_targets_over_cutoff++;
#                               print "x";
                                $targets{$chrom."_".$position}++;
#                               }
#                       $start=$i;
#                       $i=scalar@chroms;
}
}

}

#print "\n\nTotal number of targets hit out of $num_targets total: $num_targets_hit\n";
#$avg_depth_targets=$total_depth_targets/$num_targets;
#$avg_depth_targets_hit=$total_depth_targets/$num_targets_hit;
#print "\n\nThe average depth of all target SNPs was $avg_depth_targets while the average of target SNPs hit was $avg_depth_targets_hit\n\n";
#print "Only $num_targets_over_cutoff were above the desired depth of $cutoff\n\n";

for (my $i=0; $i<scalar@chroms; $i++) {
        if ( $targets{$chroms[$i]."_".$pos[$i]}<1 ) {print "$chroms[$i]\t$pos[$i]\n";}
#       if ($targets{$chroms[$i]."_".$pos[$i]}==1) {print "boo";}
}

end;