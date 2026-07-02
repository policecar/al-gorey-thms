/*
  Duff's Device -- Tom Duff, Lucasfilm Ltd., November 1983.

  The artifact here is not so much the code as the message. Duff mailed
  it to Dennis Ritchie and R. Gomes in November 1983, and re-posted it to
  comp.lang.c in August 1988 when the device resurfaced. The circulated
  text (s. doc.cat-v.org/bell_labs/duffs_device), from memory of many
  reproductions:

    Consider the following routine, abstracted from code which copies an
    array of shorts into the Programmed IO data register of an Evans &
    Sutherland Picture System II:
    [ the routine below ]
    (Beware of typos, I'm typing this from memory.)

    Disgusting, no? But it compiles and runs just fine. I feel a
    combination of pride and revulsion at this discovery. If no one's
    thought of it before, I think I'll name it after myself.

    It amazes me that after 10 years of writing C there are still little
    corners that I haven't explored fully. (Actually, I have another
    revolting way to use switches to implement interrupt driven state
    machines but it's too horrid to go into.)

    Many people (even bwk?) have said that the worst feature of C is that
    switches don't break automatically before each case label. This code
    forms some sort of argument in that debate, but I'm not sure whether
    it's for or against.

        yrs, Tom
*/

/* the device, verbatim -- the loop and the switch interlaced,
   their limbs protruding through one another */
send(to, from, count)
register short *to, *from;
register count;
{
	register n = (count + 7) / 8;
	switch (count % 8) {
	case 0:	do {	*to = *from++;
	case 7:		*to = *from++;
	case 6:		*to = *from++;
	case 5:		*to = *from++;
	case 4:		*to = *from++;
	case 3:		*to = *from++;
	case 2:		*to = *from++;
	case 1:		*to = *from++;
		} while (--n > 0);
	}
}

/* the folkloric memory-to-memory adaptation (to++ instead of to),
   so that the harness below can prove the device copies faithfully */
copy(to, from, count)
register short *to, *from;
register count;
{
	register n = (count + 7) / 8;
	switch (count % 8) {
	case 0:	do {	*to++ = *from++;
	case 7:		*to++ = *from++;
	case 6:		*to++ = *from++;
	case 5:		*to++ = *from++;
	case 4:		*to++ = *from++;
	case 3:		*to++ = *from++;
	case 2:		*to++ = *from++;
	case 1:		*to++ = *from++;
		} while (--n > 0);
	}
}

#include <stdio.h>
#include <string.h>

short reg;                       /* a stand-in for the PIO data register */

int main()
{
	short from[64], to[64];
	int count, i, ok = 1;

	for (i = 0; i < 64; i++) from[i] = i * i - 13;

	for (count = 1; count <= 64; count++) {
		memset(to, 0xAA, sizeof to);
		copy(to, from, count);
		if (memcmp(to, from, count * sizeof(short))) ok = 0;
		send(&reg, from, count);
		if (reg != from[count - 1]) ok = 0;
	}
	puts(ok ? "Disgusting, no? But it compiles and runs just fine."
	        : "the device has failed us");
	return !ok;
}
