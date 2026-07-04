/*
  Quantum bogosort -- folklore, provenance unknown; first written down
  in the mid-2000s on programming boards and never improved upon.

  The algorithm:
    1. Shuffle the list.
    2. If the list is not sorted, destroy the universe.
    3. All surviving universes contain a sorted list, in O(n).

  This implementation takes many-worlds seriously: each fork() branches
  the multiverse. Child universes in which the shuffle came out unsorted
  are annihilated (SIGABRT -- do not mourn them, they never observed
  anything). You, the reader, necessarily live in the branch where the
  list came out sorted on the first try. It always does. Ask around:
  nobody you can reach has ever seen it fail.

  cc -o quantum_bogosort quantum_bogosort.c
  ./quantum_bogosort 9 1 8 6 6 2 0 4
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <time.h>

static void shuffle(int *a, int n)
{
	int i, j, t;
	for (i = n - 1; i > 0; i--) {
		j = rand() % (i + 1);
		t = a[i]; a[i] = a[j]; a[j] = t;
	}
}

static int sorted(int *a, int n)
{
	int i;
	for (i = 1; i < n; i++)
		if (a[i - 1] > a[i]) return 0;
	return 1;
}

int main(int argc, char **argv)
{
	int n = argc - 1, i;
	int *a = malloc(n * sizeof *a);
	unsigned long universes = 0;

	if (n < 1) { fprintf(stderr, "usage: %s number...\n", argv[0]); return 2; }
	for (i = 0; i < n; i++) a[i] = atoi(argv[i + 1]);

	for (;;) {
		pid_t child;
		int status;

		universes++;
		child = fork();

		if (child == 0) {              /* a fresh branch of the wavefunction */
			srand(getpid() ^ time(0));
			shuffle(a, n);
			if (!sorted(a, n))
				abort();       /* this universe is no longer needed */
			for (i = 0; i < n; i++)
				printf("%d%c", a[i], i == n - 1 ? '\n' : ' ');
			fflush(stdout);   /* speak before the branch is sealed */
			fprintf(stderr, "sorted in O(n), as observed from every universe that still exists.\n");
			_exit(0);
		}

		waitpid(child, &status, 0);
		if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
			fprintf(stderr, "(%lu universe%s were harmed in the making of this ordering.)\n",
			        universes - 1, universes == 2 ? "" : "s");
			return 0;
		}
		/* WIFSIGNALED: the branch collapsed. we, the unobserved
		   remainder, decohere into the next attempt. */
	}
}
