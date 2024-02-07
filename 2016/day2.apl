⍝ Map U to [0 -1], D to [0 1], L to [-1 0], R to [1 0]
data ← (0 ¯1)(¯1 0)(0 1)(1 0)(0 0)['ULDR'⍳↑⊃⎕NGET'day2.txt' 1]

⍝ The move function, starts at [2 2], move accordingly to the function passed in.
⍝ Part 1. The function passed in just sums, then takes min and max. Index it to the keypad.
move ← {⍺←⊂2 2 ⋄ 0=≢⍵:1↓⍺ ⋄ a←⍺,⍺⍺/⌽(⊂⊃⌽⍺),1⌷⍵ ⋄ a∇1↓⍵}
(3 3⍴⍳9)[⌽¨(3 3∘⌊⍥(1 1∘⌈))⍤+move data]

⍝ Part 2. The function passed in checks if the move is legal, then applies it.
⍝ The keypad is now a 5x5 matrix, and the legal function checks if the move is within the bounds of the keypad.
legal ← {x y←⍵ ⋄ (x≤0)∨(x>5):0 ⋄ mn mx←x⊃(3 3)(2 4)(1 5)(2 4)(3 3) ⋄ (mn≤y)∧(y≤mx)}
move ← {⍺←⊂1 3 ⋄ 0=≢⍵:1↓⍺ ⋄ a←⍺,⍺⍺/⌽(⊂⊃⌽⍺),1⌷⍵ ⋄ a∇1↓⍵}
↑'00100' '02340' '56789' '0ABC0' '00D00'[⌽¨{legal ⍺+⍵:⍺+⍵ ⋄ ⍵}move data]

⍝ Before indexing, we reverse each coord set, because we worked with (x, y) but the keypad is (y, x).
⍝ Or rows before columns, that's how matrices work.
