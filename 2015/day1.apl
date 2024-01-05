data ← ⊃⊃⎕NGET'./day1.txt'1   ⍝ Get first line of day1.txt
+⌿(¯1 1)[1+'('∘=¨data]        ⍝ Map '(' to 1, ')' to ¯1, sum
⊃⍸0>+⍀(¯1 1)[1+'('∘=¨data]    ⍝ Find first position where sum is negative using scan
