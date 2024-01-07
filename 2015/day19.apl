⍝ The usual reading data. repl holds an array of replacements, atom the molecule.
repl←{','(≠⊆⊢)⊃'(.+) => (.+)'⎕S'\1,\2'⊢⍵}¨repl⊣atom←⊃atom⊣repl atom ← data⊆⍨(0<≢)¨data←⊃⎕NGET'day19.txt'1

⍝ Part 1. Brute-force should be enough
⍝ Simple replace all for all replacements, remove all blank strings, then take unique and count.
replace ← {o v r←⍺ ⋄ ∊(o↑⍵),r,(≢v)↓o↓⍵}
≢result/⍨((1↑'  ')≢∪)¨result←∪,(¯3↓repl){v r←⊃⍺ ⋄ ⍵∘{⍵ v r replace ⍺}¨1-⍨⍸v⍷⍵}⍤0 1⊢atom

⍝ Part 2.
⍝ I read on Reddit, some madman noticed (u/askalski) that the number of steps is count(elements) - count(Rn || Ar) - 2*count(Y) - 1.
⍝ There are so many smart people around man, what. (https://www.reddit.com/r/adventofcode/comments/3xflz8/day_19_solutions/)
⍝ The gist:
⍝ - Only 2 types of "productions": A => BC where neither B nor C is "Rn" or "Y" or "Ar", as these three are "dead elements".
⍝   Replacing backwards for this type of production will reduce the number of elements by 1.
⍝ - The second way of production is A => B,Rn,C,Ar OR A => B,Rn,C,Y,C,Ar OR A => B,Rn,C,Y,C,Y,C,Ar.
⍝   Replacing backwards for this type of production will reduce the number of elements by 3, 5, or 7.
⍝ - If we replace with the 1st type, which will take count(elems) - 1 steps.
⍝ - If we replace with the 2nd type, which will take count(elems) - count(Rn || Ar) - 2*count(Y) - 1 steps.
elem ← '[[:upper:]][[:lower:]]?'⎕S'&'⊢atom
1-⍨(2×≢⍸'Y'=atom)-⍨(≢elem)-+/{≢⍸elem⍷⍨⊂⍵}¨'Rn' 'Ar'
