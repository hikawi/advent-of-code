# Experimental!

⊓(⊜□¬⊸⦷", "|⊜□⊸≠@\n) ∩°□ °⊟ ⊜□¬⊸⦷"\n\n" &fras "d19.txt"
Patterns ←
Designs  ←

# Takes one design and cuts it with patterns if matched
# NewPatterns ? Pattern
CutPattern ← memo(≡(□↘⧻∩°□) ▽◡≡(=1⊢◇⦷) Patterns¤)

# Takes one design to check recursively if it can be built.
# CanBuild ? Design
CanBuild ← |1 memo(⨬(⨬(0◌|/↥≡CanBuild) >0⊸⧻ CutPattern|1◌) ↥⊸⊃(∊Patterns|=0◇⧻))

# Part 1. How many designs can be built.
/+≡CanBuild Designs

# Takes one design and check recursively how many times it can be built
CountBuilds ← |1 memo(⨬(⨬(0◌|/+≡CountBuilds)>0⊸⧻ CutPattern|1 ◌) =0⊸◇⧻)

# Part 2. Exactly how many ways a design can be built?
/+≡CountBuilds Designs
