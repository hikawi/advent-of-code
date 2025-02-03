# Experimental!

Data  ← ⊜∘⊸≠@\n &fras "d6.txt"
Start ← ≡(𝄈⊂¯1_0) ⊚=@^ Data

# So we want a few variables to keep track: CurrentCoordWithDirection Grid StepList

# Computes the next theoretical step of the current situation.
# Next ? Current
NextStep ← ⊂⊸+⊃↙↘2

# Turns the guard 90 degrees to the right. [-1 0] (up) would become [0 1] (right), then [1 0] (down), then [0 -1] (left)
# Next ? Current
Turn ← 𝄈⊂×1_¯1⇌⊃↘↙2

# Checks if the current coord is out of bounds.
# OOB ? Coord
OOB ← /↥↥⊃(<0|≥△Data) ↙2

# Checks if with the current situation, can we step forward?
# CanStep ? Situation Grid
CanStep ← ≠@#⊡↙2 NextStep

# Checks if with the current situation, if we can successfully move forward, would it create a loop?
# Looping ? Situation Grid StepList
Looped ← ⨬(0◌◌◌|𝄈∊NextStep ⊙◌) ◡CanStep

# Checks if given the data, whether this guard would loop.
# Looping ? Situation Grid StepList
WouldLoop ← (
  ⍢(⨬(Turn|⊙⊙𝄈⊂ ⟜:NextStep) ◡CanStep|⍣(↧⊃(¬Looped|¬OOB NextStep))0)
  ¬OOB NextStep ⊙⋅◌
)

# Part 1. Wait until the guard goes out of bounds. How many unique squares the guard has traversed?
# We just simulate the guard, and deduplicate the step list afterwards.
⧻◴⍜⍉↙₂◌◌ ⍢(⨬(Turn|⊙⊙𝄈⊂ ⟜:NextStep) ◡CanStep|¬OOB NextStep) °¤Start Data Start

# Part 2. How many spots where we can place another obstruction that would cause the guard to go in a loop?
# Here, I'm just simulating every spot, then count.
◴♭₃⊞(⍜⊡(@#◌)) ⊙¤ ⍜↻↘₁ ⊸⊗ ↙2°¤Start ♭₂⇡⊸△Data
/+wait≡pool(WouldLoop ⊙: °¤Start Start)
