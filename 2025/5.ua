⊓(≡◇(⊜⋕⊸≠@-)|≡◇⋕) ∩◇(⊜□⊸≠@\n) °⊟ °/$"_\n\n_" &fras "5.txt"
Ranges      ←
Ingredients ←

# Part 1. The ranges signify all fresh IDs. How many ingredients are inside the ranges?
$PartOne /+≡/↥ ⊞(≍⊸⍆ ⍜↻₁˜⊂:) Ingredients Ranges

# Given ranges of numbers, check if any two are overlapping.
# This is done by checking starts and ends for each combination.
# Overlaps ? AllRanges
GetOverlaps ← ▽⊸≡(>0 ⨬(0◌◌|+1-) ◡≥ ⊓↥↧ ⊃∩⊢∩⊣ °⊟) ⧅<2

# Merge two ranges. Returns one single merged range.
# Merged ? RangeA RangeB
Merge ← ⊟⊓↧↥ ⊃∩⊢∩⊣

# Given the row IDs to remove, remove them out of the second array.
# Removed ? Indices Array
RemoveRows ← ▽¬˜(♭⬚0↯⊂1) ⊙⊸⧻ °⊚

# Part 2. How many fresh IDs are there total?
# First, we merge all ranges, then we count.
$PartTwo /+≡(+1-°⊟) ⍢(◴⊂⊙RemoveRows ⊃(◴≡(Merge°⊟)|◴⊸˜⨂♭₂) ⊸GetOverlaps|>0⧻GetOverlaps) Ranges
