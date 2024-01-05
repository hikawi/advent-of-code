⍝ The data, the usual.
mfcsam ← 3 7 2 3 0 0 5 3 2 1
exprs ← ,∘': (\d+)'¨'children' 'cats' 'samoyeds' 'pomeranians' 'akitas' 'vizslas' 'goldfish' 'trees' 'cars' 'perfumes'

⍝ Part 1.
⍝ Put -1 at places where the data is missing, calculate how many matches against mfcsam. Find max matches.
⍝ Do another run, to find which lines match the max matches count. Do a where to get indices.
⍸mat{⍵=+/mfcsam=⍺}⍤1 0⊢max←⌈/{+/mfcsam=⍵}⍤1⊢mat←⍎¨(⊂'¯1')@{0=≢¨⍵}exprs{,⍉⍺{(⊃⍺)⎕s'\1'⊢(⊃⍵)}⍤0 0⊢⍵}⍤1 0⊢data

⍝ Part 2.
⍝ Second part's matching is not simple, so I just made this function.
⍝ Otherwise, same thing.
match ← {
    e1 e2 e3 e4 e5 e6 e7 e8 e9 e10←⍵
    x1 x2 x3 x4 x5 x6 x7 x8 x9 x10←mfcsam
    ∊(e1=x1)(e2>x2)(e3=x3)((e4≥0)∧(e4<x4))(e5=x5)(e6=x6)((e7≥0)∧(e7<x7))(e8>x8)(e9=x9)(e10=x10)
}
⍸mat{⍵=+/match⍺}⍤1 0⊢max←⌈/+/∘match⍤1⊢mat←⍎¨(⊂'¯1')@{0=≢¨⍵}exprs{,⍉⍺{(⊃⍺)⎕s'\1'⊢(⊃⍵)}⍤0 0⊢⍵}⍤1 0⊢data
