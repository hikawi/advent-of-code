import numpy as np
from queue import Queue

grid = [line.strip() for line in open("input.txt").readlines()]
start = [(x, y) for y in range(len(grid)) for x in range(len(grid[0])) if grid[y][x] == "S"][0]
dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)]

def can_step(tup):
    x, y = tup
    return x >= 0 and x < len(grid[0]) and y >= 0 and y < len(grid) and grid[y][x] != '#'

def bfs_in_region():
    open_set = Queue()
    open_set.put_nowait((*start, 0))
    score = {}
    while not open_set.empty():
        x, y, depth = open_set.get_nowait()
        if (x, y) in score:
            continue
        score[x, y] = depth
        for dx, dy in dirs:
            if can_step((x + dx, y + dy)) and (x + dx, y + dy) not in score:
                open_set.put_nowait((x + dx, y + dy, depth + 1))
    return score

# Part 1. Each step moves one space.
# After some number of steps (64), how many spaces are reachable?
def solve_part_one():
    print(sum([1 for x in bfs_in_region().values() if x <= 64 and x % 2 == 0]))

# Part 2.
# The map is infinitely repeating.
# After some number of steps (26501365), how many spaces are reachable?
def solve_part_two():
    # https://github.com/villuna/aoc23/wiki/A-Geometric-solution-to-advent-of-code-2023,-day-21
    # The dude here has diagrams that I wanted to steal.

    # The actual input has a special property, is that the straight lines out of start are all open, no rocks.
    # So it takes a minimum 65 steps to get out of the start REGION.
    # The map is 131x131. So, excluding the start region, (26501365 - 65) / 131 = 202300 exactly.
    # But the map's length is odd, so every time we switch region, we flip parity.

    parity = bfs_in_region()
    odds, evens = sum([1 for x in parity.values() if x % 2 == 1]), sum([1 for x in parity.values() if x % 2 == 0])

    squares = (26501365 - 65) // 131 # The number of squares.
    even_corners = sum([1 for x in parity.values() if x > 65 and x % 2 == 0]) # The corners that have to be added in.
    odd_corners = sum([1 for x in parity.values() if x > 65 and x % 2 == 1]) # The corners that have to be taken out.

    # For n = 0, 1 odd, 0 even.
    # For n = 1, 1 odd, 4 even.
    # For n = 2, 9 odd, 4 even.
    # For n = 3, 9 odd, 16 even.
    # For n = 4, 25 odd, 16 even.
    # For n = 5, 25 odd, 36 even.
    # Our n is 202300.
    even_squares, odd_squares = squares ** 2, (squares + 1) ** 2

    # So the answer would be the sum of:
    # The number of even squares * even tiles in one square,
    # The number of odd squares * odd tiles in one square,
    # The number of squares * even corners assembled in a square (4 corners make 1 square), there are 4n corners so n "even cornered squares",
    # Minus the number of odd corners assembled in a square (4 corners make 1 square), there are 4n + 4 corners so n + 1 "odd cornered squares".
    print(even_squares * evens + odd_squares * odds + squares * even_corners - (squares + 1) * odd_corners)

solve_part_one()
solve_part_two()
