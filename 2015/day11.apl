⍝ Function to check for any consecutive 3 numbers, like 1 2 3, 4 5 6,...
consecutive ← {1≤+/(1-⍨⍳3)∘≡∘(⊢-⌊/)¨3,/⍵}

⍝ Function to check if there are any numbers that are not allowed like 8, 11, 14
⍝ which is i, l and o.
has ← 0∘<∘(+/∘(8 14 11∘∊))

⍝ Function to check if there are any two pairs of letters like aa, bb, cc, etc.
⍝ Use unique and count how many pairs.
twopairs ← {2≤+/(≢≠(≢∘∪))¨∪2,/⍵}

⍝ Function to convert a string to a number array.
conv ← {97-⍨⎕UCS⍵}

⍝ Function to increment a number array by one in base 26.
inc ← {c←0=+/25≠⍵ ⋄ (26⍴⍨c+≢⍵)⊤1+26⊥⍵}

⍝ Retrieve the "next" password, by incrementing until it fits.
next ← {(twopairs∧consecutive∧(~∘has))⍵:lower[⍵+1] ⋄ ∇inc⍵}

⍝ Part one.
next∘conv⊢input

⍝ Part two, take part one's solution, increment it once, and feed back to next.
next∘inc conv⊢input
