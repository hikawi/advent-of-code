Data ← ⊜∘ ⊸≠@\n &fras "3.txt"

# Replace one of the past digits with the new one if it's possible to do so.
# I have no clue what I wrote here.
# ReplacedDigits ? Digits NewDigit CombinationCount RemainingDigits
ReplacePastDigit ← ⨬(⊂↙|⋅⊙◌) ⊸=∞ ⍣⊢∞⊚ ↧⊙(:⊙(≥⊙: -1-⊙:) ⟜(⇡⧻)) ◡>

# Returns the next step in the greedy algorithm given the following params.
# NextDigits ? Digits NewDigit CombinationCount RemainingDigits
GreedyStep ← ⨬(⊙◌|⊂) ↧⊙(<⊙⊸⧻ :⊙:) ⤚≍ ⤚₃ReplacePastDigit

# Returns the combination of X digits that return the highest value of joltage.
# Joltage ? X Bank
BestCombination ← ⊙⋅◌ ⍢(⊙⋅⊙◌ ⊸₃GreedyStep ⊙: ⊙⊙⊃(⋕⊢|-1⧻|↘₁)|>0⋅⋅⧻) []

$PartOne /+≡(⋕/⊂≡°⋕ BestCombination 2) Data
$PartTwo /+≡(⋕/⊂≡°⋕ BestCombination 12) Data
