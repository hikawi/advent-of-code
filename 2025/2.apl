⍝ Make it precise enough (32 digits of precision)
⎕PP ← 32

data ← ↑⍎¨ ',' (≠⊆⊢) ('-' ⎕R ' ') ⊃⊃⎕NGET'2.txt'1

⍝ Part 1
+/ {(a b)←⍵ ⋄ n ← 1-⍨a+⍳1+b-a ⋄ +/n/⍨{0<≢'^(\d+)\1$'⎕s'&'⍕⍵}¨n}¨ data

⍝ Part 2
+/ {(a b)←⍵ ⋄ n ← 1-⍨a+⍳1+b-a ⋄ +/n/⍨{0<≢'^(\d+)\1+$'⎕s'&'⍕⍵}¨n}¨ data

