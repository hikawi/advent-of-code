data ← ⊃⎕NGET'./day2.txt'1 ⍝ Read data from file

⍝ Part 1: Takes 3 integers, a b c. Returns 2ab + 2bc + 2ac + min(ab, bc, ac)
⍝ For each line, reformat it into an array of 3 integers using Thorn.
⍝ Catenate the first value, then do a 2-wide multiply gives the area of each side.
⍝ Total the area by doubling, then adding the area of the smallest side. Sum reduce all.
+/+/∘((2×+/),⌊/)¨{2×/(⊢,⊃)⍵}¨{⍎¨'x'(≠⊆⊢)⍵}¨data 

⍝ Part 2
⍝ For each line, reformat it into an array of 3 integers using Thorn.
⍝ Do a product reduce, gives the area.
+/{(⌊/2×2+/(⊢,⊃)⍵)+(×/⍵)}¨{⍎¨'x'(≠⊆⊢)⍵}¨data
