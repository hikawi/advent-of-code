⍝ The usual.
data ← ⊃⎕NGET'day13.txt'1

⍝ Uses regex to split the data into a 4-column matrix, with cols as "Person" "Gain/Lose" "Amount" "Other Person"
grid ← ' '∘(≠⊆⊢)⍤1⊢↑('(.+) would (gain|lose) (\d+) .+ to (.+)\.'⎕S'\1 \2 \3 \4')data

⍝ Function to generate ALL permutations from 1 to n.
perm ← {p/⍨(∪≡⊢)¨p←(,∘⍳⍴⍨)⍵}

⍝ The list of people, take the first column, then remove duplicates.
people ← ∪grid[;1]

⍝ Transform the grid into a number grid, like if Alice is index 1 and Bob is index 2,
⍝ the line "Alice gain 54 Bob" becomes "1 2 54".
numgrid ← {i←people⍳(⊂⊃⍵),(⊂⊃⌽⍵) ⋄ m←{'gain'≡2⊃⍵:1 ⋄ ¯1}⍵ ⋄ v←m×⍎3⊃⍵ ⋄ ∊i,v}⍤1⊢grid

⍝ Given a 2-element vector, it returns the happiness value of the first person.
happiness ← {3::0 ⋄ ⊃∘⌽numgrid⌷⍨⊃∘⍸⍵∘≡¨↓numgrid[;1 2]}

⍝ Total happiness change for the middle person.
total ← {l m r←⍵ ⋄ (happiness⊢m r)+happiness⊢m l}

⍝ Part 1. Iterates all permutations, and take max.
⌈/{f l←(⊃,⊃∘⌽)⍵ ⋄ +/total¨3,/∊l⍵f}¨perm≢people

⍝ Function to insert the number 9 (Myself) into a vector into all possible positions.
⍝ Given [1,2,3] fe, it returns [[9,1,2,3],[1,9,2,3],[1,2,9,3],[1,2,3,9]].
insert ← {↓(⍳¨⍳9){1∘⌽@(∊⍺)⊢⍵}⍤0 1⊢9 9⍴9,⍵}

⍝ Part 2. For each permutation in part 1, there are 9 more possible solutions. We can't expand everything because
⍝ it would be out of memory, so we do all the max stuff for those 9 solutions, then take max of the numeric vector
⍝ that remains.
⌈/{⌈/{f l←(⊃,⊃∘⌽)⍵ ⋄ +/total¨3,/∊l⍵f}¨insert⍵}¨perm≢people
