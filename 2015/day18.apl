⍝ Convert the input to a matrix of 1s and 0s.
data ← '#'=↑⊃⎕NGET'day18.txt'1

⍝ Part 1.
⍝ Function to animate, n is the number of lit neighbors.
⍝ If it's on, then return n==2 or n==3, otherwise return n==3 over a region of 3x3.
animate ← {n←+/(4∘↑,¯4∘↑),⍵ ⋄ 2 2⌷⍵:(n=2)∨(n=3) ⋄ n=3}⌺3 3
+/,animate⍣100⊢data ⍝ Just do it 100 times, ravel and sum.

⍝ Part 2.
⍝ Lit up the four corners function.
lit ← {a←⍵ ⋄ l←≢⍵ ⋄ a⊣a[1 l;1 l]←1}
+/,(lit∘animate)⍣100⊢lit data ⍝ Lit up the corners, each time, animate-then-lit 100 times, ravel and sum.
