Data ← ⊜□≠@\n. &fras "day8.txt"

# Function to check for commands. Operation is simple.
# If len str < len prefix: 0. If not, take first len(prefix) of str and match.
StartsWith ← (≍⊙↙ :⧻.|0;;) <∩⧻,,

Rect ← ⍜(⊡|↯:"#"[⧻]) ≡⇌☇1⇡⊜⋕≠@x.↘5                        # Function to generate a rectangle, and apply it to the screen.
RotateRow ← ⍜(⊡|↻¯:) ⊙:°⊟ ≡⋕↘1⊢regex "y=(.+) by (.+)"     # Rotate a row by a given amount.
RotateCol ← ⍉⍜(⊡|↻¯:) ⊙⍉ ⊙:°⊟ ≡⋕↘1⊢regex "x=(.+) by (.+)" # Rotate a column (by rotating a row in a transposed screen) by a given amount.

:⬚@.↯6_50 @. Data # The screen. 6 rows, 50 columns.
⍢(⊙((Rect|RotateRow|RotateCol) ⊢⊚[⊃(StartsWith "rect"|StartsWith "rotate row"|StartsWith "rotate column")].) ⊃(↘1|°□⊢)|≠0⧻)

# Part 1. Flatten, count #s.
# Part 2. Just display the screen.
⊃(∘|/+=@#♭);
