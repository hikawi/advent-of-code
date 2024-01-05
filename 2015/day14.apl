data ← ⊃⎕NGET'day14.txt'1

⍝ Parse each line into a line in a matrix, with columns: "name", "speed", "duration", "rest"
grid ← ↑','∘(≠⊆⊢)¨'(.+) can fly (\d+) km/s for (\d+) seconds, .+ (\d+) seconds.'⎕S'\1,\2,\3,\4'⊢data

⍝ Calculate how much distance in some time t a reindeer can travel
distance ← {v t r s←⍵ ⋄ ⍺←0 ⋄ s≤t:⍺+v×0⌈s⌊t ⋄ (⍺+v×t)∇(v,t,r,r-⍨s-t)}

⍝ Part 1. Take each reindeer, calculate, then max of.
⌈/distance⍤1⊢2503,⍨⍎¨grid[;2 3 4]

⍝ Simulate an elapsed second.
⍝ v = speed, s = travel time, r = rest time
⍝ st = state (0 = resting, 1 = travelling), dist = distance travelled, t = time left in current state, p = points
elapse ← {v s r st dist t p←⍵ ⋄ (~st)∧t=0:v s r 1 (dist+v) (s-1) p ⋄ st∧t=0:v s r 0 dist (r-1) p ⋄ st:v s r st (dist+v) (t-1) p ⋄ v s r st dist (t-1) p}

⍝ Find max of points, then find reindeers with that many points, add one to its point.
point ← {mx←⌈/⍵[;5] ⋄ v←⍸mx=⍵[;5] ⋄ a←⍵ ⋄ a⊣a[v;7]+←1}

⍝ Race is doing an elapse on each reindeer, then adding a point to all reindeers with max distance.
race ← {point⊢elapse⍤1⊢⍵}

⍝ Part 2. Racing 2503 times.
⌈/7⌷[2]race⍣2503⊢0,⍨⍣4⊢⍎¨grid[;2 3 4]
