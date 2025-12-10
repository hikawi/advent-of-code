# WARNING! This script is hella unoptimized.
# It's meant to give me some headstart into thinking how to implement it in Uiua.

import itertools
from math import prod


nodes = [
    tuple(int(n) for n in line.strip().split(",")) for line in open("8.txt").readlines()
]
connections = list(itertools.combinations(nodes, 2))
connections.sort(
    key=lambda c: (c[0][0] - c[1][0]) ** 2
    + (c[0][1] - c[1][1]) ** 2
    + (c[0][2] - c[1][2]) ** 2,
)


def find_graph(
    cur: tuple[int, ...],
    edges: dict[tuple[int, ...], set[tuple[int, ...]]],
    nodes: set[tuple[int, ...]],
):
    if cur in nodes:
        return

    nodes.add(cur)

    neighbors = edges[cur]
    for neighbor in neighbors:
        find_graph(neighbor, edges, nodes)


def solve_part_one():
    edges: dict[tuple[int, ...], set[tuple[int, ...]]] = {}
    for node in nodes:
        edges[node] = set()

    for a, b in connections[:1000]:
        edges[a].add(b)
        edges[b].add(a)

    visited: set[tuple[int, ...]] = set()
    sizes: list[int] = []
    for node in edges.keys():
        if node in visited:
            continue

        graph: set[tuple[int, ...]] = set()
        find_graph(node, edges, graph)
        sizes.append(len(graph))
        visited.update(graph)

    sizes.sort()
    print(prod(sizes[-3:]))


def solve_part_two():
    edges: dict[tuple[int, ...], set[tuple[int, ...]]] = {}
    for node in nodes:
        edges[node] = set()

    for a, b in connections:
        edges[a].add(b)
        edges[b].add(a)

        graph = set()
        find_graph(a, edges, graph)
        if len(edges) == len(graph):
            print(a[0] * b[0])
            break


solve_part_one()
solve_part_two()
