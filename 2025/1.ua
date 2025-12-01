Spins ← ⊜(⨬(⋕|¯⋕) =@L ⊃⊢↘₁) ⊸≠@\n &fras "1.txt"

# Part 1. How many times does the dial land on 0?
$PartOne /+=0 ↘1◿100\+⊂50 Spins

# Find the next number in the chain
# NextNum Clicks ? Number Instruction
# Dial ← ⊙+◿100 :↥⊸⊃(≤0|≥100) +⊙(˜-⊙⊸(×100) :⊸(⌊÷100⌵))
Dial ← (
  ⊙(⨬(˜-|˜+) ⊸(<0±) ⊙⊸(×100) :⊸(⌊÷100⌵))
  ◿100 ⊙+ :↧⊙: ⊓(↥⊸⊃(≤0|≥100)|≠0) ⤚+
)

# Part 2. How many times does the dial click at 0?
$PartTwo ⋅⊙◌ ⍢(⊙+ :⊙Dial :⊙⊙⊃⊢↘₁|>0⧻◌◌) 50 0 Spins
