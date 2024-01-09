⍝ Set the precision higher because holy the product.
⎕PP ← 32

⍝ Function to generate all combinations of r elements from n.
comb ← {
    r n ← ⍵ 
    cmbs ← ⍬    
    gen ← {
        r=≢⍵:cmbs,←⊂⍵   ⍝ If current len = r, add it to list of combs.
        l←(⊃⌽⍵)+⍳n-⊃⌽⍵  ⍝ Generate "possible" next elements. For example, with r = 3 from 1 2 3 4 5, and we have 2 3 already, the possible elements can be only 4 or 5.
        0=≢l:⍬          ⍝ If there are no possible elements, stop.
        ⍵∘{gen∊⍺⍵}¨l    ⍝ If there are, recurse again.
    }
    cmbs⊣gen¨⍳n-r-1     ⍝ Generate all possible starting elements. We assign to t to stop it
}

⍝ Function to find the smallest set of presents that add up to "total" from "data".
find ← {
    r ← ⍵
    t ← t/⍨{total=+/data[⍵]}¨t←comb r,≢data ⍝ Filter out all combinations that don't add up to total.
    0=≢t:∇r+1        ⍝ If there are no combinations that add up to total, recurse with r+1.
    ⌊/{×/data[⍵]}¨t  ⍝ Otherwise, find the smallest product.
}

⍝ Part 1. Split into 3 groups.
total←3÷⍨+/data ← ⍎¨,⊃⎕NGET'day24.txt'1
find 1

⍝ Part 2. Split into 4 groups.
total←4÷⍨+/data
find 1
