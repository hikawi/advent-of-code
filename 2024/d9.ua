Data ← ⍜▽÷₂ ¬⟜⍜▽(¯1◌) ⊸◿2 ▽:⇡⊸⧻ ≡⋕↘¯1 &fras "d9.txt"

# The array is done moving if empty blocks are only at the rightside. (-1)
# So we split into two arrays, one equal -1 and one not, join and compare with the original input.
# IsDone ? Array
DoneMoving ← ≍⊸(⊂⊃(▽¬)▽ ⊸<0)

# Do one move operation. Take the first -1, and swap with the last non-negative number.
# StepArray ? Array
MoveOne ← ⍜⊏⇌ ⊟⊸⊃(⊢⊚=¯1|⊣⊚≥0)

# Find destinations and check if the move should be possible.
# A move is good if the destination is to the left of the source, and have enough capacity to store.
# CanMove Source Destination Data ? FileID Data
CanMoveFile ← ⨬(0|/↧◡<) :⟜(>0⊸⧻ ⊚=1⊸⦷↯:¯1⧻) ⊚⊸=

# Attempt to do one full move operation. It tries to move the entire file with that ID
# forward, if it can't find any leftmost spot to fit, it will not move.
# MovedArray ? FileId Array
MoveFile ← ⨬(◌◌|⍜⊏(♭⇌↯2_∞) ⊂) CanMoveFile

# Part 1. Move each singular block and calculate the checksum.
/+×⇡⊸⧻ ▽⊸≥0 ⍢(MoveOne|¬DoneMoving) Data

# Part 2. Move file blocks and calculate the checksum.
/+×⇡⊸⧻↥0 ◌⍢(-1 ⟜MoveFile|≥0) ⊸/↥Data
