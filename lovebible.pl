#!/usr/bin/perl 
#===========================================================================
#
#         FILE:  lovebible.pl
#
#        USAGE:  ./lovebible.pl 
#
#      VERSION:  1.0
#      CREATED:  05/12/2013 20:08:15 GMT
#     REVISION:  ---
#===========================================================================

use strict;
use warnings;
use Algorithm::MarkovChain;
use Path::Class;
use autodie; # die if problem reading or writing a file

my @inputs = qw(king_james_bible.txt lovecraft_incomplete.txt); 
my $dir = dir(".");
my $f = "";
my @symbols = ();
foreach $f (@inputs) {
    my $file = $dir->file($f);
	my $lcounter = 0;
    my $wcounter = 0;
    my $file_handle = $file->openr();
    while( my $line = $file_handle->getline() ) {
		chomp ($line);
		my @words = split(' ', $line);
        push(@symbols, @words);
		$lcounter++;
		$wcounter += scalar(@words);
    }
	print "$lcounter lines, $wcounter words read from $f\n";
}   
my $chain = Algorithm::MarkovChain::->new();
$chain->seed(symbols => \@symbols, longest => 6);
print "About to spew ...\n";
print "---\n\n";
foreach (1 .. 20) {
    my @newness = $chain->spew(length   => 40,
                               complete => [ qw( the ) ]);
    print join (" ", @newness), ".\n\n";
}