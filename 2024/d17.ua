⊃↙↘3 ≡⋕⊢⍉ regex "(\\d+)" &fras "d17.txt"
Reg ←
Ins ←

# Evaluates the provided operand
# value ? operand registers
EvalOperand ← ⨬(0|1|2|3|⊢|⊡1|⊣|0)

# Fetches the instruction from the instructions array
# opcode operand ? pc
Fetch ← °⊟ ˜⊏Ins +⇡2

# Opcode 0. Division operation. Does A = A / 2^(eval operand).
# outputs pc reg ? outputs operand pc reg
Adv ← ⊙(⊙(⍜⊢(⌊˜÷) :˜ⁿ2 ⊸EvalOperand) +2:)

# Opcode 1. Bitwise XOR. Does B = B XOR operand.
# outputs pc reg ? outputs operand pc reg
Bxl ← ⊙(⊙(⍜⊡₁⍜∩⋯₃₂≠ :) +2:)

# Opcode 2. Modulo 8. Does B = (eval operand) % 8.
# outputs pc reg ? outputs operand pc reg
Bst ← ⊙(⊙(⍜⊡₁⋅∘ :◿8⊸EvalOperand) +2:)

# Opcode 3. Jump not zero. If(a!=0) pc=operand else pc+=2.
# outputs pc reg ? outputs operand pc reg
Jnz ← ⊙(⨬(+2◌|⊙◌) :⊙(:⊙(≠0⊸⊢)))

# Opcode 4. Bitwise register. Does B = B XOR C.
# outputs pc reg ? outputs operand pc reg
Bxc ← ⊙(⊙⍜↙₋₂(⍜°⊟⍜∩⋯₃₂⊸≠) +2◌)

# Opcode 5. Print. Print out (eval operand) % 8.
# outputs pc reg ? outputs operand pc reg
Out ← :⊙(⊂⊙(◿8⊸EvalOperand)) +2:⊙(:)

# Opcode 6. Division. Does B = A / 2^(eval operand).
# outputs pc reg ? outputs operand pc reg
Bdv ← ⊙(⊙(⍜↙₂(⊟⟜(⌊˜÷)⊢) :˜ⁿ2⊸EvalOperand) +2:)

# Opcode 7. Division. Does C = A / 2^(eval operand).
# outputs pc reg ? outputs operand pc reg
Cdv ← ⊙(⊙(⍜(⊏0_2|⊟⟜(⌊˜÷)⊢) :˜ⁿ2⊸EvalOperand) +2:)

# Executes an instruction
# outputs pc reg ? outputs pc reg
Execute ← ⨬(Adv|Bxl|Bst|Jnz|Bxc|Out|Bdv|Cdv) :⊙⊸Fetch

# Part one. Execute and print out
/($"_,_") ⊙⋅◌ ⍢(Execute|<⧻Ins◌) [] 0 Reg

# Part two. Look for the fucking thing to initialize register A with
# to make it output itself.
Idk ← ⍢(&p. +1|¬≍Ins ⊙⋅◌ ⍢(Execute|<⧻Ins◌) [] 0 ⍜⊢⋅∘ Reg)
