/*
  Malbolge -- Ben Olmstead, 1998.  Named for the eighth circle of
  Dante's Hell, and designed with one requirement: that programming
  in it be practically impossible.  Every instruction is decoded
  through a substitution keyed to its own address; after executing,
  each instruction is encrypted in place, so the program corrodes as
  it runs; arithmetic is base-3 via an operation ("crazy") chosen for
  having no useful algebraic properties.

  The design succeeded.  No human wrote the first Malbolge program:
  it was FOUND, two years later, by Andrew Cooke's beam search over
  the space of possible programs (see hello.mb, which prints, for
  reasons no one chose, "HEllO WORld").

  This is a faithful reimplementation of Olmstead's reference
  interpreter (malbolge.c, 1998; s. lscheffer.com/malbolge_interp.html
  and esolangs.org/wiki/Malbolge).  The two permutation tables and the
  crazy-operation table are his, verbatim.

    cc -o malbolge malbolge.c
    ./malbolge hello.mb
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define WORDS 59049                              /* 3^10 cells of Hell */

static unsigned mem[WORDS];

static const char xlat1[] =                      /* instruction decode */
  "+b(29e*j1VMEKLyC})8&m#~W>qxdRp0wkrUo[D7,XTcA\"lI"
  ".v%{gJh4G\\-=O@5`_3i<?Z';FNQuY]szf$!BS/|t:Pn6^Ha";

static const char xlat2[] =                      /* in-place corrosion */
  "5z]&gqtyfr$(we4{WP)H-Zn,[%\\3dL+Q;>U!pJS72FhOA1C"
  "B6v^=I_0/8|jsb9m<.TVac`uY*MK'X~xDl}REokN:#?G\"i@";

static unsigned crazy(unsigned a, unsigned d)    /* tritwise, useless by design */
{
	static const int t[3][3] = { {1,0,0}, {1,0,2}, {2,2,1} };
	unsigned r = 0, p = 1;
	int i;
	for (i = 0; i < 10; i++) {
		r += t[d % 3][a % 3] * p;
		a /= 3; d /= 3; p *= 3;
	}
	return r;
}

int main(int argc, char **argv)
{
	FILE *f;
	int x;
	unsigned a = 0, c = 0, d = 0, i = 0;

	if (argc != 2 || !(f = fopen(argv[1], "rb"))) {
		fprintf(stderr, "usage: malbolge <program>\n");
		return 2;
	}
	while ((x = getc(f)) != EOF) {
		if (isspace(x)) continue;
		if (i == WORDS) { fprintf(stderr, "input file too long\n"); return 2; }
		if (x >= 33 && x <= 126 &&
		    !strchr("ji*p</vo", xlat1[(x - 33 + i) % 94])) {
			fprintf(stderr, "invalid character in source file\n");
			return 2;
		}
		mem[i++] = x;
	}
	fclose(f);
	for (; i < WORDS; i++)                   /* the rest of memory is */
		mem[i] = crazy(mem[i - 1], mem[i - 2]);  /* born already mad */

	for (;;) {
		if (mem[c] < 33 || mem[c] > 126) break;
		switch (xlat1[(mem[c] - 33 + c) % 94]) {
		case 'j': d = mem[d];                              break;
		case 'i': c = mem[d];                              break;
		case '*': a = mem[d] = mem[d] / 3 + mem[d] % 3 * 19683; break;
		case 'p': a = mem[d] = crazy(a, mem[d]);           break;
		case '<': putchar((int)(a % 256)); fflush(stdout); break;
		case '/': x = getchar(); a = (x == EOF) ? 59048 : (unsigned)x; break;
		case 'v': return 0;
		default:                                           break;
		}
		mem[c] = xlat2[mem[c] - 33];     /* the instruction, having  */
		c = (c + 1) % WORDS;             /* acted, is disfigured     */
		d = (d + 1) % WORDS;
	}
	return 0;
}
