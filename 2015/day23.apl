⍝ Reading the data, replacing register a and b with its character representation 'a' and 'b'.
instr ← '(a|b)'⎕r'''\1'''⊃⎕NGET'day23.txt'1

⍝ Defining the functions for the instructions.
⍝ Each function returns the number of steps to jump.
inc ← {1⊣⍎⍵,'+←1'}
tpl ← {1⊣⍎⍵,'×←3'}
hlf ← {1⊣⍎⍵,'÷←2'}
jio ← {r s←⍵ ⋄ 1=⍎r:s ⋄ 1}
jie ← {r s←⍵ ⋄ 0=2|⍎r:s ⋄ 1}
jmp ← ⊢
run ← {⍵>≢instr:a b ⋄ ∇⍵+⍎⍵⊃instr}

⍝ Part 1. Set a = 0, b = 0.
⍝ Run with instruction number 1.
a b ← 0 0
run 1

⍝ Part 2. Set a = 1, b = 0.
⍝ Run with instruction number 1.
a b ← 1 0
run 1