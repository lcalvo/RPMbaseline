#!/usr/local/bin/perl

my %Hrpm;
my $machine="KnownList";

# Load known rpm packages

open(my $fkp, '<', "krpm.lis")
    or die ("Can't open input file krpm.lis: $!\n");


while (my $line=<$fkp>) {
      chomp($line);
#      $line=~ tr / //ds;
      $line =~ s/^\s*(.*?)\s*$/$1/;
      print "$line\n";
      $Hrpm{$machine}{$line}{version}=null;
      $Hrpm{$machine}{$line}{insdate}=null;
      $Hrpm{$machine}{$line}{size}=null;
}

use Data::Dumper;
print Dumper \%Hrpm;
