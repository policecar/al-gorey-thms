# Conway's Game of Life, again -- the same organism inscribed in BQN,
# Marshall Lochbaum's APL descendant (2020), glyphs younger than the
# reader but already stranger.  This is the canonical form from the
# BQN repository's own REPL examples (mlochbaum/BQN, docs/repl.js).
#
# Needs CBQN: github.com/dzaima/CBQN  ( make && ./BQN life.bqn )

Life ← {∨´1‿𝕩∧3‿4=+˝⥊⌽⟜𝕩¨1-˜↕3‿3}

# the same glider, the same sky, four ticks
r ← 5‿5⥊0‿0‿0‿0‿0‿0‿0‿1‿0‿0‿0‿0‿0‿1‿0‿0‿1‿1‿1‿0‿0‿0‿0‿0‿0
•Show¨ Life⍟(↕4) r
