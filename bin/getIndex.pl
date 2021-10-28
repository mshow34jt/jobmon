#!/usr/bin/perl
use strict;
use warnings;
 
my $file = $ARGV[0] or die "Need to get CSV file on the command line\n";
 
my $sum = 1;
open(my $data, '<', $file) or die "Could not open '$file' $!\n";
 
while (my $line = <$data>) {
  chomp $line;
 
  my @fields = split "," , $line;
 foreach my $field ( @fields ) {
  print "$sum $field\n";
  $sum += 1;
 } 
}
