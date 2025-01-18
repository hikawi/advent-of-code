# Experimental!

Data   ← ⊜≡⍣⋕¯1 ⊸≠@\n &fras "d10.txt"
Shape  ← △Data
Starts ← ⊚=0Data

# Checks if a coord is in-bounds
# InBound ? Coord
InBounds ← /↧⊂⊃(≥0|<Shape)

# Retrieves up, left, down, right of a coord.
# Prunes all coords that are out of bounds.
# Neighbors ? Coord
Neighbors ← ▽⊸≡InBounds ⊂⊂⊟⊃(+¯1_0|+1_0|+0_¯1|+0_1)

# Retrieves neighbors that are exactly one step up
# from the current coord.
# StepUps ? Coord
StepUps ← ▽=⊃(+1⊡:Data|⤚⊡:Data Neighbors)

# Count how many hiking trails starting from the current position in the data set.
# Count ? Coord
CountTrails ← |1 ⨬(/+♭≡CountTrails StepUps|1◌) =9 ⊸(⊡:Data)

# Run a recursive trace to see how many summits from the current can reach.
# Summits ? Point
Trace ← |1 ↯∞_2 ⨬(/◇⊂ ≡(□Trace) StepUps|∘) =9⊸(⊡:Data)

# Part 1. Sum of how many summits each start can reach.
/+≡(⧻◴Trace) Starts

# Part 2. Count how many paths each start can reach any summit.
/+≡CountTrails Starts
