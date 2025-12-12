import numpy as np
from scipy.optimize import milp, LinearConstraint, Bounds

data = [line.split() for line in open("10.txt").readlines()]

total = 0

# Each problem is essentially
# a(v1) + b(v2) + c(v3) + ... = B
# Each vector can be represented as a bit vector.
# It's linear algebra I guess.
for problem in data:
    B = np.array(list(map(int, problem[-1][1:-1].split(","))))
    vectors: list[np.ndarray] = []
    for comp in problem[1:-1]:
        row = np.zeros_like(B)
        indices = [int(i) for i in comp[1:-1].split(",")]
        row[indices] = 1
        vectors.append(row)

    V = np.vstack(vectors).T

    # 5. Execute the solver
    res = milp(
        c=np.ones(V.shape[1]),
        constraints=LinearConstraint(A=V, lb=B, ub=B),
        bounds=Bounds(0, np.inf),
        integrality=np.ones(V.shape[1]),
    )
    total += int(res.fun)

print(total)
