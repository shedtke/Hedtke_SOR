#!/usr/bin/perl

### Having written a script that randomizes fst values with respect to position... I now want to assess whether there are two high-fst values within a cutoff range

my $filename=$ARGV[0];
my $cutoff=$ARGV[1];   ## this is window size in bp
my $mult_SD=5; ## how many standard deviations above the mean you want

my %average;
my %seen;
my $numregions=0;
my %pairs;
my %assess_pairs;
my $total=0;
my $count=0;
my @all_fst;
my $std=0;
my @list_pairs;

open(DATA,$filename);
my @data=<DATA>;
close DATA;

my $compare_to=0;
for (my $j=0;$j<scalar@data; $j++) { # for each line in the file...
        if ($data[$j]=~/CHROM/ | $data[$j-1]=~/CHROM/) {next;}
        my @info=split(/\t/,$data[$j]);
        if ($info[2]=~/nan/) {next;}
#print $info[2];
        chomp $info[2];
        if ($info[2] eq '') {next;}
        push(@all_fst,$info[2]);
#               print "\n$j $total";
        $total=$total+$info[2];
        $count++;
        push(@{$assess_pairs{$data[$j]}},$info[2]);
        push(@{$pairs{$data[$j]}},$data[$j]);

                if ($j>0) {
                        for (my $k=$j+1;$k<scalar@data;$k++) {
                                my @info_comp=split(/\t/,$data[$k]);
                                if ($info_comp[0] eq $info[0]) { # must be on same chromosome
                                        if ($info_comp[1]-$info[1]<$cutoff+1) { # if they are within the cutoff value of nearness
                                                unless ($k>$j+1) {push (@list_pairs,$data[$j]);}
                                                chomp $info_comp[2];
                                                push(@{$assess_pairs{$data[$j]}},$info_comp[2]); # then store the fst value for the second in the pair
                                                push(@{$pairs{$data[$j]}},$data[$k]);
                                } ## ends if they are within the cutoff value

                                if ($info_comp[1]-$info[1]>=$cutoff) {$k=scalar@data;} # but if they are greater than cutoff apart, move on to the next position
                        } # this ends the loop for it being on the same chromosome
                } # this ends the for loop for comparing this line of data to the one after it
                } # this ends the $j can't be 0 statement
        } # this ends the going through each line of j (why does this happen?)

#       print "total $total count $count";
        unless($count==0) {
                $average{$i}=$total/$count;
                my $sqtotal=0;
        foreach(@all_fst) {
                my $test=$average{$i}-$_;
                $sqtotal += ($average{$i}-$_) ** 2;
        } ## this ends the loop for average (foreach)

        $std = ($sqtotal / (@all_fst-1)) ** 0.5;
        } ## this ends the calc of sd (unless)

        my $testvalue=(($mult_SD*$std) + $average{$i});


        my $yes=0;
        my $no=0;

for (my $x=0;$x<scalar@list_pairs;$x++) {
        my $id=$list_pairs[$x];
        if (scalar@{$assess_pairs{$id}}==1) {next;}
        if (@{$assess_pairs{$id}}[0]<$testvalue) {$no++; next;}
        for (my $j=1;$j<scalar@{$assess_pairs{$id}}; $j++) {
                if (@{$assess_pairs{$id}}[0]>$testvalue && @{$assess_pairs{$id}}[$j]>$testvalue) {
                        $yes++;
                        if ($seen{$id} eq '') {$numregions++; print "$referR$numregions\t$id"; $seen{$id}++;}
                        if ($seen{@{$pairs{$id}}[$j]} eq '') {print "$referR$numregions\t@{$pairs{$id}}[$j]"; $seen{@{$pairs{$id}}[$j]}++;  }
} ## this ends the assessment and printing because the two pairs meet the cutoff

        else {$no++;
                } ## this ends what to do if the pairs don't meet testvalue
} ## this bracket ends the assessing pairs for statement
        }## this bracket ends the while loop for printing

        my $totalpairs=$yes+$no;
        print "\nFor $filename, $totalpairs pairs were within $cutoff bp.\nFor $yes pairs, both had fst values $mult_SD xSD higher than the mean of $average{$i} ($testvalue), grouped into $numregions clusters; $no did not.";



end;