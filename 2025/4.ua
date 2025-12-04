Data ← ⊜∘⊸≠@\n &fras "4.txt"

# Given a matrix of papers and empty space, mask out spots that can be accessed
# by the forklift, where each roll (@) has only a maximum of 3 adjacent rolls.
# BoolMatrix ? Matrix
CanBeAccessed ← (
  ⍜⍉(↘₁↘₋₁) ↘₁↘₋₁ ≡₂(↧⊃(=@@⊡1_1|<4/+=@@⍜↻₄↘₁♭)) ⬚@.⧈(∘) 3_3
)

# Part 1. A forklift can access a roll (@) if it's only adject to < 4 rolls.
$PartOne /+♭ CanBeAccessed Data

# Part 2. Keep removing until the matrix can no longer be removed.
# How many rolls total that can be removed.
$PartTwo ⊙⋅◌ ⍢(+⊙(⊙(⊸CanBeAccessed ⍜⊡(˜↯@.⧻)) ⊸⧻⊚)|>0⧻⊚◌) 0 ⊸CanBeAccessed Data
