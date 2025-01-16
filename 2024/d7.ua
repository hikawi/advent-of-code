# Experimental!

Data ← ⊜(□≡⋕⊢⍉ regex "(\\d+)") ⊸≠@\n &fras "d7.txt"

# Runs a calculated fold. For example, for operations [0 1] on [1 2 3]
# Means do 1+2*3, always evaluate from the left.
# Total ? Operations Nums 
Calc! ← ◌⍢(⊙⊂: ^0 ⊙: ⊓⊃⊢↘₁⊃↙₂↘₂|>0⧻)

# Concatenate two numbers and returns the number version of the concatenated.
# Concatenated ? NumArray
Concat ← ⋕$"__" °⊟

# Retrieves ternary permutations of operations.
# For example, given an array of three numbers, 0 being op1, 1 being op2, and 2 being op3
# We need all [[0 0 0] [0 0 1] [0 0 2] [0 1 0] [0 1 1] ...] permutations.
# Perms NumArray ? NumArray
Ternary ← ≡⇌base3 ⇡ⁿ:3-1⊸⧻

# Part 1. Only have add and multiply.
/+≡◇⊢ ▽wait⊸≡spawn(◇(∊♭⊞Calc!⨬/+/× ⊙¤ ⋯⇡ⁿ:2-1⊸⧻ ⊃↘₁⊢)) Data

# Part 2. Have add, multiply and concatenate.
/+≡◇⊢ ▽wait⊸≡spawn◇(∊♭ ⊞Calc!⨬(/+|/×|Concat) ⊙¤ Ternary ⊃↘₁⊢) Data
