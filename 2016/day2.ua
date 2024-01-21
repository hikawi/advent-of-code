Data ← ⊜(□⊏:[0_¯1 ¯1_0 0_1 1_0]⊗:"ULDR") ≠@\n.↘¯1&fras"day2.txt" # Map U -> [0 -1], D -> [0 1] and similarly.
Solve! ← ;;⍢(⊃(↘1|⊙(⊂:¤)./^2⊂:°□⊢)|≠0⧻)                          # Move accordingly (how to move is a function to be passed), save the last position, and repeat.

Move ← (⊙;|+) =0/+↥⊃(<0|>2)+,,        # Moving for PART 1. If after moving, any index < 0 or > 2 is illegal.
⊡: ↯3_3+1⇡9 ≡⇌ Solve!Move Data 1_1 [] # Move, start at [1 1], save all to [], reverse because in Uiua, picking uses (y x) instead of (x y).

IsLegal ← (=2|↧⊃(≥1|≤3)|1;|↧⊃(≥1|≤3)|=2)             # Check if the position is illegal, because it's rather weird.
Move ← ((⊙;|+) IsLegal ∩⊢⊃∘⇌+,,|⊙;) ≠0/+↥⊃(<0|>4)+,, # If any index <0 or >4 already, it's illegal, otherwise check and return result after moving.
KeyPad ← ["00100" "02340" "56789" "0ABC0" "00D00"]   # The keypad.
⊡: KeyPad ≡⇌ Solve!Move Data 0_2 []                  # Same thing as part 1, start at [0 2] instead.
