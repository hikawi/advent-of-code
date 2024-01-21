Read ← ⊙([0 ¯1] [[0 0]]) ⍉⊟≡(:⋕⊢⇌:⊢=@R⊢.) ≡↘1regex "(L|R)(\\d+)" &fras "day1.txt" # Parse the regex pattern, and append [0 ¯1] and [[0 0]] into the stack.
Turn ← (⊙⊙(×[1 ¯1]⇌)|⊙⊙(×[¯1 1]⇌))                                                # Function choice to turn left or right, for (x, y), turning left is (y, -x).
Move ← ⍥(⊙(⊂:):+,⊢⇌,):                                                            # Move and leave a histogram.
Solve ← ;;⍢(⊙Move ⊃⋅⊙∘∘ Turn∩⊢⊃∘⇌ ⊃(⊢|↘1)|≠0⧻)                                    # Move all, and remove intermediate values.

/+⌵⊢⇌ Solve Read                  # Part 1: Take last coord, abs, sum, is the distance.
/+⌵⊡+1⊢⊚>1≡(/+⌵/-)◫2⊝. Solve Read # Part 2: Find first non-unique in histogram, abs, sum, is the distance.
