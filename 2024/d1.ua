Data ← ⍉⊜(⊜⋕⊸≠@ ) ⊸≠@\n &fras "d1.txt"

# Part 1. It tells us to sort each column (here used rows because we already transposed.)
# Then find the sum of all absolute differences.
/+⌵/-≡⍆ Data

# Part 2. We find how many occurrences of a number on the first row compared to second row.
# Then find the sum of occurrences * number.
/+×⊙♭⟜⊞(/+⌕) ⊃⊢↘₁ Data
