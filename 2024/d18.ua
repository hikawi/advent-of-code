≡⇌ ≡₀⋕ ⍜⍉↘₁ regex "(\\d+),(\\d+)" &fras "d18.txt"
Bytes ←
Exit  ← 70_70

# Checks if a coord is in bounds.
# inbounds ? coord
InBounds ← /↧↧⊃(≥0_0|≤Exit)

# Gets a list of neighbors from a coord.
# neighbors ? cur bytes
Neighbors ← ˜▽ ⟜(↧⊃(≡InBounds|¬˜∊)) ≡+A₂¤

# Part 1. Simulate the bytes falling and path it out to the destination.
# Minus 1 to take away the source block
-1⧻⊢path(Neighbors|≍Exit) 0_0 ↙1024 Bytes

# Part 2. When is the time that the byte that falls that an exit is now impossible?
$"_,_" °⊟⇌˜⊡Bytes ⊙◌ ⍢(-1|⍣(0◌ ⊢path(Neighbors|≍Exit) 0_0 ↙)1) ⊸⧻ Bytes
