Data ← ⍜⍉(↘1) ⬚"0"regex "(mul\\((\\d+),(\\d+)\\)|don't\\(\\)|do\\(\\))" ⊂"do()" &fras "input.txt"

# Part 1. Select rows starting mul, drop the text column.
# Parse all to numbers, and multiply reduce, and sum all.
/+/× ∵⋕↘1⍉ ▽⊸≡(◇(≍"mul"↙3)⊢) Data

# Part 2. Group rows starting with do() and don't().
# For each group, if group's length = 0, then do nothing, and return 0.
#   If group's available, check first element of matrix, if it matches "do()", do part 1, if not, drop all and return 0.
# The answer is the sum of all calculated groups.
Calc ← ⨬(0◌|/+/× ∵⋕↘1⍉) ◇(≍"do()") ⊢⊢.
/+⊕(⨬Calc(0◌) =0⧻.) \+⊸≡(◇(↥⊃(≍"don't()"|≍"do()")) ⊢) Data
