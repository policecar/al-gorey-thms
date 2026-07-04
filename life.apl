⍝ Conway's Game of Life -- John Scholes, Dyalog Ltd., 2009.
⍝ One line. The neighbourhood is gathered by rotating the world
⍝ nine ways and summing the worlds. s. aplwiki.com/wiki/John_Scholes%27_Conway%27s_Game_of_Life
⍝
⍝ Runs on Dyalog APL, or on the long-abandoned npm package "apl"
⍝ (ngn/apl, an APL written in JavaScript, last touched 2016):
⍝
⍝   npm install apl
⍝   node -e 'console.log(String(require("apl")(require("fs").readFileSync("life.apl","utf8"))))'

life←{↑1 ⍵∨.∧3 4=+/,¯1 0 1∘.⊖¯1 0 1∘.⌽⊂⍵}

⍝ a glider, aloft in a 5×5 sky; three ticks of the clock
r←5 5⍴0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 1 1 1 0 0 0 0 0 0
life life life r
