# Parse the data into sections.
∩°□°⊟ ⊜□¬⊸⦷"\n\n" &fras "d5.txt"

⊜(⊜⋕⊸≠@|) ⊸≠@\n
Ordering ←

⊜(□⊜⋕⊸≠@,) ⊸≠@\n
Updates ←

IsSorted ← =1/↧⧈(∊Ordering) 2
StepSort ← ◌⍢(⊙(⍜⊏(⨬⇌∘ ⊸∊Ordering) ⇌⊟+1.) ⊃↘₁⊢|>0⧻) ↘¯1⇡⊸⧻
Sort     ← ⍢(StepSort|¬IsSorted)

# Part 1. If it is sorted, take out center elements and sum.
/+≡(⊡⌊÷2◇⊸⧻) ▽⊸≡◇IsSorted Updates

# Part 2. If it is not sorted, sort then take out center elements and sum.
/+≡(⊡⌊÷2⊸⧻ ◇Sort) ▽¬⊸≡◇IsSorted Updates
