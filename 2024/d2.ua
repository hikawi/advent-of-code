Data ← ⊜(□⊜⋕⊸≠@ )⊸≠@\n &fras "d2.txt"

# A report is considered safe if both conditions hold:
# - It is all increasing or all decreasing (checked with sort and sort reverse)
# - Any two adjacent numbers absolute difference is between [1,3]
# Safe ? Report
Safe ← ↧⊃(↥∩≍ ⇌⊸⍆,⊸⍆|↧∩/↧⊃≤₃≥₁ ⌵⧈/- 2)

# Part 1. How many reports are safe?
/◇+⍚Safe Data

# Part 2. We can tolerate one bad number (by removing them). These reports are also safe.
# How many safe now?
°□/+⍚(/↥♭⊞(Safe ⍜↻↘₁) ⇡⧻ ⟜¤) Data
