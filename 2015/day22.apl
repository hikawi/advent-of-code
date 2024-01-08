cost ← 53 73 113 173 229

apply ← {
    (turn hp def mana bosshp bossdmg) effects ← ⍵
    hp ← {hardmode∧⍵=0:hp-1 ⋄ hp}turn     ⍝ Reduce health if hardmode
    def ← {⍵>0:7 ⋄ 0}⊃effects             ⍝ Apply shield
    bosshp ← bosshp{⍵>0:⍺-3 ⋄ ⍺}2⊃effects ⍝ Apply poison
    mana ← mana{⍵>0:⍺+101 ⋄ ⍺}3⊃effects   ⍝ Apply recharge
    (turn hp def mana bosshp bossdmg)(0 0 0⌈1-⍨effects)
}

bossmove ← {
    ⍺ ← ⍬
    (turn hp def mana bosshp bossdmg) effects ← ⍵

    ⍝ If still alive, deal damage. If not,... welp.
    bosshp>0:(0 (hp-1⌈bossdmg-def) def mana bosshp bossdmg)effects
    (0 hp def mana bosshp bossdmg)effects
}

cast ← { ⍝ ⍺: move, ⍵: (game state)(effects), returns: same as ⍵
    (turn hp def mana bosshp bossdmg)(shield poison recharge) ← ⍵
    mana -← ⍺⊃cost
    ⍺=1:(1 hp def mana (bosshp-4) bossdmg)(shield poison recharge)     ⍝ Activate Missile
    ⍺=2:(1 (hp+2) def mana (bosshp-2) bossdmg)(shield poison recharge) ⍝ Activate Drain
    ⍺=3:(1 hp def mana bosshp bossdmg)(6 poison recharge)              ⍝ Activate Shield
    ⍺=4:(1 hp def mana bosshp bossdmg)(shield 6 recharge)              ⍝ Activate Poison
    (1 hp def mana bosshp bossdmg)(shield poison 5)                    ⍝ Activate Recharge
}

run ← {
    ⍝ ⍺: spells used
    ⍝ ⍵: (turn hp def mana bosshp bossdmg)(shield poison recharge)
    ⍺ ← ⍬
    min<+/cost[⍺]:⍬ ⍝ Short circuit if too high cost already.

    state effects ← apply ⍵
    0≥2⊃state:⍬ ⍝ No hp. RIP.
    0≥5⊃state:⍎'min⌊←+/cost[⍺]' ⍝ Boss dead, update min, use "Execute" since min is on global scope.

    choices ← (⍳5)/⍨(cost≤4⊃state)∧1 1,0=effects ⍝ Possible moves.
    0=≢choices:⍬ ⍝ Don't have any moves left, run dead.

    ⍝ Turn 0 = Player, Turn 1: Boss.
    ⊃state: ⍺∇bossmove state effects
    ⍺∘{(∊⍺,⍵)run ⍵ cast state effects}¨choices
}

⍝ Part 1. Finding minimum mana cost to defeat boss. Substitute bossHp and bossDamage with your own.
min hardmode ← 1E28 0
min⊣run(0 50 0 500 bossHp bossDamage)(0 0 0)

⍝ Part 2. Same thing. But each player's turn now takes 1 hp from you.
min hardmode ← 1E28 1
min⊣run(0 50 0 500 bossHp bossDamage)(0 0 0)
