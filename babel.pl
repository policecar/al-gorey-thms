#!/usr/bin/perl
#
# babel.pl -- The Library of Babel, made navigable.
#
# "The universe (which others call the Library) is composed of an
#  indefinite and perhaps infinite number of hexagonal galleries..."
#                                  -- J. L. Borges, 1941
#
# Every possible page of 3200 characters -- 40 lines of 80, in an
# alphabet of twenty-nine: the letters, the space, the comma, the
# period -- exists in the Library exactly once, shelved at an address
# (hexagon, wall, shelf, volume, page).  The mapping is a bijection:
# nothing is stored, nothing is generated; the page you ask for was
# always there, and the page containing this sentence -- and the page
# containing your death notice, correctly dated -- has an address you
# can compute tonight.
#
#   perl babel.pl find 'there is nothing new under the sun'
#   perl babel.pl page <hexagon> <wall> <shelf> <volume> <page>
#   perl babel.pl demo
#
# ( After Jonathan Basile's libraryofbabel.info, 2015, which took
#   Borges literally first.  Alphabet and shelving are his: 4 walls,
#   5 shelves, 32 volumes, 410 pages.  The derangement constant is
#   our own; the Librarians are said to know a deeper one. )

use strict;
use warnings;
use Math::BigInt;

my @ALPHA = ('a'..'z', ' ', ',', '.');
my %DIGIT; @DIGIT{@ALPHA} = 0 .. 28;
my $PAGELEN = 3200;                     # 40 lines x 80 columns
my $PADDED  = 4096;                     # digits padded to a power of two
my ($WALLS, $SHELVES, $VOLUMES, $PAGES) = (4, 5, 32, 410);

my $M = Math::BigInt->new(29)->bpow($PAGELEN);      # 29^3200 pages in all

# the derangement: an affine bijection N -> A*N + B (mod M), so that
# kindred texts are shelved in estranged hexagons, as Borges requires.
my $A = encode_text('the library is unlimited and cyclical');
my $B = encode_text('you who read me, are you sure of understanding my language.');
my $AINV = $A->copy->bmodinv($M);

sub encode_text {                       # 29-ary digits (MSB first) -> BigInt
    my ($text) = @_;
    my @d = map { Math::BigInt->new($DIGIT{$_}) } split //, $text;
    unshift @d, Math::BigInt->bzero while @d < $PADDED;
    my $w = Math::BigInt->new(29);
    while (@d > 1) {                    # divide and conquer, or the
        my @next;                       # conversion outlasts the reader
        push @next, $d[2*$_]->copy->bmul($w)->badd($d[2*$_+1]) for 0 .. $#d/2;
        @d = @next;
        $w = $w->copy->bmul($w);
    }
    return $d[0];
}

sub decode_text {                       # BigInt -> the page, letter by letter
    my ($n) = @_;
    my @out;
    my $t = $n->copy;
    for (1 .. $PAGELEN) {
        my ($q, $r) = $t->bdiv(29);
        unshift @out, $ALPHA[$r->numify];
    }
    return join '', @out;
}

sub normalize {
    my ($text) = @_;
    $text = lc $text;
    $text =~ s/[;:!?]/./g;
    $text =~ s/[^a-z ,.]//g;
    die "the Library owns no page that long\n" if length($text) > $PAGELEN;
    return $text . (' ' x ($PAGELEN - length $text));
}

sub find {                              # text -> address
    my ($text) = @_;
    my $n = encode_text(normalize($text));
    my $g = $n->bmul($A)->badd($B)->bmod($M);
    my ($q, $r);
    ($g, $r) = $g->bdiv($PAGES);    my $page   = $r + 1;
    ($g, $r) = $g->bdiv($VOLUMES);  my $volume = $r + 1;
    ($g, $r) = $g->bdiv($SHELVES);  my $shelf  = $r + 1;
    ($g, $r) = $g->bdiv($WALLS);    my $wall   = $r + 1;
    my $hexagon = lc $g->to_base(36);
    return ($hexagon, $wall, $shelf, $volume, $page);
}

sub fetch {                             # address -> text
    my ($hexagon, $wall, $shelf, $volume, $page) = @_;
    my $g = Math::BigInt->from_base(lc $hexagon, 36);
    $g->bmul($WALLS)->badd($wall - 1);
    $g->bmul($SHELVES)->badd($shelf - 1);
    $g->bmul($VOLUMES)->badd($volume - 1);
    $g->bmul($PAGES)->badd($page - 1);
    my $n = $g->bsub($B)->bmod($M)->bmul($AINV)->bmod($M);
    return decode_text($n);
}

sub print_address {
    my ($hexagon, $wall, $shelf, $volume, $page) = @_;
    print "hexagon: ";
    while (length $hexagon) { print substr($hexagon, 0, 71, ''), "\n         " }
    print "\nwall $wall, shelf $shelf, volume $volume, page $page\n";
}

sub print_page {
    my ($text) = @_;
    print substr($text, $_ * 80, 80), "\n" for 0 .. 39;
}

my $cmd = shift @ARGV // 'demo';

if ($cmd eq 'find') {
    print_address(find(join ' ', @ARGV));
}
elsif ($cmd eq 'page') {
    print_page(fetch(@ARGV));
}
elsif ($cmd eq 'demo') {
    my $text = 'it suffices that a book be possible for it to exist.';
    print "seeking: \"$text\"\n\n";
    my @addr = find($text);
    print_address(@addr);
    print "\nfetching that volume, opening that page:\n\n";
    my $got = fetch(@addr);
    print_page($got);
    $got =~ s/ +$//;
    print "\n", ($got eq normalize($text) =~ s/ +$//r
        ? "the page was there. it was always there.\n"
        : "THE LIBRARIANS HAVE MOVED IT\n");
}
else { die "usage: babel.pl find <text> | page <hex> <wall> <shelf> <vol> <page> | demo\n" }
