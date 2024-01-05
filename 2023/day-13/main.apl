rd←⊃⎕NGET'./input.txt'1                            ⍝ Read the input into an array of lines.
m←{↑¨⍵⊆⍨≢¨⍵}rd                                    ⍝ Split the lines into an array of matrices.

⍝ Short for "is-Horizontal-Mirror". Loop to check if the matrix is horizontally symmetric
⍝ based on some horizontal line. As if "can the matrix be folded on that line"?
hm←{ 
    a←⊃⍺ ⋄ b←2⊃⍺ ⋄ d←3⊃⍺     ⍝ a is the first row, b is the "supposedly" symmetric row, d is the "tolerance". We can tolerate at most 1 non-match.
    (a<1)∨(b>≢⍵):d=0          ⍝ If any line is out of bounds, then we are done, it is symmetric.
    td←+/⍵[a;]≠⍵[b;]          ⍝ Saves to "Total Difference" between two lines.
    td>d:0                    ⍝ If there are more differences than tolerated amount, the matrix is NOT symmetric.
    ⍵ ∇⍨(¯1 1(-td)+a b d)     ⍝ Recurse.
}

⍝ Function to solve both parts, as both parts only differ in the tolerated amount.
solve←{
    ⍺←0 ⋄ d←⍺                                      ⍝ Default tolerated amount is 0 (exact match).
    hv←+/100×¨∊{⍸⍵(hm⍤1 2)⍨↑{⍵(⍵+1)d}¨⍳1-⍨≢⍵}¨⍵     ⍝ All horizontal lines. Value of a horizontal mirror is index * 100.
    cv←+/∊{⍸⍵(hm⍤1 2)⍨↑{⍵(⍵+1)d}¨⍳1-⍨≢⍵}¨⍉¨⍵        ⍝ All vertical lines. Value of a vertical mirror is itself. Transpose means we can use the same algorithm for rows on columns.
    hv+cv                                           ⍝ Sum of the values is the solution.
}

solve m     ⍝ Part 1: Tolerance = 0.
1 solve m   ⍝ Part 2: Tolerance = 1.
