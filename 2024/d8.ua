# Experimental!

Data    ← ⊜∘⊸≠@\n &fras "d8.txt"
Length  ← △Data
Atennas ← ⊕□ ⊛⤚⊡ ⊚⊸≠@. Data

# Checks if the provided coord is in bounds.
# CanPlace ? Coord
InBounds ← /↧⊂⊃(<Length|≥0)

# Returns coords around two coords.
# NewCoord1 NewCoord2 ? Coord1 Coord2
PlaceAround ← ⊓++ ⊃(-|⋅∘|-:|∘)

# Returns a coord list going the leftward direction.
# CoordList ? Coord1 Coord2
PlaceLeft ← ⊙◌ ⍢(⊂:⊙(⊸+) ⟜⊢|InBounds⊢) ¤⟜-

# Returns a coord list going the rightward direction.
# This could probably combine with above, only difference is the backward -.
# I'm too lazy tho.
# CoordList ? Coord1 Coord2
PlaceRight ← ⊙◌ ⍢(⊂:⊙(⊸+) ⟜⊢|InBounds⊢) ¤⟜𝄈-

# Part 1. Count how many antinodes can be placed.
/+≡InBounds ◴/◇⊂ ⍚(⊂≡(PlaceAround°⊟) ⧅<2) Atennas

# Part 2. Each pair of antennas can have many antinodes instead of 2.
/+≡InBounds ◴⍥₂/◇⊂ ⍚(≡(□⊂⊃(PlaceLeft|PlaceRight) °⊟) ⧅<2) Atennas
