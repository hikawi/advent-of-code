from functools import cache
import time
import typing
import numpy as np
import numpy.typing as npt

data = [[c for c in line.splitlines()] for line in open("12.txt").read().split("\n\n")]
shapes = {
    a: np.array([np.array([c == "#" for c in line]) for line in b]).T
    for a, b in map(lambda list: (int(list[0][:-1]), list[1:]), data[:-1])
}
regions = [
    (tuple(map(int, a.split("x"))), list(map(int, b.split())))
    for line in data[-1]
    for a, b in [line.split(": ")]
]


def print_grid(grid: npt.NDArray[np.bool_]):
    print("\n".join("".join("#" if c else "." for c in row) for row in grid))


def dfs(grid: npt.NDArray[np.bool_], pieces: list[npt.NDArray[np.bool_]]) -> bool:
    openset = [(grid, pieces)]

    while len(openset) > 0:
        cur_grid, cur_pieces = openset.pop()

    return False


cache: dict[typing.Any, bool] = {}


def hash_ndarray(arr: npt.NDArray[np.bool_]):
    return (arr.shape, arr.tobytes())


def can_place(grid: npt.NDArray[np.bool_], pieces: list[npt.NDArray[np.bool_]]) -> bool:
    key = (hash_ndarray(grid), tuple(map(hash_ndarray, pieces)))
    if key in cache:
        return cache[key]

    if np.size(pieces) == 0:
        cache[key] = True
        return True
    if np.sum(1 - grid) < sum(np.sum(p) for p in pieces):
        cache[key] = False
        return False

    piece = pieces[0]
    oris = [np.rot90(piece, k=i) for i in range(4)]

    for spot in np.argwhere(1 - grid):
        try:
            for ori in oris:
                rows, cols = zip(*np.argwhere(ori) + spot)
                if np.any(grid[rows, cols]):
                    continue
                if len(pieces) == 1:
                    cache[key] = True
                    return True

                copy = np.copy(grid)
                copy[rows, cols] = True

                if can_place(copy, pieces[1:]):
                    cache[key] = True
                    return True
        except IndexError:
            continue  # Can't put anywhere if out of bounds.

    return False


count = 0
epoch = time.time()
for i, (dim, indices) in enumerate(regions):
    print(
        f"epoch {time.time() - epoch}: checking region {i}/{len(regions)} ({i / len(regions) * 100}%)"
    )

    pieces = []
    for index, amount in enumerate(indices):
        for _ in range(amount):
            pieces.append(shapes[index])

    if can_place(np.zeros(shape=dim, dtype=np.bool_), pieces):
        count += 1
print(count)
