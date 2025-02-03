Data ← &fras "d3.txt"

# Part 1. Find mul(a,b) and calculate a * b. What is the sum of all multiplications?
/+×°⊟ ∵⋕ ↘1⍉ regex "mul\\((\\d+),(\\d+)\\)" Data

# Part 2. There are "do()"s and "don't()"s that toggle where the next "mul()"s matter.
# These don't alternate, and it's a flip switch, it matters for all mul() until the next directive.
⍜⍉↘₁ ⬚""regex "(do\\(\\)|don't\\(\\)|mul\\((\\d+),(\\d+)\\))" ⊂"do()" Data
↘1⊕□ \+⊸≡(↥◇⊃(≍"do()"|≍"don't()") ⊢)
°□/+⍚(⨬(/+/×∵⋕↘1⍉↘1|0◌) ◇(≍"don't()") ⊢⊸⊢)
