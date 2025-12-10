Nodes       ← ⊜(⊜⋕⊸≠@,) ⊸≠@\n &fras "8.txt"
NodesCount  ← ⧻Nodes
Connections ← ⊏⍏ ⊸≡(/+ⁿ2-°⊟) ⧅<2 Nodes

# Append ← ⍜⊙get⍜⊙°□⊂
# Append ← ⍜⊙get◇(◴⊂) :⟜₂⍜⊙get◇(◴⊂) °⊟
Append ← ⍜⊙get◇(◴⊂) °⊟

# NodeToCheck CurrentNodes Edges
GraphNodes ← |3 ⨬(◌⍢(⊙GraphNodes ⊃↘₁⊢|>0⧻) :⊙(°□⊸get) ⤚⊂|⋅⊙◌) ◡˜∊

# Part 1. Connect 10 or 1000 first connections. How many groups are formed?
# ◌⍢(⊙Append ⊃↘₁⊢|>0⧻) ⟜(map:˜↯□[]⊸⧻ ◴♭) ↙1000 ⍜♭₂⊛ Connections
# $PartOne /×↙¯3 ⍆≡◇⧻ ◴≡(□⍆GraphNodes :[]) ⊃(⊙◌°map|¤)

# Part 2. Keep connecting, what is the first pair of nodes that will create a full cycle?
# I don't know if this is doable. I don't have enough RAM for it, or it's not good enough.
⧻⊙◌ ⍢(⊙Append⊃↘₁⊢|≠NodesCount ⧻GraphNodes 0 [] ◌) ⟜(map:˜↯□[]⊸⧻ ◴♭) ⊸⍜♭₂⊛ Connections
/×⊡-1-⊙⊸⧻
