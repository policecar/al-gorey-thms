#!/usr/bin/perl
#===========================================================================
#
#         FILE:  lovebible.pl
#
#        USAGE:  ./lovebible.pl
#
#      VERSION:  1.1
#      CREATED:  05/12/2013 20:08:15 GMT
#     REVISION:  vendored Algorithm::MarkovChain into ./lib; dropped Path::Class
#===========================================================================

use strict;
use warnings;
use FindBin;
use lib "$FindBin::RealBin/lib";   # the vendored Algorithm::MarkovChain — no CPAN install needed
use Algorithm::MarkovChain;
use autodie;                       # die if there is a problem reading a file

my @inputs = qw(king_james_bible.txt lovecraft_complete.txt);
my @symbols = ();
foreach my $f (@inputs) {
    my $lcounter = 0;
    my $wcounter = 0;
    open(my $fh, '<', $f);          # autodie throws on failure
    while (my $line = <$fh>) {
        chomp($line);
        my @words = split(' ', $line);
        push(@symbols, @words);
        $lcounter++;
        $wcounter += scalar(@words);
    }
    close($fh);
    print "$lcounter lines, $wcounter words read from $f\n";
}

my $chain = Algorithm::MarkovChain::->new();
$chain->seed(symbols => \@symbols, longest => 6);
print "About to spew ...\n";
print "---\n\n";
foreach (1 .. 20) {
    my @newness = $chain->spew(length   => 40,
                               complete => [ qw( the ) ]);
    print join(" ", @newness), ".\n\n";
}
