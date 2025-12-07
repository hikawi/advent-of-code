from functools import cache

grid = {
    (x, y): c
    for y, line in enumerate(open("7.txt").readlines())
    for x, c in enumerate(line)
}

dims = (max(x for x, _ in grid.keys()), max(y for _, y in grid.keys()))


@cache
def time_travel(cur: tuple[int, int]) -> int:
    x, y = cur
    if x < 0 or x >= dims[0]:
        return 0
    if y >= dims[1]:
        return 1

    if grid[cur] == "^":
        return time_travel((x - 1, y)) + time_travel((x + 1, y))

    return time_travel((x, y + 1))


start = next(tup for tup, c in grid.items() if c == "S")
print(time_travel(start))
