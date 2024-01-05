⍝ Just simulate the thing by eval() lol.
AND ← {2⊥(⍺⊤⍨16⍴2)∧(⍵⊤⍨16⍴2)}
OR ← {2⊥(⍺⊤⍨16⍴2)∨(⍵⊤⍨16⍴2)}
LSHIFT ← {2⊥(16⍴2)⊤⍺×2*⍵}
RSHIFT ← {2⊥(16⍴2)⊤⌊⍺÷2*⍵}
NOT ← {2⊥~⍵⊤⍨16⍴2}

⍝ Function to execute, ret 0 if can't execute.
exe ← {6::0 ⋄ t←⍎⍵ ⋄ 1}
data ← ⊃⎕NGET'day7.txt'1

⍝ Solve function is just keep executing until no more can be executed.
solve ← {0=≢⍵:a ⋄ mask←~exe¨⍵ ⋄ ∇mask/⍵}

⍝ Part 1. Remember to clear workspace! )clear
solve {∊(¯1↑⍵)'←'({⍺,' ',⍵}/¯2↓⍵)}¨' '∘(≠⊆⊢)¨data

⍝ Part 2. Remember to clear workspace again!
⍝ Also, I cheated in this. I removed the line that assigns to b in the input.
b ← a ⍝ Your a value from part 1.
solve {∊(¯1↑⍵)'←'({⍺,' ',⍵}/¯2↓⍵)}¨' '∘(≠⊆⊢)¨data
