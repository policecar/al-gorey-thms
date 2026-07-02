# The Josephus problem, in sed. What else is a stream editor for,
# if not striking names from a list?
#
# Josephus ben Matityahu and forty of his men, trapped in the cave at
# Yodfat, 67 AD, resolved on death before capture: standing in a circle,
# every third man to be slain by the man to his left, around and around,
# until none remain. Josephus -- "whether by fortune or by the providence
# of God" -- reckoned swiftly where to stand, and lived to write history.
#
# The circle arrives on stdin, one soul per line. Every third one falls.
#
#   seq 41 | sed -E -f josephus.sed
#
# and the last line names the man who walks out of the cave.

# close the circle: gather all souls onto one line
1h
1!H
$!d
x
s/\n/ /g
s/$/ /
s/^/|/

:count
# one... two... (two souls step past the blade)
s/^([^|]*\|)(\S+) (.*)/\1\3\2 /
s/^([^|]*\|)(\S+) (.*)/\1\3\2 /
# ...three. (struck from the circle, entered in the ledger)
s/^([^|]*)\|(\S+) (.*)/\1\2,|\3/
# while two or more still stand, the count resumes
/\|(\S+ ){2,}/b count

# typeset the ledger of the dead, and the survivor
s/\|(\S+) $/@\1/
s/([^,]*),/falls: \1\n/g
s/@(.*)/the count is done.\nalone in the circle stands \1, who surrenders to the Romans./
