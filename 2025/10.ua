Data ← ⊜(□ ⊜□⊸≠@ ) ⊸≠@\n &fras "10.txt"

# Part 1. Just dijkstra each problem.
# Most of the code here just transforms the input into arrays for Uiua's pathfinding.
# The actual logic is in line 8.
$PartOne /+≡◇(
  ˜↯0⊸⧻=@# ⊃(↘₁↘₋₁°□⊢|⍚(⊜⋕⊸≠@, ↘₁↘₋₁) ↘₁) ↘¯1
  -1⧻⊢path(≡(⍜⊏¬ °□:) ¤⊙◌|≍)
) Data

# Part 2. Very similarly, just Dijkstra, but with different parameters.
# Same thing, the actual logic is in line 15.
# Part 2 couldn't be implemented in Uiua because Scipy's optimization.
# $PartTwo /+wait≡pool◇(
#  ˜↯0⊸⧻ ⊃(⊜⋕⊸≠@, ↘₁↘₋₁°□⊣|⍚(⊜⋕⊸≠@, ↘₁↘₋₁) ↘₋₁) ↘1
#  -1⧻⊢path(▽⤚≡(/↧≥) ⊙¤ ≡(⍜⊏+₁°□:) ¤⊙:|≍|/↥⌵-)
# ) Data
