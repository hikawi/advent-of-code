from queue import Queue
from dataclasses import dataclass
import re
import math

# Maps of all modules.
modules = {}

@dataclass
class Signal:
    who: str
    whom: str
    val: int

@dataclass
class FlipFlop:
    name: str
    des: list[str]
    state: int

    def activate(self, queue: Queue[Signal], signal: Signal):
        if signal.val == 1:
            return
        self.state = not self.state
        for res in self.des:
            queue.put(Signal(self.name, res, int(self.state)))

@dataclass
class Conjunction:
    name: str
    des: list[str]
    state: dict[str, int]

    def activate(self, queue: Queue[Signal], signal: Signal):
        self.state[signal.who] = signal.val
        pulse = all(self.state.values())
        for res in self.des:
            queue.put(Signal(self.name, res, int(not pulse)))

@dataclass
class Broadcaster:
    name: str
    des: list[str]

    def activate(self, queue: Queue[Signal], signal: Signal):
        for res in self.des:
            queue.put(Signal(self.name, res, signal.val))

# Read all data first.
data = open("./input.txt").readlines()

# Set up the stuff.
def set_board():
    modules.clear()
    for line in data:
        name, des = re.search("(.+) -> (.+)", line).groups()
        if name.startswith("%"):
            modules[name[1:]] = FlipFlop(name[1:], des.split(", "), 0)
        elif name.startswith("&"):
            modules[name[1:]] = Conjunction(name[1:], des.split(", "), {})
        else:
            modules[name] = Broadcaster(name, des.split(", "))
    modules["rx"] = Broadcaster("rx", [])

# Build all inputs for the conjunctions.
def build_conjunctions():
    for name, module in modules.items():
        for res in module.des:
            if modules.get(res, None) is not None and isinstance(modules[res], Conjunction):
                modules[res].state[name] = 0

# Part 1: Low pulse into broadcaster 1000 times. Count how many times low and high signals are emitted.
# Push the button once.
def push_button():
    signals = Queue[Signal]()
    signals.put(Signal("any", "broadcaster", 0))
    low, high = 0, 0
    while not signals.empty():
        signal = signals.get()
        if signal.val == 1:
            high += 1
        else:
            low += 1
        modules[signal.whom].activate(signals, signal)
    return low, high

def solve_part_one():
    set_board()
    build_conjunctions()
    low, high = 0, 0
    for _ in range(1000):
        dlow, dhigh = push_button()
        low += dlow
        high += dhigh
    print(low * high)

# Part two. How many button presses for `rx` to receive a low pulse?
def track(mod) -> list[str]:
    if not isinstance(mod, str):
        mod = mod.name

    cur = []
    for module in modules.values():
        if mod in module.des:
            cur.append(module)
    return cur

def solve_part_two():
    # A single conjunction leads to "rx". For "rx" to receive 0, that conjunction (for me, it's "gf") must have all 1s.
    # "gf" would be called L1 conjunction here.
    # There are 4 other conjunctions (let's call this L2 Conjunctions) that lead to "gf".
    # These L2 conjunctions only have 1 input, which are the L3 conjunctions.
    # These L3 needs to send 0 to L2 conjunctions (so L2 sends 1 to "gf", then "gf" sends 0 to "rx").
    # These L3 conjunctions have a lot of inputs, which must be all 1 for L3 to send a 0.

    l1 = track("rx")[0]                    # There's only one L1.
    l2 = track(l1)                         # There are 4 L2s here.
    l3 = [track(conj)[0] for conj in l2]   # There should also be 4 L3s.
    cycles = {conj.name:-1 for conj in l3} # The cycles for L3s.
    
    # Set up the board.
    set_board()
    build_conjunctions()

    # Simulate button presses.
    for i in range(1, 1000000000000000):
        # If we have found a cycle for all l3s, we're done.
        if all([cycle > 0 for cycle in cycles.values()]):
            break

        signals = Queue[Signal]()
        signals.put(Signal("any", "broadcaster", 0)) # Push!
        while not signals.empty():
            next = signals.get()
            # If the signal is 0, the one emitting the signal is a L3, and we haven't found a cycle for it yet, log it in.
            if next.who in cycles and next.val == 0 and cycles[next.who] == -1:
                cycles[next.who] = i
            modules[next.whom].activate(signals, next)
        
    # L3 conjunctions have a state map. Each state map from each L3 is completely independent from each other.
    # This is the input's special property. The LCM or just the product of all cycles is the answer (they're all primes).
    print(math.lcm(*cycles.values()))

solve_part_one()
solve_part_two()
