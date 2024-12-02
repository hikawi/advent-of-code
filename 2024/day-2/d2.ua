Data ← ⊜□ ⊸≠@\n &fras "input.txt"

# Part 1
Diff   ← /-⍉◫2
IsSafe ← ↧⊃(↥⊃(<0/↥|>0/↧)|=0⧻⊚=0↧⊃(≤3|≥1)⌵)
/+≡(IsSafe Diff ⊜⋕ ◇⊸≠@ ) Data

# Part 2. Brute-force method, remove each element and then test against part 1
RemoveOne ← ≡(▽°⊟⍉)⍉ ⊟⊙(↯[.⧻].) ⍜⊡(×0) ⍉⊟.⇡⊸⧻ ↯:1⊸[⊃⧻⧻]
/+≡(/↥≡(IsSafe Diff) ◇RemoveOne ⊜⋕ ◇⊸≠@ ) Data
