#!/usr/bin/perl
#===========================================================================
#
#         FILE:  gashlycrumb.pl
#
#        USAGE:  ./gashlycrumb.pl [seed]
#
#  DESCRIPTION:  A procedural homage to Edward Gorey's "The Gashlycrumb
#                Tinies" (1963), in which twenty-six children come to
#                twenty-six alphabetical ends. Each running of the program
#                buries a fresh class of infants: the names alliterate with
#                their letter, and the fates are dealt in rhyming couplets,
#                so that A and B share a doom-rhyme, C and D another, and so
#                on down to the patient little grave of Z.
#
#                Pass an integer seed to exhume the same children twice.
#
#===========================================================================

use strict;
use warnings;
use List::Util qw(shuffle);

srand($ARGV[0]) if defined $ARGV[0];

# Twenty-six small persons, waiting in the wings, named to match their letter.
my %names = (
    A => [qw(Amy Ada Agnes Augustus Albert Araminta)],
    B => [qw(Basil Beatrice Bertha Baldwin Bruno)],
    C => [qw(Clara Cecil Cuthbert Constance Cyril)],
    D => [qw(Desmond Dora Dahlia Drusilla Donald)],
    E => [qw(Ernest Edith Eustace Eleanor Evangeline)],
    F => [qw(Fanny Felix Fergus Florence Frederick)],
    G => [qw(George Gertrude Gerald Gladys Griselda)],
    H => [qw(Harriet Hugo Hector Hortense Horace)],
    I => [qw(Ida Ignatius Inez Isadore Imogen)],
    J => [qw(James Jane Jasper Josephine Jeremiah)],
    K => [qw(Kate Kenneth Keith Katrina Kingsley)],
    L => [qw(Leo Lucy Lionel Lavinia Lambert)],
    M => [qw(Maud Maurice Millicent Mortimer Maximilian)],
    N => [qw(Neville Nora Nigel Nellie Norbert)],
    O => [qw(Olive Oscar Octavia Osbert Ophelia)],
    P => [qw(Prue Percy Prunella Phineas Persephone)],
    Q => [qw(Quentin Queenie Quintus Quinevere)],
    R => [qw(Rhoda Rupert Roderick Rosamund Reginald)],
    S => [qw(Susan Septimus Sybil Sebastian Selina)],
    T => [qw(Titus Tabitha Theodore Tilly Tobias)],
    U => [qw(Una Ulric Ursula Umberto Unwin)],
    V => [qw(Victor Violet Vera Vincent Verena)],
    W => [qw(Winnie Wilhelmina Wallace Wilfred Winthrop)],
    X => [qw(Xerxes Xanthe Ximena Xavier)],
    Y => [qw(Yorick Yvonne Yolanda Yardley Yseult)],
    Z => [qw(Zillah Zachary Zenobia Zebediah Zinnia)],
);

# Fates, sorted into rhyme-families. A couplet draws two endings from one
# family, so the verse chimes shut like a small coffin lid.
my @rhymes = (
    [ 'fell down the stairs',        'was assaulted by bears',
      'choked upon pears',          'was caught unawares' ],
    [ 'quietly wasted away',         'was thrown from a sleigh',
      'was carried astray',         'expired in dismay' ],
    [ 'drowned in a lake',          'was poisoned by cake',
      'perished of ache',           'died for decorum\'s sake' ],
    [ 'vanished from sight',         'was seized in the night',
      'fell down a flight',         'succumbed to a fright' ],
    [ 'caught a slight chill',       'lies under the hill',
      'was left on the sill',       'forgot their own will' ],
    [ 'was tipped from a tree',      'was stung by a bee',
      'drowned in the sea',         'died of ennui' ],
    [ 'fell out of bed',            'was struck on the head',
      'is presumably dead',         'turned curiously red' ],
    [ 'was never quite found',       'was decorously drowned',
      'sank into the ground',        'made not a sound' ],
    [ 'perished by fire',           'expired in the mire',
      'was strung on a wire',        'was fed to the pyre' ],
    [ 'met with their doom',         'was sealed in a room',
      'dissolved in the gloom',      'was mislaid in a tomb' ],
    [ 'was crushed by a car',        'was dropped from afar',
      'wandered too far',            'fell into the tar' ],
    [ 'grew suddenly old',          'was left in the cold',
      'did just as they\'re told',   'was bartered and sold' ],
    [ 'was lost in the rain',        'went clean off the train',
      'cracked open their brain',    'was never seen again' ],
);

my @letters = ('A' .. 'Z');

# Pair the alphabet into thirteen couplets and dispatch the children.
for ( my $i = 0 ; $i < @letters ; $i += 2 ) {
    my ($l1, $l2) = @letters[ $i, $i + 1 ];

    my @family = shuffle @{ $rhymes[ int rand @rhymes ] };
    my ($fate1, $fate2) = @family[ 0, 1 ];

    emit( $l1, pick($names{$l1}), $fate1, ',' );
    emit( $l2, pick($names{$l2}), $fate2, '.' );
    print "\n";
}

sub pick { my $a = shift; $a->[ int rand @$a ] }

sub emit {
    my ($letter, $name, $fate, $stop) = @_;
    printf "%s is for %s who %s%s\n", $letter, $name, $fate, $stop;
}
