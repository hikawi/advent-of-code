import itertools

vertices = [
    tuple(map(int, line.strip().split(","))) for line in open("9.txt").readlines()
]


def intersects(a: tuple[int, int], b: tuple[int, int]) -> bool:
    omin = (min(a[0], b[0]), min(a[1], b[1]))
    omax = (max(a[0], b[0]), max(a[1], b[1]))

    n = len(vertices)
    for i in range(n):
        ia = vertices[i]
        ib = vertices[(i + 1) % n]

        imin = (min(ia[0], ib[0]), min(ia[1], ib[1]))
        imax = (max(ia[0], ib[0]), max(ia[1], ib[1]))

        if (
            omin[0] < imax[0]
            and omax[0] > imin[0]
            and omin[1] < imax[1]
            and omax[1] > imin[1]
        ):
            return True

    return False


area = 0
for ra, rb in itertools.combinations(vertices, 2):
    if (abs(ra[0] - rb[0]) + abs(ra[1] - rb[1])) ** 2 < area:
        continue

    if not intersects(ra, rb):
        omin = (min(ra[0], rb[0]), min(ra[1], rb[1]))
        omax = (max(ra[0], rb[0]), max(ra[1], rb[1]))
        area = max(area, (omax[0] - omin[0] + 1) * (omax[1] - omin[1] + 1))

print(area)
