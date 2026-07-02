#!/bin/bash
# "Genius sorting algorithm: Sleep sort"
# posted by Anonymous to 4chan's /prog/ board, 2011-01-20, 12:22
# ( dis.4chan.org/read/prog/1295544154 -- board long dead, thread archived )
#
#   1 Name: Anonymous : 2011-01-20 12:22
#     Man, am I a genius. Check out this sorting algorithm I just invented.
#
#   2 Name: Anonymous : 2011-01-20 12:27
#     Oh god, it works.
#
# Each number sleeps for its own value, then announces itself.
# Time is the comparator. The array sorts itself in the fourth dimension.

function f() {
    sleep "$1"
    echo "$1"
}
while [ -n "$1" ]
do
    f "$1" &
    shift
done
wait

# example usage:
# ./sleepsort.sh 5 3 6 3 6 3 1 4 7
