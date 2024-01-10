calc ← {
    ⍺ ← 20151125 1 1          ⍝ Initial value and row and col.
    v cr cc r c ← ∊⍺⍵         ⍝ Extract: value, current row, current column, target row, target col.
    cr cc≡r c:v               ⍝ If we're at the target, return the value.
    next ← 33554393|252533×v  ⍝ Calculate the next value.
    cr=1:r c∇⍨∊next,(cc+1),1  ⍝ If we're at the top, move to the next diagonal.
    r c∇⍨∊next,(cr-1),(cc+1)  ⍝ Otherwise, move up and to the right.
}

⍝ Part 1. Find the number at row and col.
calc row col

⍝ Part 2. Special. Don't need code. Do it directly on the website.
⍞∘←⍣8⊢'⍤'
{⎕A⊃⍨4+13÷⍨⍵}⍤0⊢117 13 182 182 273 ¯13 52 182 65 195 208 117 ¯39 195
