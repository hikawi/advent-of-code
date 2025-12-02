Data ← ⊜(⊜⋕ ⊸≠@-) ⊸≠@, ↘¯1 &fras "2.txt"

# Checks if a number pattern is made of two repeating bricks.
# Such as 111 is made of 3 repeating bricks, not allowed, but 1111 is allowed.
# This just grabs half of the string, duplicates it and checks against the original.
# RepeatingTwice ? Number
IsRepeatingTwice ← ≍♭↯2 ⊸↙ ⌊÷2⊸⧻ °⋕

# Part 1. Sum of all numbers that have a pattern repeated twice.
$PartOne /+≡(/+▽⊸≡IsRepeatingTwice +⇡+1⤚- °⊟) Data

# Checks if a number pattern is repeating.
# Repeating ? Number
IsRepeating ← (
  # Grabs the first half builds of the string representation, for example 38593859 -> [3,38,385,3859]
  ⍉⊟⊙⧻ ≡(□↙) ⊙⊸¤ +1⇡⌈÷2⊸⊸⧻ °⋕
  # For each row (subsection,fulllength) we want to expand copies as many times as possible
  ≡(□♭↯ ⌊÷⊙:⊸⧻ ∩°□ °⊟)
  # Then, for each combination, check against the original. If any matches, it is a repeating pattern.
  /↥≡(◇≍) ⊙¤
)

# Part 2. Sum of all repeating numbers.
$PartTwo /+wait≡spawn(/+▽⊸≡IsRepeating +⇡+1⤚- °⊟) Data
