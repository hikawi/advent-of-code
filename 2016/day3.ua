Data ← ↯⊂:3÷3⧻. ≡(⋕⊢) regex "(\\d+)" &fras "day3.txt" # Extract data into a big array, reshape into 3-col matrix.

/+ ≡(⍥↧2⊃(<+|>⊙+|>⊙+:) °[⊙⊙∘]) Data                # Part one, for each row, do the triangle inequality thing. Sum all.
/+ ≡(⍥↧2⊃(<+|>⊙+|>⊙+:) °[⊙⊙∘]) ☇1≡⍉↯⊂:3_3÷3⧻. Data # Part two, split big matrix into small matrices of 3 rows, transpose each. Then same thing.
