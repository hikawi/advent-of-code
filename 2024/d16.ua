# Parse the data of course
∩(⊢⊚) ⊸⊃(=@S|=@E) ⊜∘⊸≠@\n &fras "d16.txt"
Start ←
End   ←
Map   ←

# Returns the neighbors and costs: for stepping and turning counter or clockwise.
# costs neighbors ? current map
NeighborsCosts ← (
  1_1000_1000 ⊂⊟ ⊓(⍜°⊟⊸+|⍜⊣⇌|⍜⊣(¯⇌))..
  ∩▽⊸: ⊙(:⊙(≠@#⊡) ⟜≡⊢)
)

# Part 1. Shortest path cost.
# Part 2. Now we care about all paths. Count how many unique tiles in
# all of the paths returned.
⧻◴/◇⊂ ≡⍜°□≡⊢ path(NeighborsCosts|≍End⊢) ˜⊟0_1 Start Map
