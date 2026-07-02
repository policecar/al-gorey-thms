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
The file only defines `fib` (so `node fibonacci.js` prints nothing); load it, then call it:
```javascript
node -e 'eval(require("fs").readFileSync("fibonacci.js","utf8")); console.log(fib(10))'
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
[Lovebible](http://www.antipope.org/charlie/blog-static/2013/12/lovebiblepl.html): Charlie Stross' Markov chain generator, originally seeded with the King James Bible and the complete works of H. P. Lovecraft. ( The King James corpus was copied from [here](https://raw.githubusercontent.com/wiseman/initialisms/master/corpora/bible-kjv.txt) and Lovecraft from [here](https://github.com/nathanielksmith/lovecraftcorpus). )
```perl
# Algorithm::MarkovChain is vendored under ./lib — no install needed
perl lovebible.pl 2> /dev/null
```

---
[Travesty](https://archive.org/details/byte-magazine-1984-11): Hugh Kenner & Joseph O'Rourke's drivel generator from BYTE, November 1984 — ancestor of every Markov mangler above, reconstructed in the manner of the original Pascal listing. No tables are built, for the micro has no memory to spare: for every letter emitted the whole text is searched anew, and English decays into an author-shaped residue.
```
fpc -Mtp -v0 travesty.pas
./travesty lovecraft_complete.txt 5 600
```

---
[Dissociated Press](https://www.gnu.org/software/emacs/manual/html_node/emacs/Dissociated-Press.html): the travesty generator that has shipped inside GNU Emacs since 1985, waiting quietly behind `M-x` for forty years. Vendored verbatim from `lisp/play/dissociate.el` (GPL, © FSF).
```
emacs --batch -l dissociate.el --eval '(progn (random t) (find-file "lovecraft_complete.txt") (defalias (quote y-or-n-p) (lambda (&rest _) nil)) (dissociated-press 2) (with-current-buffer "*Dissociation*" (princ (buffer-string))))'
```

---
[Cent mille milliards de poèmes](https://en.wikipedia.org/wiki/Hundred_Thousand_Billion_Poems): Raymond Queneau's 1961 book-machine — ten sonnets cut into fourteen strips, 10^14 poems, about 190 million years of continuous reading. Queneau's own sonnets sleep in copyright until the 2040s, so the machine is fitted with the ten darkest sonnets of Shakespeare (60, 64, 65, 66, 71, 73, 74, 90, 129, 146), a substitution the Oulipo would be obliged to permit. In awk, 1977.
```
awk -f queneau.awk sonnets_dark.txt
```

---
[The Library of Babel](https://libraryofbabel.info): Borges, 1941, taken literally (after Jonathan Basile, 2015): an invertible bijection between every possible 3200-character page and its shelf address. Nothing is stored, nothing is generated — the page containing your death notice, correctly dated, has an address you can compute tonight.
```
perl babel.pl demo
perl babel.pl find 'there is nothing new under the sun'
```

---
[Game of Life](https://aplwiki.com/wiki/John_Scholes%27_Conway%27s_Game_of_Life): John Scholes' one line of Dyalog APL (2009), and the same organism re-inscribed in [BQN](https://mlochbaum.github.io/BQN/), Marshall Lochbaum's APL descendant — two generations of hieroglyphs for one deathless automaton. The APL runs on the long-abandoned npm package `apl` (ngn/apl, an APL written in JavaScript, last touched 2016); the BQN wants [CBQN](https://github.com/dzaima/CBQN).
```
npm install apl
node -e 'console.log(String(require("apl")(require("fs").readFileSync("life.apl","utf8"))))'
```

---
[Twelve Days of Christmas](https://www.ioccc.org/years.html#1988): Ian Phillipps' 1988 IOCCC winner — one recursive main(), two cipher strings, the entire carol. Transcribed from its many reproductions and verified by its own singing: a wrong byte anywhere and the true love brings garbage.
```
gcc -std=gnu89 -w -o twelve_days twelve_days.c
./twelve_days
```

---
[Duff's Device](https://en.wikipedia.org/wiki/Duff%27s_device): Tom Duff, Lucasfilm, November 1983 — a do-while and a switch occupying the same body, like a man and his ghost. The artifact is really the email ("I feel a combination of pride and revulsion at this discovery"); the harness merely confirms its central claim.
```
gcc -std=gnu89 -w -o duff duff.c && ./duff
```

---
[Quine](https://en.wikipedia.org/wiki/Quine_(computing)): the ouroboros, twice. In C, a program whose output is byte-identical to its own source; in Lisp, the older folklore form — author unknown, oral tradition since the 1960s — which does not print itself because it *is* itself: a fixed point of eval.
```
gcc -w -o quine quine.c && ./quine | diff quine.c - && echo it lives
sbcl --script quine.lisp
```

---
[Sleep sort](https://web.archive.org/web/2011/http://dis.4chan.org/read/prog/1295544154): posted by Anonymous to 4chan's /prog/ on 20 January 2011 at 12:22. Each number sleeps for its own value, then announces itself; time is the comparator, the scheduler is the sorting network. First reply, 12:27: "Oh god, it works."
```
./sleepsort.sh 5 3 6 3 6 3 1 4 7
```

---
[Quantum bogosort](https://en.wikipedia.org/wiki/Bogosort#Related_algorithms): shuffle; if the list is not sorted, destroy the universe. Implemented with real fork(): unsorted branches of the multiverse are annihilated, and you — necessarily — are reading this in a branch where the list came out sorted, in O(n). It has never once been observed to fail.
```
cc -o quantum_bogosort quantum_bogosort.c
./quantum_bogosort 9 1 8 6 6 2 0 4
```

---
[Josephus problem](https://en.wikipedia.org/wiki/Josephus_problem): the cave at Yodfat, 67 AD — forty-one men in a circle, every third one slain, and Flavius Josephus, "whether by fortune or by the providence of God," reckoning his way to seat 31. In sed, because a stream editor is precisely a machine for striking names from a list.
```
seq 41 | sed -E -f josephus.sed
```

---
[Reservoir sampling](https://en.wikipedia.org/wiki/Reservoir_sampling): Algorithm R (A. G. Waterman; s. Knuth, TAOCP vol. 2, §3.4.2), in FORTRAN 77. Ten verses drawn by lot from the King James Bible in a single pass: each chosen verse may at any moment be struck from the reservoir by a later one, and the stream is read once and never again.
```
gfortran -std=legacy -o reservoir reservoir.f
./reservoir < king_james_bible.txt
```

---
[Drunkard's Walk](https://en.wikipedia.org/wiki/Random_walk): a one-dimensional random walk in line-numbered BASIC, in the manner of [101 BASIC Computer Games](https://archive.org/details/bitsavers_decBooks10Mar75_26006648) (DEC, 1973). The tavern at 20, home at 40, the canal at 0. The theorem guarantees he arrives somewhere with probability one; the theorem does not say where.
```
bwbasic drunkard.bas
```

---
[Dining Philosophers](https://en.wikipedia.org/wiki/Dining_philosophers_problem): Dijkstra's problem (EWD310, 1971) in [occam 2](https://en.wikipedia.org/wiki/Occam_(programming_language)), the language INMOS built for the Transputer, where parallelism is not a library but the grammar. Five philosophers, five forks, and Peter Welch's butler who never seats more than four — which is all it takes for deadlock never to come. Requires KRoC, or a Transputer, whichever you can exhume in better condition; best enjoyed the way most occam now is: read, at a wake.
```
# kroc philosophers.occ  (bring your own archaeology)
```

---
[Malbolge](https://esolangs.org/wiki/Malbolge): Ben Olmstead, 1998 — the language named for the eighth circle of Hell, designed so that programming in it be practically impossible. It worked: no human wrote the first Malbolge program. `hello.mb` was *found*, two years later, by Andrew Cooke's beam search over the space of programs, and prints — for reasons no one chose — `HEllO WORld`. The interpreter is a faithful reimplementation of Olmstead's reference (his permutation tables verbatim); the program corrodes itself as it runs.
```
cc -o malbolge malbolge.c
./malbolge hello.mb
```
---
