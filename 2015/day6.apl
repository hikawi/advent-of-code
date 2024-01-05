data ← ¯4∘↑¨' '∘(≠⊆⊢)¨⊃⎕NGET'day6.txt'1

⍝ Part 1. Simulate the lights.
parse ← {(⍎⊃⍵[2])∘+¨⍳⊃1+--/⍎¨⍵[2 4]}
puton ← {a←⍺ ⋄ tmp←{a[⊂⍵]←1}¨parse⊢⍵ ⋄ a}
putoff ← {a←⍺ ⋄ tmp←{a[⊂⍵]←0}¨parse⊢⍵ ⋄ a}
toggle ← {a←⍺ ⋄ tmp←{v←a[⊂⍵] ⋄ a[⊂⍵]←1-v}¨parse⊢⍵ ⋄ a}
lights ← {
    ⍺ ← 1000 1000⍴0
    0=≢⍵:+/,⍺
    'on'≡⊃⊃⍵:(⍺puton⊃⍵)∇1↓⍵
    'off'≡⊃⊃⍵:(⍺putoff⊃⍵)∇1↓⍵
    (⍺toggle⊃⍵)∇1↓⍵
}
lights data

⍝ Part 2. Simulate the lights literally, nothing special.
puton ← {a←⍺ ⋄ tmp←{a[⊂⍵]+←1}¨parse⊢⍵ ⋄ a}
putoff ← {a←⍺ ⋄ tmp←{a[⊂⍵]←0⌈a[⊂⍵]-1}¨parse⊢⍵ ⋄ a}
toggle ← {a←⍺ ⋄ tmp←{a[⊂⍵]+←2}¨parse⊢⍵ ⋄ a}
lights data
