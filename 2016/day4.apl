⍝ Read in data, split based on regex, and mix up into a matrix with 3 columns (name, sector, checksum)
data ← ↑' '∘(≠⊆⊢)¨'(.+)-(\d+)\[(.+)\]'⎕R'\1 \2 \3'⊃⎕NGET'day4.txt' 1

⍝ Function to check if it is a real room.
⍝ We do this by sorting alphabetically, then creating a histogram and save it in l.
⍝ Then, we sort l by the count, then take the first 5, and make a string from that. Match that with the checksum.
real ← {l←{⍺,≢⍵}⌸w[⍋w←'-'⎕r''⊃⍵] ⋄ (⊃⌽⍵)≡1⌷⍉5↑l[⍒2⌷⍉l;]}

⍝ Part 1. If real: return sector, else return 0. Sum all.
+/{real ⍵:⍎2⊃⍵ ⋄ 0}⍤1⊢data

⍝ Part 2.
⍝ Compress the data to only the real rooms with the function from part 1.
⍝ Then attempt to decrypt the name by rotating the letters, save the list of decrypted name,sector to dec.
⍝ Then filter out the ones with 'north' in the name, select the sector, and print the result.
alp ← 'abcdefghijklmnopqrstuvwxyz'
dec⌷⍨⍸{0<+/'north'⍷⊃⍵}⍤1⊢dec←{n r _←⍵ ⋄ r←⍎r ⋄ r,⍨{⍺,' ',⍵}/{alp[1+26|r+1-⍨alp⍳⍵]}¨'-'(≠⊆⊢)n}⍤1⊢data⌿⍨real⍤1⊢data
