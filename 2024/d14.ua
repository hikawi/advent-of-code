Data ← ∵⋕⍜⍉↘₁ regex "p=(-?\\d+),(-?\\d+) v=(-?\\d+),(-?\\d+)" &fras "d14.txt"

# The dimension of the room the robots moves in.
Space ← 101_103

# Given a coord, retrieve the quadrant it is in (0 top left, 1 top right, 2 bottom right, 3 bottom left).
# Quadrant ? Coord
Quadrant ← ⊗:[¯1_¯1 ¯1_1 1_1 1_¯1] ±-⌊÷2Space

# Part 1. Simulate the robots moving 100 steps in 103x101 grid. Divide into 4 quadrants.
# Count how many robots in each quadrant, then product all of them.
/×⊕⧻ ∩▽,⤙≤3 ⊸≡Quadrant ≡(◿Space+⊙(×100) ⊃↙↘2) Data

# Part 2. At some point, the robots display a christmas tree. When is it?
# I actually don't know how to detect this, we don't know when the tree is there.
# My check is that, when the robots are not on top of each other (hence deduped length = original length check).
⍜⍉↙₂ ⍢(⊙(+1) ≡(⊂◿Space⊸+ °⊟↯2_2)|≠∩⧻⊸◴ ⍜⍉↙₂) Data 0
≡&p ◌⍢(⊙(⍜⊡(@#◌)⇌) ⊃↘₁⊢|>0⧻) :⬚@.↯Space"" # Show the tree.
