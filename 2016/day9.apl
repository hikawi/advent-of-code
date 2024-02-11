⍝ Woo. A pretty difficult day. Get the first line in the text file.
data ← ⊃⊃⎕NGET'day9.txt'1

⍝ Part 1. Count the length of the decompressed string v1.
count ← {
    ⍺ ← 0                          ⍝ Accumulator for the length of the decompressed string.
    o c ← ⍸¨('('=⍵)(')'=⍵)         ⍝ Find the (o)pening and (c)losing parentheses.
    0=≢o:⍺+≢⍵                      ⍝ If there are no parentheses, return acc + len(w)
    1≠⊃o:(⍺+1-⍨⊃o)∇⍵↓⍨1-⍨⊃o        ⍝ If the index of the first open paren is not 1 (not at the start), cut the string until that point, add length, and recurse.
    n m ← ⍎¨'x'(≠⊆⊢)¯1↓1↓⍵↑⍨⊃c    ⍝ We know the next portion is the marker, parse into (n)umber and (m)ultiplier.
    (⍺+n×m)∇(n↓⍵↓⍨⊃c)              ⍝ Add n*m to the acc, and cut out n+len(marker) of the string.
}
count data

⍝ Part 2. Count the length of the decompressed string v2.
⍝ Every marker after being decompressed CAN be decompressed again, no limits until no markers are left.
decompress ← {
    ⍺ ← (1⍴⍨≢⍵)(0)                           ⍝ Create a multiplier mask for each char, and the accum length.
    muls len ← ⍺                             ⍝ Unpack the mask and length.
    0=≢⍵:len                                 ⍝ If the string is empty, return the length.
    '('≠⊃⍵:(1↓⍵)∇⍨(1↓muls)(len+⊃muls)        ⍝ If the first char is not a '(', add current multiplier, recurse with tail.
    n m ← ⍎¨'x'(≠⊆⊢)⊃'(\d+)x(\d+)'⎕s'&'⊢⍵   ⍝ Parse the marker.
    fc ← ⊃⍸')'=⍵                             ⍝ Find the (f)irst (c)losing paren.
    muls[(⍳n)+fc] ×← m                       ⍝ Multiply the mask by m for the next n chars AFTER fc.
    (fc↓muls)len∇fc↓⍵                        ⍝ Recurse with the tail of the string.
}
⎕pp ← 32          ⍝ The number has E10, so just increase the precision here.
decompress data   ⍝ This is a bit slow.
