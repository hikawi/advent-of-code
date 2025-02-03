Data ← ⊜∘⊸≠@\n &fras "d4.txt"

# Part 1. Find the word "XMAS" in a word-search puzzle in any direction, orientation.
# We look for horizontals and verticals first.
# Then look for diagonals from having a sliding window (stencil).
:/+≡(≍"XMAS") ⊂⊸≡⇌ ⊂∩/⊂ ⊸⊃(⧈♭1_4|⧈♭4_1) Data
+/+♭⧈(♭≡(≍"XMAS") ⊂⊸≡⇌⊟ ∩(⌝⤸0_0) ⊸≡⇌) 4_4

# Part 2. Find the pattern "MAS" in an X, in any orientation.
# We just look from a 3x3 sliding window.
/+♭⧈(↧∩(↥⊃(≍"SAM"|≍"MAS") ⌝⤸0_0) ⟜≡⇌) 3_3 Data
