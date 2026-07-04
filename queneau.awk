# Cent mille milliards de poèmes -- Raymond Queneau, Gallimard, 1961:
# ten sonnets printed on pages sliced into fourteen strips, so that any
# line may lie over any other.  10^14 sonnets; reading one per minute,
# day and night, takes about 190 million years.  Queneau's own ten are
# in copyright until the 2040s, so this machine is fitted instead with
# the ten darkest sonnets of Shakespeare (60, 64, 65, 66, 71, 73, 74,
# 90, 129, 146) -- an Oulipian substitution the author of "La Littérature
# potentielle" would have to permit on principle.
#
#   awk -f queneau.awk sonnets_dark.txt
#
# Each reading is one sonnet of the hundred thousand billion.  It has
# always existed; you are merely the first to be present at it.

BEGIN { srand() }

/^SONNET/ { s++; l = 0; next }
/^$/      { next }
          { line[s, ++l] = $0 }

END {
    serial = 0
    for (l = 14; l >= 1; l--) {
        c = int(rand() * s)
        serial = serial * 10 + c
        strip[l] = line[c + 1, l]
    }
    printf("sonnet %.0f of the 100,000,000,000,000:\n\n", serial + 1)
    for (l = 1; l <= 14; l++)
        print strip[l]
}
