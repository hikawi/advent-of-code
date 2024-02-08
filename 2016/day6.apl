⍝ Part 1. Take data in, mix into a matrix, transpose to work with columns as rows.
⍝ Take histogram, grade down by histogram, take first (most common) of each column.
{⊃m[⍒2⌷⍉m←{⍺,≢⍵}⌸⍵;]}⍤1⍉↑⊃⎕NGET'day6.txt' 1

⍝ Part 2. Same as part 1, but now grade up, take first (least common).
{⊃m[⍋2⌷⍉m←{⍺,≢⍵}⌸⍵;]}⍤1⍉↑⊃⎕NGET'day6.txt' 1
