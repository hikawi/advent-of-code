# Experimental!

Data     ← ⊜∘ ⊸≠@\n &fras "d6.txt"
StepList ← ≡(⊂:¯1_0) ⊚⌕@^ Data

# A function to turn right, for example starting with (-1, 0), turn right would make (0, 1)
# then, another turn right would be (1, 0). Meaning (y, x) => (x, -y)
# NewDirection ? Direction
Turn ← ⇌×¯1_1

# Returns the next theoretical step.
# NextStep Direction StepList ? Direction StepList
Next ← :⟜+⊙(↘¯2⊸⊣)

# Checks if a coord is out of bounds, it is if it throws an error trying to index into the data.
# IsOutOfBounds ? Coord
OOB ← ↧⊓↧↧ ∩(⊃(≥0|<⧻Data)) °⊟

# Checks if the next coord would step on an obstacle. This does not check for OOB situations.
# CanStep Direction StepList Grid ? Direction StepList Grid
CanStep ← :⊙: ⊙⊙(≠@#⊸⊡) ⊙:: Next

# Steps the guard up one step, this assumes everything is correct to step forward.
# Direction NewStepList ? Direction StepList
Step ← ⊙(⊂:) ⤙⊂ Next

# Checks if the next step, along with the current direction would create a loop.
# IsLoop Direction StepList ? Direction StepList
Looped ← :⊙(:⟜∊:) ⤙⊂ Next

# Part 1. Trace until the guard goes OOB.
⍢(⨬(Turn|Step) CanStep|¬OOB Next) ¯1_0 StepList Data
⧻◴ ⍜⍉↙₂ ⋅⊙◌

# Part 2. Simulate a new obstacle at every spot. Check if that will cause the guard goes in a loop.
# Count how many spots that do that.
# THIS DOESN'T WORK I HATE THIS
◴♭₃ ⊞⍜⊡(@#◌) ⊙¤ ♭₂°⊡ Data
≡pool(⍣(1 ⋅⋅◌ ⍢(⨬(Turn|Step) CanStep|⨬(1|¬Looped) CanStep)|0) ¯1_0 StepList)
/+wait
