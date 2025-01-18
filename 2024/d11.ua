Data ← ⊜⋕⊸≠@ ↘¯1 &fras "d11.txt"

# Checks which rule a number should fall into. If it's 0, it's type 0.
# If the length of the number is even, it's type 1. Otherwise, it's type 2.
# Type ? Number
WhichRule ← ⍣⊢2 ⊚[⊃(=0|=0◿2⧻$"_")]

# Total ? Steps Number
Apply ← |2 memo(
  ⨬(⨬(Apply:1-1 ⊙◌
    | +∩Apply ∩: ⊙, °⊟:-1⊙(≡⋕↯2_∞$"_")
    | Apply ⊓(-1|×2024)
    ) :⊙⊸WhichRule
  | 1◌◌
  ) ⊸≤0
)

# Part 1. Count how many elements are there in the array after 25 blinks.
/+≡(Apply 25) Data

# Part 2. Count how many elements are there in the array after 75 blinks.
/+≡(Apply 75) Data
