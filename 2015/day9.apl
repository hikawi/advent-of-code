data ← ⊃⎕NGET'day9.txt'1

⍝ Creates a nested array that looks like [['Faerun','Tambi','81'],...]
map ← (5⍴1 0)∘/¨' '∘(≠⊆⊢)¨data

⍝ The first two elements of each nested array is the "locations"
⍝ Take all of them, then collapse into a unique list.
locations ← ⊃∪/{⍵[1 2]}¨map

⍝ Function to insert the number 8 in an array, like given 1 2 3, it would return 8 1 2 3, 1 8 2 3, 1 2 8 3,...
insert ← {⍺←0 ⍬ ⋄ i a←⍺ ⋄ (≢⍵)<i:a ⋄ n←(i↑⍵),8,(i↓⍵) ⋄ (i+1)(a,⊂n)∇ ⍵}

⍝ The distance map. From ['Faerun', 'Tambi', '81] to [1,8,81] where the indices like 1,8 corresponds
⍝ to the indices in the locations list.
distmap ← {s d v←⍵ ⋄ (⍎v),⍨{locations⍳⊂⍵}¨s d}¨map

⍝ The find function uses indices, returns the distance.
find ← {+/⍺⍵∘{a b c←⍵ ⋄ (⍺≡b a)∨(⍺≡a b):c ⋄ 0}¨distmap}

⍝ Part 1, use a min reduce on all possible permutations.
⌊/{⌊/+/¨2find/¨insert⍵}¨{⍵/⍨(⊢≡∪)¨⍵},⍳7⍴7

⍝ Part 2, use a max reduce on all possible permutations.
⌈/{⌈/+/¨2find/¨insert⍵}¨{⍵/⍨(⊢≡∪)¨⍵},⍳7⍴7
