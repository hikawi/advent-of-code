display ← {
    ⍺ ← 6 50⍴'.'   ⍝ The screen 6 rows x 50 columns.
    0=≢⍵:⍺         ⍝ If no commands left, return the screen.
    a ← ⍺          ⍝ Copy, as we can't modify the argument.
    1=≢⍸'rect'⍷⊃⍵:{                             ⍝ If the command is 'rect'.
        c r ← ⍎¨'(\d+)'⎕s'&'⊃⍵                  ⍝ Parse the column and row.
        (1↓⍵)display⍨a⊣a[⍳r;⍳c]←'#'             ⍝ Turn on the lights and recurse.
    }⍵
    1=≢⍸'x='⍷⊃⍵:{                               ⍝ If the command is 'rotate column' (check with 'x=').
        x r ← ⍎¨'(\d+)'⎕s'&'⊃⍵                  ⍝ Parse the column and the rotation.
        (1↓⍵)display⍨a⊣a[;x+1]←a[;x+1]⌽⍨-r      ⍝ Rotate the column and recurse.
    }⍵
    y r ← ⍎¨'(\d+)'⎕s'&'⊃⍵                      ⍝ Else, the command is 'rotate row'.
    (1↓⍵)∇⍨a⊣a[y+1;]←a[y+1;]⌽⍨-r                ⍝ Rotate the row and recurse.
}

⍝ Part 1. Count '#', ravel, and sum.
+/,'#'=display ⊃⎕NGET'day8.txt'1

⍝ Part 2. Display the screen.
display ⊃⎕NGET'day8.txt'1
