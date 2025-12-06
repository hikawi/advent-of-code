Data ← ⍜⍉↘₁ ≡⊕□ ¤\+⊸(≠@ ⊣) ⊜∘⊸≠@\n &fras "6.txt"

# Parse a number with respect to the operator.
Parse! ← ⍣(⋕▽⊸≠@ )^0

# Part 1. Each column should be summed or multiplied, depending on the operator.
# We just check each row after transpose, and reduce.
# Most of this just tries to get the number into a parsable format to call parse() on,
# since Uiua doesn't have lstrip() or rstrip(), and whitespaces = invalid parse.
$PartOne /+≡(⨬/◇+/◇× ⊙≡(◇Parse!(0)) ◇(=@*⊢) ⊃⊣↘₋₁) ⍉Data

# Part 2. Just tricky rearranging, thankfully Uiua is amazing at matrix transformations.
# Same thing as part one, just the reading part is different.
$PartTwo /+≡(⨬(/+≡Parse!(0)|/×≡Parse!(1)) =@*: ⊃(⍉≡°□↘₋₁|◇⊢⊣)) ⍉Data
