import numpy as np
from collections import deque
from queue import PriorityQueue

# Read input.
grid = {(x, y): int(c) for y, line in enumerate(open("./input.txt").readlines()) for x, c in enumerate(line.strip())}
left, right, up, down = (-1, 0), (1, 0), (0, -1), (0, 1)

def calc_heat(cur, parents):
    path = []
    while cur:
        path.append((cur[0], cur[1]))
        cur = parents[cur]
    return path

def neighbors(x, y, dx, dy, min, max):
    nexts = []
    left, right = (x, y), (x, y)
    incur_left, incur_right = 0, 0
    for i in range(1, max + 1):
        left, right = tuple(np.add(left, (dy, -dx))), tuple(np.add(right, (-dy, dx)))
        if left in grid:
            incur_left += grid[left]
            if i >= min:
                nexts.append((*left, dy, -dx, incur_left, i + 1))
        if right in grid:
            incur_right += grid[right]
            if i >= min:
                nexts.append((*right, -dy, dx, incur_right, i + 1))
    return nexts

def min_search(openset, f_score):
    mn, mn_node = float('inf'), None
    for node in openset:
        if f_score.get(node, float('inf')) < mn:
            mn = f_score[node]
            mn_node = node
    openset.remove(mn_node)
    return mn_node

def min_heat(start, end, min, max):
    openset = PriorityQueue()
    openset.put((0, (*start, *left, 0)))
    openset.put((0, (*start, *up, 0)))

    parents = {(*start, *left, 0): None, (*start, *up, 0): None}
    f_score = {(*start, *left, 0): 0, (*start, *up, 0): 0}

    while openset.not_empty:
        x, y, dx, dy, st = openset.get()[1]
        if (x, y) == end:
            return f_score[(x, y, dx, dy, st)]

        for neighbor in neighbors(x, y, dx, dy, min, max):
            nx, ny, ndx, ndy, incur, nst = neighbor
            tent = f_score[x, y, dx, dy, st] + incur
            actual = f_score.get((nx, ny, ndx, ndy, nst), float('inf'))
            if tent < actual:
                parents[(nx, ny, ndx, ndy, nst)] = (x, y, dx, dy, st)
                f_score[nx, ny, ndx, ndy, nst] = tent
                openset.put((tent, (nx, ny, ndx, ndy, nst)))
    
    return -1

# Part one.
# Min step = 1, Max step = 3/
print(min_heat((0, 0), max(grid.keys()), 1, 3))

# Part two
# Min step = 4, Max step = 10
print(min_heat((0, 0), max(grid.keys()), 4, 10))
