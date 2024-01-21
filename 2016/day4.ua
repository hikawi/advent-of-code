Data ← ⍜(⍉|↘1) regex "([a-z\\-]+)(\\d+)\\[(.+)\\]" &fras "day4.txt"

# Part 1:
Checksum ← ⊏↙5⍖≡(°□)⊢⇌⍉. ⊏⍏≡(°□)⊢⍉. ⊕([∩□⊃⊢⧻])⊛. ▽≠@-.°□ # Function to compute the checksum. Just count occurrences and sort by lettrs.
IsReal ← ≍∩(⊏⍏.) ⊃(≡(°□⊢)Checksum⊢|°□⊢⇌)                 # Returns 1 if is real room. Compute checksum, sort checksum and provided one, check by matching.
/+ ≡((↧0|∘) ⊃(IsReal|⋕⊡1)) Data                          # If is real, then returns the room ID, if not, returns 0. Sum all.

# Part 2:
Rotate ← ⍜(⊏|-26) ⊚>@z. +◿26                         # Rotations mod 26. Increase. Then decrease all chars that go above z by 26.
Join ← /(□⊂∩°□) ⍜(↘¯1|≡(□⊂:@\s°□))                   # Join all boxed strings as one string with proper concat.
Decrypt ← Join ⊞(□Rotate:°□) ⊜□≠@-.↘¯1 :⋕:∩°□°⊟↙2    # Remove the checksum, unboxing, partition by hyphens, rotate each partition, then join back.
⊏⊚≡(≠0⧻⊚⌕"north"°□) ≡(⊃(Decrypt|⋕⊡1)) ▽≡IsReal. Data # Remove all fake rooms, decrypt, find a room with "north" in it, select their room IDs out.
