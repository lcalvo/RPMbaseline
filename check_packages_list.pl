#!/usr/local/bin/perl -w
# use strict;

my %Hrpm;
my $machine="0 KnownList";
my $line="";
my %SHrpm;

# Load known rpm packages

open(my $fkp, '<', "krpm.lis")
    or die ("Can't open input file krpm.lis: $!\n");


while (my $line=<$fkp>) {
      chomp($line);
      $line =~ s/^\s*(.*?)\s*$/$1/;
      $Hrpm{$machine}{$line}{version}="";
      $Hrpm{$machine}{$line}{insdate}="";
      $Hrpm{$machine}{$line}{size}="";
}

# Reset values

$machine="";
$line="";

# Load rpm packages on each compute node from each exadata listed


open(my $fwp, '<', "rpm.lis")
    or die ("Can't open input file rpm.lis: $!\n");

while (my $line=<$fwp>) {
      chomp($line);
      my ($machine,$rpm,$version,$insdate,$size)=split /:/, $line;
      $rpm =~ s/^\s*(.*?)\s*$/$1/;
      $Hrpm{$machine}{$rpm}{version}=$version;
      $Hrpm{$machine}{$rpm}{insdate}=$insdate;
      $Hrpm{$machine}{$rpm}{size}=$size;
}

# use Data::Dumper;
# print Dumper \%Hrpm;

# my %sorted = sort { $a->{rpm} <=> $b->{rpm} } %Hrpm;
# print join "n", map {$_->{machine}." - ".$_->{rpm}} %sorted ;

# foreach my $rpm (sort keys %{$Hrpm[0]}) {
#     print "$machine, $rpm: $Hrpm{$machine}{$rpm}{version}\n";
# }

foreach my $machine (sort keys %Hrpm) {
    foreach my $rpm (sort keys %{ $Hrpm{$machine} }) {
        $SHrpm{$rpm}{$machine}{version}=$Hrpm{$machine}{$rpm}{version};
        $SHrpm{$rpm}{$machine}{insdate}=$Hrpm{$machine}{$rpm}{insdate};
        $SHrpm{$rpm}{$machine}{size}=$Hrpm{$machine}{$rpm}{size};
#        print "$machine, $rpm: $Hrpm{$machine}{$rpm}{version}\n";
        printf "%15s|%45s|%15s\n",$machine, $rpm, $Hrpm{$machine}{$rpm}{version};
    }
}

my $nCN=0;
my @sComputeNode;
my $formatLine="%45s|";
my $format15="%15s|";
my $cr="\n";

# print tittle

printf $formatLine,"RPM Name & Architecture";
foreach my $machine (sort keys %Hrpm) {
    $nCN = $nCN + 1 ;
    $sComputeNode[$nCN]=$machine;
    printf $format15,$machine;
    $formatLine = $formatLine . $format15;
}
$formatLine=$formatLine . $cr;
printf $cr;

foreach my $rpm (sort keys %SHrpm) {
    printf "%45s|", $rpm;
    foreach my $machine (sort keys %{$SHrpm{$rpm} }) {
        if ($machine eq $sComputeNode[$i])
        printf ""$machine $SHrpm{$rpm}{$machine}{version}:$SHrpm{$rpm}{$machine}{insdate}|";
    }
    print "\n";
}
while (($machine) = each(%Hrpm)) {
print "$machine\n";
}

# foreach $rpm (keys $Hrpm) {
#       print "rpm: $rpm\n";
# }
# foreach $rpm (values $Hrpm) {
#       print "$rpm\n";
# }

