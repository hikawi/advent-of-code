data ← ⊃⎕NGET'day4.txt'1

⍝ Part 1. Just three simple tests with a train.
⍝ Contains >= 3 vowels, has double chars, doesn't contain ab, cd, pq, xy
threevowels ← {3≤+/5≥'aeiou'⍳⍵}
doublechars ← {0<+/2=/⍵}
valid ← {s←⍵ ⋄ 0=+/{+/s⍷⍨⍵}¨'ab' 'cd' 'pq' 'xy'}
nice ← doublechars∧threevowels∧valid
+/nice¨data

⍝ Part 2. Just not related to part one at all.
⍝ We check for nonoverlapping pairs, by finding substrings, and then take last and first place
⍝ where they appear. If their distance is >1, they don't overlap.
⍝ Checking the three letters thing is easy, just check if its reverse is the same.
overlaps ← {c←2,/⍵ ⋄ (≢=≢∘∪)c:0 ⋄ 0<+/1<-(-/⊃,⊃∘⌽)¨⍸¨⍷∘⍵¨c}
hasthreeletters ← {0<+/(⊢≡⌽)¨3,/⍵}
nice ← hasthreeletters∧overlaps
+/nice¨data
