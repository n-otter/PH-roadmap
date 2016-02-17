#! /usr/bin/perl

#This file computes the Hamming distance of DNA sequences, taking as input one of the data sets from the 'Topology of viral evolution' paper
#Input is alignment of genome sequence
#Output is distance matrix with hamming distance.

# Nina Otter, Oxford 2015

use warnings;
use strict;



my $in=shift;

open IN, $in or die $!;
my $out="$in";
$out="$out".'_hdm.txt';
open OUT, ">$out" or die $!;

my @sequence;
my @distance;

undef $/;
@sequence=split(/>/, <IN>);

my $length=$#sequence;
my $index=-1;
my @new_sequence;

for (0 .. $length){
  if ( length($sequence[$_])>0 ){
  $index=$index+1;
  $new_sequence[$index]=$sequence[$_];
}
}

my $new_length=$#new_sequence;
my @item;
for (0 .. $new_length){
  ($item[$_])=$new_sequence[$_]=~m/^(.*\d\n)/;
  print "$item[$_]\n";
  $new_sequence[$_]=~s/$item[$_]//;
  $new_sequence[$_]=~s/\n//g;
  $item[$_]=~s/\n//;
 } 


print length($new_sequence[0]);
print "\n";
print length($new_sequence[1]);
print length($new_sequence[2]);
#if ($new_sequence[0]=~m/(.\d\n)/){
#my ($n)=$new_sequence[0]=~m/^(.*\d\n)/;
# print  "$n\n";}
my @D;
for my $i (0 .. $new_length){
  for my $j (0 .. $new_length){
    $D[$i]->[$j]=hd($new_sequence[$i],$new_sequence[$j]);
    print OUT "$D[$i]->[$j] ";
  }
  print OUT "\n";
}

#print "\n$D[0]->[0]\n $D[0]->[1] \n $D[1]->[0]\n";
sub hd {
   return ($_[0] ^ $_[1]) =~ tr/\001-\255//;
}


close IN;
close OUT;
