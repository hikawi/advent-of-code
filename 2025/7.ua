Data ← ⊜∘⊸≠@\n &fras "7.txt"

# Check if a coord is in bounds.
# IsInBounds ? Coord
InBounds ← /↧↧⊃(≥0|<⧻Data)

# Advance all beams downwards.
# SplitCount NewBeams ? Beams Grid
Advance ← (
  # Do the advancing downwards after clearing out-of-bounds nodes.
  =@^⤚⊡ ▽⊸≡InBounds ≡(+1_0)
  ⊃(/+|◴⊂⊃(/◇⊂≡(□⊟⊃(+0_1|+0_¯1)) ▽|▽¬))
)

# Part 1. Advance and count how many splits happened.
$PartOne ⊙⋅◌ ⍢(+⊙⊸Advance|>0⧻◌) 0 ⊚⊸=@S Data

# Split a beam, return the appropriate value to do recursion with.
Split ← |1 memo(
  # First we categorize the node: 0 - out of bounds, 1 - base case, 2 - split case, 3 - recurse case.
  ⊸(⊢⊚˜⊂1 [⊃(↥⊃(<0|≥⧻Data)⊣|≥⧻Data⊢|⍣(=@^˜⊡Data)0)])
  # Then just case-by-case.
  ⨬(0◌|1◌|+∩Split ⊃(+0_1|+0_¯1)|Split +1_0)
)

# Part 2. Count how many timelines it created.
$PartTwo Split ⊢⊚=@S Data
