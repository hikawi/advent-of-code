⍝ Split the data into an array of instructions like ["L3", "R3", "L4",...]
data ← '(L|R)(\d+)'⎕s'&'⊃⊃⎕NGET'day1.txt'1

⍝ Ordinary turning, turning left from (x, y) is (y, -x) and turning right is (-y, x)
turn ← {'L'=⊃⍵:1 ¯1×⌽⍺ ⋄ ¯1 1×⌽⍺}

⍝ Walk the path, starting at (0, 0) and facing (0, -1). Leaving behind a histogram.
⍝ Left argument (alpha): all positions and last row is the current direction.
⍝ Right argument (omega): the remaining instructions.
walk ← {
    ⍺ ← ↑(0 0)(0 ¯1)
    0=≢⍵:¯1↓⍺
    dir ← ⊂(⊃⍵)turn⍨1⌷⊖⍺
    (1↓⍵)∇⍨(⊃dir)⍪⍨(¯1↓⍺)⍪1↓+⍀(2⌷⊖⍺)⍪↑dir/⍨⍎1↓⊃⍵
}

⍝ Part 1. Walk, take the last step. Calculate Manhattan distance by abs and sum.
+/|1⌷⊖walk data

⍝ Part 2. Walk. Take unique mask, flip the bits, and get the first position that isn't unique, calculate manhattan distance.
+/mat⌷⍨⊃⍸1-≠mat←walk data
