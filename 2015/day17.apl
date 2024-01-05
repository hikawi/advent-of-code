⍝ The usual, except that we just convert all to a clean number array.
data ← ⍎¨⊃⎕NGET'day17.txt'1

⍝ Part 1.
⍝ Simple recursive algorithm. If at any time, the "remaining" is <= 0, or "bins left" = 0, then return whether the remaining is 0.
⍝ Otherwise, take out first n bins (so there are no repetitions), and recurse.
⍝ The Idea: Distribute(25,[25 15 10 5 5]) = Distribute(0,[15 10 5 5]) + Distribute(10,[10 5 5]) + Distribute(15,[5 5]) + Distribute(20,[5]) + Distribute(25,[])
distribute ← {(⍺≤0)∨(0=≢⍵):⍺=0 ⋄ bins←⍵ ⋄ +/⍺∘{(⍺-bins[⍵])distribute⊢⍵↓bins}¨⍳≢⍵}

⍝ Bins vector. Similarly to above, now we keep track of which bins we used too. And if we hit =150, we add it to the list of bins.
bins ← ⍬
pour ← {⍺←⍬ ⋄ 150=+/⍺:bins,←⊂⍺ ⋄ 150<+/⍺:⍬ ⋄ left←⍵ ⋄ 0=≢⍵:⍬ ⋄ ⍺∘{(⍺,left[⍵])pour⊢⍵↓left}¨⍳≢⍵}
pour data

⍝ Part 2. Count number of bins used in each combination, take min.
⍝ Then run again and find how many combinations use the min amount.
+/bins{⍵=≢⊃⍺}⍤0 0⊢max←⌊/≢¨bins
