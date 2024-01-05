⍝ The usual.
data ← ⊃⎕NGET'day15.txt'1
grid ← ⍎¨↑','∘(≠⊆⊢)¨'capacity (.+), durability (.+), flavor (.+), texture (.+), calories (.+)'⎕S'\1,\2,\3,\4,\5'⊢data

⍝ We can't generate all permutations of 100x100x100x100 matrix, so we'll let it generate one by one.
list ← ⍬

⍝ If argument has length > 4, not what we want, don't care.
⍝ If argument has length = 4, and adds up to 100, add to list.
⍝ If else, generate all possible combinations of 1-100, and call self recursively.
gen ← {4<≢⍵:⍬ ⋄ (100=+/⍵)∧(4=≢⍵):list,←⊂⍵ ⋄ a←⍵∘,¨1-⍨⍳101-+/⍵ ⋄ ∇¨a}
gen&⍬ ⍝ Use another thread here, because why not.

⍝ Part 1. Test all combinations. If there is any negative, set to 0, so product is 0. Take max reduce of all.
⌈/grid{×/0@(0∘>)¯1↓+⌿⍺×⍤1 0⊢⍵}⍤2 1⊢↑list

⍝ Part 2. Same thing, but filter out any combination that doesn't have 500 calories.
⌈/{×/0@(0∘>)¯1↓⍵}⍤1⊢{⍵⌿⍨{500=⊃⌽⍵}⍤1⊢⍵}grid{+⌿⍺×⍤1 0⊢⍵}⍤2 1⊢↑list
