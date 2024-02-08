⍝ Nothing special today.
data ← ⊃⎕NGET'day7.txt'1

⍝ This tracks windows of left argument length over the right argument. 4 would mean to check for ABBA
⍝ and 3 would mean to check for ABA (by checking if reverse = itself, and check for unique letters count = 2).
⍝ The result is the list of windows that match the criteria.
abba ← {⍺>≢⍵:0 ⋄ l/⍨{(2=≢⊣⌸⍵)∧((⊢≡⌽)⍵)}¨l←⍺,/⍵}

⍝ Separate an IP into two lists, one for outside parts and one for inside parts.
sep ← {a←1 0⍴⍨≢m←(('['∘≠∧(']'∘≠))⊆⊢)⍵ ⋄ (a/m)(m/⍨1-a)}

⍝ Part 1. TLS means there are ABBAs outside and no ABBAs inside.
+/{out in←sep ⍵ ⋄ (0<≢⊃,/4∘abba¨out)∧(0=≢⊃,/4∘abba¨in)}¨data

⍝ Part 2. SSL means there are ABAs outside and corresponding BABs inside.
+/{out in←sep ⍵ ⋄ bab←⊃∘('(\w)(\w)(\w)'⎕s'\2\1\2')¨⊃,/3∘abba¨out ⋄ 0<+/{+/⍵∘{0<+/⍵⍷⍺}¨bab}¨in}¨data
