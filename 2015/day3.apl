data ← ⊃⊃⎕NGET'day3.txt'1
mkdir ← {((0 ¯1)(1 0)(0 1)(¯1 0))['^>v<'⍳⍵]} ⍝ Function to map each ^v>< to a direction 
≢∪+⍀↑mkdir data                              ⍝ Part 1, count unique coords by doing a sum scan, then down shoe.
≢∪(⊂0 0),,+⍀[1]mkdir data⍴⍨2,⍨2÷⍨≢data       ⍝ Part 2, count unique coords of 2 alternating sequences (santa + robosanta).
