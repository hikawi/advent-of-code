data ← ⊃⎕NGET'day9.txt'1

⍝ Just a simple counting algorithm.
count ← {
    ⍺←2 0
    2>≢⍵:⍺+≢⍵
    ('\\'∘≡∨'\"'∘≡)2↑⍵:(⍺+2 1)∇2↓⍵
    '\x'≡2↑⍵:(⍺+4 1)∇4↓⍵
    (⍺+1 1)∇1↓⍵
}
-/+⌿↑count¨(1∘↓¯1∘↓)¨data

⍝ Encode and then count.
encode ← {
    ⍺←''
    0=≢⍵:⍺
    cc ← '' '\'[1+('\'∘=∨'"'∘=)⊃⍵]
    (∊⍺,cc,⊃⍵)∇1↓⍵
}
-/+⌿↑count∘encode¨data
