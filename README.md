## al-gorey-thms

A collection of delightful algorithms and dark implementations  
(reminiscent, to this author, of Edward Gorey's illustrations).



### Contents

---

[Fibonacci](https://en.wikipedia.org/wiki/Fibonacci_sequence): a 
[wtfjs](http://wtfjs.com/2013/02/12/obfuscated-fibonacci) implementation based on 
```javascript
js> +[] 
0
```

---

[Sequitur](http://arxiv.org/pdf/cs.AI/9709102.pdf): an implementation in about 300 characters 
of Perl, found in a footnote of 
[Surreptitious Software](http://books.google.de/books?id=mig-bH3u0Z0C&printsec=frontcover&dq=isbn:0132702037).
```perl
perl sequitur.pl abcdbc  
perl sequitur.pl aabaaab
```

---

[MinRay](http://www.cs.utah.edu/~aek/code/card.cpp): a ray tracer the size of a business card in 1337 bytes  
s.a. [Fabien Sanglard's analysis](http://fabiensanglard.net/rayTracing_back_of_business_card/index.php)
and [Paul Heckbert's minimal ray tracer](https://www.cs.cmu.edu/~ph/).
```cpp
c++ -O3 -o minray minray.cpp  
./minray > aek.ppm
```

---
[HelloWorld](http://www.sandraandwoo.com/2015/12/24/0747-melodys-guide-to-programming-languages/): a Hello world program twining round invisible unicode characters.
```rb
ruby hello-world.rb
```

---
[Lovebible](http://www.antipope.org/charlie/blog-static/2013/12/lovebiblepl.html): Charlie Stross' Markov chain generator, originally seeded with the King James Bible and the complete works of H. P. Lovecraft. ( Corpus copied from [here](https://raw.githubusercontent.com/wiseman/initialisms/master/corpora/bible-kjv.txt). )
```perl
cpan Algorithm::MarkovChain
perl lovebible.pl 2> /dev/null
```
---
