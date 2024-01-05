data ← ⊃⎕NGET'day12.txt'1

⍝ Part 1. Read the JSON as a matrix (4 columns of "Depth", "Name", "Data", "Type").
⍝ Take lines where the type element is 3 (which means the data is numeric)
⍝ Take the 3rd column with 0 0 1 0/ and sum it.
+/∊0 0 1 0/m⌿⍨{3=⊃⌽⍵}⍤1⊢m←0⎕JSON⍠'M'⊢⊃data

⍝ Function stolen from "https://xpqz.github.io/learnapl/io.html#reading-json-json"
⍝ Extract all values in a JSON object, if there is a "red" in the values, just return a 0.
vals ← {
    keys ← ⍵.⎕NL¯2
    values ← keys {0=≢⍺:⍬⋄⍵.(⍎¨⍺)} ⍵
    values∊⍨⊂'red':0
    0=≢⍵.⎕NL¯9:values       ⍝ No nested namespaces: done
    values,∊∇¨⍵.(⍎¨⎕NL¯9)   ⍝ Also expand any namespaces we found as values
}

⍝ Sum all values in a JSON object after extraction.
sum ← {
    {(1=2|⎕DR)⍵}⍵:⍵                    ⍝ Are we a number?
    (⍕≡⊢)⍵:0                           ⍝ Are we a string?
    {(326=⎕DR⍵)∧(0=≡)⍵}⍵:+/∇vals ⍵     ⍝ Are we an object?
    +/∊∇¨⍵                             ⍝ We're a list
}

sum⊢0 ⎕JSON⊢⊃data
