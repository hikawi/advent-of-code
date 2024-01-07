⍝ Substitute "goal" with your own input.

⍝ Part 1. Find the first number that has divisors sum >= goal/10.
⍝ The idea is going from 2, step by 2, and check if the sum of divisors is >= goal/10.
⍝ Step by 2 cause odd numbers always have a lower sum on average than even numbers, so not worth checking.
(goal÷10){⍺<{+/∪⍵(⊢,÷)⍸0=⍵|⍨⍳⌈⍵*0.5}⍵:⍵ ⋄ ⍺∇⍵+2}2

⍝ Part 2.
⍝ Similarly, but now the divisor sum of n can only contain any x that n/x <= 50 (max houses an elf can go).
⍝ And also, we multiply by 11 now.
goal{⍺<{11×+/f/⍨50≥⍵÷f←∪⍵(⊢,(⌽÷))⍸0=⍵|⍨⍳⌈⍵*0.5}⍵:⍵ ⋄ ⍺∇⍵+1}1
