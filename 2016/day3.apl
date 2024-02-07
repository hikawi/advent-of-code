⍝ Read the data, extract only digits, mix up into a matrix and parse all numbers.
data ← ⍎¨↑'\d+'⎕S'&'¨⊃⎕NGET'day3.txt' 1

⍝ Part 1. For each row, calculate if 2max(a,b,c) < sum(a,b,c), which means it's a triangle.
⍝ Count how many triangles.
+/((2×⌈/)<(+/))⍤1⊢data

⍝ Part 2. The triangle data is in columns. Transpose, ravel, gives the new order of the numbers.
⍝ Reshape into a 3-column matrix and repeat the part 1.
+/((2×⌈/)<(+/))⍤1⊢(3,⍨≢data)⍴,⍉⊢data
