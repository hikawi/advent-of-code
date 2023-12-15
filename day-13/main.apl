data ← ⊃⎕NGET'./input.txt'1        ⍝ Read input and save into "data".
data ← ↑¨data⊆⍨≢¨data              ⍝ Split data into an array of matrices.

⍝ Function to check if the provided line is a horizontal mirror line.
⍝ Left argument is the matrix, right argument is the line's index vector.
⍝ The name stands for "is horizontal mirror".
ishm ← {
    f←⊃⍵ ⋄ l←1⊃⍵
    f<0:1                          ⍝ If first index < 0, done.
    l≥≢⍺:1                         ⍝ If last index > length, done.
    0≠+/⍺[f;]≠⍺[l;]:0              ⍝ If first and last rows are not equal, done.
    ⍺∇¯1 1+f l                     ⍝ Recurse with first and last indices add 1/sub 1.
}

⍝ A version of ishml that also checks for smudges.
⍝ The name stands for "is horizontal mirror lenient".
ishml ← {
    f←⊃⍵ ⋄ l←1⊃⍵ ⋄ cd←2⊃⍵
    f<0:cd=0                       ⍝ If first index < 0, done.
    l≥≢⍺:cd=0                      ⍝ If last index > length, done.
    d←+/⍺[f;]≠⍺[l;]                ⍝ The difference between two lines.
    d>cd:0                         ⍝ Stop if there are more differences than expected.
    ⍺∇¯1 1 0+f,l,cd-d              ⍝ Recursion!
}

⍝ Solve part one.
sp1 ← {
    ⍺←0                                       ⍝ Default arg for ⍺
    ⍺≥≢data:+/⍵                               ⍝ If index > all maps, return.
    s←⍺⊃data                                  ⍝ Pick the map we want.
    ts←⍉s                                     ⍝ Transpose the map.

    phm←⍸0=+/2≠⌿s                             ⍝ List of "possible" horizontal mirrors.
    hv←+/{100×1+⍵}¨phm/⍨{s ishm ⍵}¨{⍵+⍳2}¨phm ⍝ Check if those are mirrors.

    pvm←⍸0=+⌿2≠/s                             ⍝ List of "possible" vertical mirrors. (scan different ways)
    vv←+/1+¨pvm/⍨{ts ishm ⍵}¨{⍵+⍳2}¨pvm       ⍝ Check if those are mirrors (with transposed data).

    (⍺+1)∇∊⍵(hv+vv)                           ⍝ Recurse with the concatenation of two lists.
}

⍝ Stands for "generate value"
⍝ Left argument is the matrix, right argument is a vector of [possible mirror lines, possible mirror lines with smudges, multiplier]
gv ← {
    pm ← ⊃⍵ ⋄ pml ← 1⊃⍵ ⋄ mul ← 2⊃⍵ ⋄ s ← ⍺
    svl ← {+/{mul×1+⍵}¨⍵/⍨{s ishml 1,⍨⍵+⍳2}¨⍵}
    lv ← svl pml ⋄ v ← svl pm
    lv≠0: lv
    v
}

⍝ Solve part two.
sp2 ← {
    ⍺←0                           ⍝ Default arg for ⍺
    ⍺≥≢data:+/⍵                   ⍝ If index > all maps, return.
    s←⍺⊃data                      ⍝ Pick the map we want.
    ts←⍉s                         ⍝ Transpose the map, and save.

    phm←⍸0=+/2≠⌿s                 ⍝ List of "possible" horizontal mirrors.
    phml←⍸1=+/2≠⌿s                ⍝ List of possible horizontals with 1 error. "l" stands for lenient.
    hv←s gv (phm)(phml)(100)      ⍝ Generate values for horizontals.

    pvm←⍸0=+/2≠⌿ts                ⍝ List of "possible" vertical mirrors.
    pvml←⍸1=+/2≠⌿ts               ⍝ List of possible verticals with 1 error.
    vv←ts gv (pvm)(pvml)(1)       ⍝ Generate values for verticals. 

    0=vv+hv: (s)(ts)(phm)(phml)(hv)(pvm)(pvml)(vv) ⍝ If both are 0, return the data, panic! Something is wrong.
    hv≠0: (⍺+1)∇∊⍵hv              ⍝ If horizontal is not 0, recurse with that value instead.
    (⍺+1)∇∊⍵vv                    ⍝ Otherwise, recurse with vertical.
}

sp1 0
sp2 0
