Data ← ⊜⋕ ⊸≠@\n &fras "d22.txt"

# Mix takes the bitwise XOR of two numbers.
# XOR ? A B
Mix ← ⍜∩⋯⬚0≠

# Prunes modulo 16777216
# Pruned ? Num
Prune ← ◿16777216

# Calculates the next secret number.
# Next ? Num
NextSecret ← memo((Prune Mix ⊸×2048)(Prune Mix⌊⊸÷32)(Prune Mix⊸×64))

Results ← ⍉⍥(˜⊂≡NextSecret⊸⊣)2000 ¤Data
Prices  ← ◿10 Results

# Part 1. Sum of the 2000th secret number of each one.
$PartOne /+⊣⍉Results

# Part 2. Find a sequence of changes of 4 numbers that retrieves the most banans.
Changes    ← ≡(⧈/-2) Prices
Sequences  ← ◴♭₂≡(⧈∘4) Changes
SumBananas ← ˜≡(⬚0⊡) Prices+4 ≡(⨬(∞◌|⊢)≠0⊸⧻ ⊚) ˜⦷ Changes
$PartTwo /↥≡(/+SumBananas) Sequences
