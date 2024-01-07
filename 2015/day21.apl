⍝ The data.
⍝ Do boss ← bossHp bossDamage bossArmor with your own input.
weapons ← ↑(8 4 0)(10 5 0)(25 6 0)(40 7 0)(74 8 0)
armor ← ↑(0 0 0)(13 0 1)(31 0 2)(53 0 3)(75 0 4)(102 0 5)
rings ← ↑(0 0 0)(25 1 0)(50 2 0)(100 3 0)(20 0 1)(40 0 2)(80 0 3)

⍝ "Ext"ract the stats from the data. If left arg is 1, the extracted is the cost.
⍝ Otherwise, it's the stats, damage-armor.
ext ← {⍺←1 ⋄ w a r1 r2←⍵ ⋄ weapons[w;⍺]+armor[a;⍺]++⌿rings[r1 r2;⍺] ⋄ 0}

⍝ Function to check if the player wins. Left argument is playerHp playerDamage playerArmor, right is bossHp bossDamage bossArmor.
⍝ The player wins when the number of turns the player survives >= the number of turns the boss survives.
win ← {ph pd pa bh bd ba←∊⍺ ⍵ ⋄ pt←⌈ph÷1⌈bd-pa ⋄ bt←⌈bh÷1⌈pd-ba ⋄ pt≥bt}

⍝ Part 1. Least cost to win.
⍝ Simulate all choices, check which ones win, take cost, take min of.
⌊/ext¨t/⍨win∘boss¨(100,2 3∘ext)¨t←⊃,/{,∘⍵¨,⍳5 6}¨(⊂1 1),t/⍨(⊃<(⊃⌽))¨t←,⍳7 7

⍝ Part 2. Most cost to lose.
⍝ Simulate all choices, check which ones lose, take cost, take max of.
⌈/ext¨t/⍨~win∘boss¨(100,2 3∘ext)¨t←⊃,/{,∘⍵¨,⍳5 6}¨(⊂1 1),t/⍨(⊃<(⊃⌽))¨t←,⍳7 7
