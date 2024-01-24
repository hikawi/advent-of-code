Data ← ⊜□≠@\n. &fras"day7.txt"
Partition ← ∩▽¬,, ↯:0_1[⧻]. ⊜□↧⊃(≠@[|≠@]).°□ # Function to partition an IP into an in-bracket and out-bracket parts
GetABA ← ([];|▽≡(↧≠⊃(⊢|⊡1):≍⇌..) .◫) ≥,⧻,    # Retrieve all ABA or ABBA sequences from an IP

/+≡(↧=0:>0 ∩(/+≡(⧻GetABA 4 °□)) Partition) Data # Part 1: Partition, get and count ABBAs, sum. In-brackets count must be 0 and out-brackets count must be > 0.

Flip ← [⊃(⊡1|⊢|⊡1)]                                                    # Function to flip an ABA to a BAB
/+≡(>0/+♭⊞≍ ⊙≡□ ≡(□Flip) ∩(°□/(□⊂∩°□) ≡(□GetABA 3 °□)) Partition) Data # Part 2: Partition, get ABAs, join into a list of ABAs found out-brackets. Flip all, and match against ABAs found in-brackets. Sum > 0 -> Good.
