Data ← ⬚@ ⊜∘⊸≠@\n &fras "input.txt"

# Helper functions
Parse  ← ⊜⋕⊸≠@ 
Diff   ← ≡/-◫2
IsSafe ← ×⊃(/××⊃(≤3|≥1)⌵|↥∩/×⊃<>0)

# Part 1
/+≡(IsSafe Diff Parse) Data

# Part 2
/+♭≡(/↥⊞(IsSafe Diff ⍜↻(↘1)) ⇡⊃⧻¤ Parse) Data
