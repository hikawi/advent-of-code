Data ← ⊜(∵⋕⍜⍉↘₁ regex "X[\\+=](\\d+), Y[\\+=](\\d+)") ¬⊸⦷"\n\n" &fras "d13.txt"

# Checks if a value is an integer by doing floor and ceil and check if they are the same
# IsInt ? Num
IsInt ← =⊃⌊⌈

# Solve a linear equation. Returns two results, if no results return [pi pi].
# We only care about integer results
# Solutions ? Eq1 Eq2
Solve ← ⍣(⊟⁅₃-°⊟↘1 ⍜(⊡1|×) ⊙(. ⁅₃÷°⊟↘1-) ⟜×⊙⊸⊢ ÷⊸⊢)[ππ]

# Part 1. Solve each equation. Then multiply A presses by A and B presses by 1.
/+≡(/+×3_1) ▽≡(/↧⊸IsInt Solve °⊟⍉) Data

# Part 2. The last row is suddenly 10000000000000 units greater. Same thing as part 1.
/+≡(/+×3_1) ▽≡(/↧⊸IsInt Solve °⊟⍉ ⍜⊣(+10000000000000)) Data
