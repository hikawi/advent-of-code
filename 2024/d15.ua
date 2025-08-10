# Experimental!

# Split the input into a grid section and the instructions section
⊓◇(⊜∘⊸≠@\n)◇(/◇⊂⊜□⊸≠@\n) °⊟ ⊜□¬⊸⦷"\n\n" &fras "d15.txt"
Grid         ←
Instructions ←
ExpandedGrid ← ≡/⊂ ≡₀(/⊂≡(˜⊡["##" "@." ".." "[]"] ˜⊗ "#@.O")) Grid

# Retrieves the direction from chars <>^v
# dir ? char
GetDirection ← ˜⊡[0_¯1 0_1 ¯1_0 1_0] ˜⊗"<>^v"

# Finds the robot in the grid provided
# robotcoord ? grid
FindRobot ← ⊢⊚=@@

# Checks if the provided coord is still in bounds of the provided grid.
# isinbounds ? coord
InBounds ← /↧↧⊓<≥ ⊙⊙0_0△Grid⊸∘

# Checks if the provided coord is still in bounds of the expanded grid.
# isinbounds ? coord
InBoundsExpanded ← /↧↧⊓<≥ ⊙⊙0_0△ExpandedGrid⊸∘

# Calculate the score of the final grid.
# 
# score ? grid
Score ← /+≡/+×[100_1] ⊚(↥↥ ⊃(=@O|=@[|=@]))

# --------------------------------------
# PART ONE
# --------------------------------------

# Generates the next steps for the robot given the parameters
# steps ? instr grid
GenStepsOne! ← ⇌⋅⊙◌ ⍢(⊙⊂⟜+⊙⊸⊢|^0+⊙⊢) ⊙¤ ⊙⊸FindRobot GetDirection

# Checks if with the instruction and the grid provided, can the robot move?
# It checks by checking if in that direction, does a @. appear before a @#
# canmove ? instr grid
CanMoveOne! ← <∩(⍣⊢∞⊚) ⊃(=@#|=@.) ↘1⊡⊸GenStepsOne!^0

# Moves the robot one step in part 1.
# newgrid ? instr grid
MoveOne ← (
  :⊙::⊙(⟜+⊓GetDirection(⊸FindRobot)) ◡GenStepsOne!InBounds
  ⊙(⊙⍜⊡(˜▽@.¤⧻) +⊙.¤) ⊙⊙(⊏▽⊸=⇡⊸⧻⊚=@O ∩↘₁◡⊡)
  ⍜⊡(@@◌) ⊙(⍜⊡(@.◌) ⊸FindRobot) ⊙⍜⊡(˜▽@O¤⧻)
)

# Solve for part one
# Score ◌⍢(⊙(⨬(◌|MoveOne) ◡CanMoveOne!InBounds) ⊃↘↙1|>0⧻) Instructions Grid

# --------------------------------------
# PART TWO
# --------------------------------------

# Checks if the algorithm can stop tracing for spaces.
# It stops when every space looked at is a free space or one
# of them is a #.
# canstop ? string
CanStopLooking ← ↥⊃(↧⊃(≍⊸↻1|=@.⊢)|˜∊@#)

# Finds the box associated with the provided coord.
# If it can't be found, it returns an empty set.
# boxes ? box grid
FindBoxes ← ⨬(⊟⤙+0_1|⊟⤙+0_¯1|↯0_2[]◌) ˜⊗"[]"⤚⊡

# Checks if the robot can move vertically?
# It can only move if all of the boxes can be pushed.
# canmove ? instruction grid
CanMoveTwoVertically ← CanStopLooking⊡+¤ ⍢(⊙(◴⊓♭₂°¤ ⊸≡FindBoxes ⊙¤) ⍜¤⟜≡+|¬CanStopLooking⊡≡+¤) ⊓(GetDirection|¤⊸FindRobot)

# Checks if with the instriuction, can the robot move?
# There are two special cases for the thing, horizontally same as part one, but vertically different.
# canmove ? instruction grid
CanMoveTwo ← ⨬(CanMoveTwoVertically|CanMoveOne!InBoundsExpanded) ≠0⊣⊸GetDirection

# Moves the robot horizontally.
# newgrid ? instruction grid
MoveTwoHori ← (
  ⊙⊙(▽↥⊃(=@[|=@]) ◡⊡) ⊙: ⊸⊃(⊃⊢↘₁ GenStepsOne!InBoundsExpanded|GetDirection)
  ⨬(⊙⊙(⍜⊡↻₋₁) ⊙(⊙˜⊂⟜+⊙⊸⊣)|⊙⊙◌) :⊙(:⊙(=0⊸⧻))
  ⍜⊡(@@◌)+ ⊙⟜⍜⊡(@.◌):
)

# Moves the robot vertically.
# newgrid ? instruction grid
MoveTwoVert ← (
  :⊙: ⊙⊙(=@.⊸⊡) ⍜:⊙⟜+ ⊓GetDirection(⊸¤⊸FindRobot)
  ⨬(⍢(:⊙⊸⊂: ⊙(⊙(◴⊓♭₂°¤ ⊸≡FindBoxes ⊙¤) ⍜¤⟜≡+)|¬CanStopLooking⊡≡+¤◌) []
    ⊙⟜⍜⊡(˜▽@.⧻) :⊙⊙◌
    ⍜⊡(@@◌)+ ⊙(⟜⍜⊡(@.◌) ⊸FindRobot ⍜⊡(˜▽"[]"÷2⧻) ≡+)⟜¤
  | ⍜⊡(@@◌)+ ⊙(⟜⍜⊡(@.◌)) ⊙°¤)
)

# Moves the robot.
# newgrid ? instruction grid
MoveTwo ← ⨬(MoveTwoHori|MoveTwoVert) ≠0⊢⊸GetDirection

⍢(⊙(⨬(◌|MoveTwo) ◡CanMoveTwo) ⊃↘₁⊢|>0⧻) Instructions ExpandedGrid
