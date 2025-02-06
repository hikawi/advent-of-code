# Experimental!

Data ← ⍜♭⊛ ⊜∘ ⊸≠@\n &fras "d12.txt"

# Check if given coords are in bounds.
# InBounds ? Coord
InBounds ← /↧⊂⊃(≥0|<△Data)

# Retrieves a list of valid and same neighbors to the current coord.
# Neighbors ? Coord
SameNeighbors ← ▽:⊙= ⟜≡(𝄈⊡Data) ▽⊸≡InBounds ⊃(♭₂⊞+ [1_0 ¯1_0 0_¯1 0_1]¤|𝄈⊡Data)

# Simple reshaped infx2 matrix.
EmptyCoordsMap ← ↯∞_2[]

# Do a simple flood-fill to get the entire region, starting from the coord.
# Region ? Coord
Flood ← ⍆◴◌◌ ⍢(⊂⊙(⨬(SameNeighbors ⊙∩⊂.⟜:|EmptyCoordsMap◌) ◡𝄈∊) ⊃↘₁⊢)(>0⧻) ⤚:EmptyCoordsMap¤

# Regions found on the map.
Regions ← ◴wait≡pool(□Flood) ♭₂⇡△Data

# Calculate the perimeter of the region by appending nodes, and checking neighbors count.
# Perimeter ? Region
Perimeter ← ◌◌⍢(⊙(⊙+: ×2¯-2 /+⊸𝄈∊ SameNeighbors⟜⊂) ⊃↘₁⊢|>0⧻) :⊙: EmptyCoordsMap 0

# Part 1. Calculate the perimeter and surface area, then multiply them together.
# The result is the sum of these products.
/+×≡◇⊃(Perimeter|⧻) Regions

# Checks if a given coord, and the corner direction is a valid corner. Let's say we check top right corner.
# Case 1: A valid corner has 0 neighbors in that direction, meaning no right or top neighbors.
# Case 2: It must have BOTH neighbors, but the diagonal neighbor is NOT present (no top right neighbor).
# IsCorner ? Coord Direction Region
IsCorner ← (
  ⊓(+|+|+) ⊙⊙⟜: ⟜: ⊙⊃(𝄈⊟0 ⊢|⊟0 ⊣|∘)
  ↥⊃(=0/↥↙2|≍1_1_0) 𝄈∊ ⊂⊟
)

# Count the number of corners this node has.
# CornerCount ? Coord Region
CountCorners ← +++ ⊃(IsCorner:1_1|IsCorner:¯1_1|IsCorner:1_¯1|IsCorner:¯1_¯1)

# Part 2. Instead of the perimeter, we count how many sides of the region instead. We count corners in each node.
# Each corner contributes 2 sides.
/+× ≡◇⊃(/+≡CountCorners: ⊸↯⊸⧻)⧻ Regions
