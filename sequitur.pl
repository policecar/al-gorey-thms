#!/usr/bin/env perl -l
# source: Surreptitious Software by Jasvir Nagra, Christian Collberg (Ch. 3 footnote 3)
$w=pop;
$r='A';
while(my($d)=$w=~/^.*(..).*\1/g){
	# print"\$w $w";
	s/$d/$r/g for values%s;
	$w=~s/$d/$r/g;
	$s{$r++}=$d;
}
$v=join" ",($w,values%s);
@k{grep{1<eval"$v=~y/$_/ /"}keys%s}=1;
$n="([".(join" ",grep{!exists$k{$_}}keys%s)."])";
print"Z ->$w";
for(keys%s){ # originally: for(keys%k)
	1while$s{$_}=~s/$n/$s{$1} /eg;
	print"$_ ->$s{$_}";
}