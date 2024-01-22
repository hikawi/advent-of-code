Data ← ⊜∘≠@\n.&fras "day6.txt"

# Both solutions are similar: transpose the data, count elements, sort by count, take first (which will be min or max), unbox the character into a char array.
≡(°□⊢ ⊢⊏⍖□⊢⇌⍉. ⊕(⊟∩□⊃⊢⧻) ⊛.) ⍉Data # Part 1. Take fall, to get max count.
≡(°□⊢ ⊢⊏⍏□⊢⇌⍉. ⊕(⊟∩□⊃⊢⧻) ⊛.) ⍉Data # Part 2. Take rise, to get min count.
