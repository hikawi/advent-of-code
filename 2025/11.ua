Data ← map ⊙(⍚(⊜□⊸≠@ )) °⊟⍉ ⊜(⊜□⊸≠@:) ⊸≠@\n &fras "11.txt"

PathfindOut ← |1 memo(⨬(⍣(/+≡PathfindOut °□ get:Data)0|⋅1) ⊸=□"out")
PathfindDac ← |1 memo(⍣(⨬(/+≡PathfindDac °□ get:Data|⋅1))0 ⊸=□"dac")
PathfindFft ← |1 memo(⍣(⨬(/+≡PathfindFft °□ get:Data|⋅1))0 ⊸=□"fft")

# Part 1. Just find the number of paths from you -> out
$PartOne PathfindOut□"you"

# Part 2. Find the number of paths running from svr -> (dac, fft) -> out
# This sucks so bad lmao. I just find each like from svr -> dac, dac -> fft, fft -> out and then multiply together
$PartTwo +∩/× ⊃[PathfindDac□"svr" PathfindFft□"dac" PathfindOut□"fft"][PathfindDac□"fft" PathfindFft□"svr" PathfindOut□"dac"]
