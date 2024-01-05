import hashlib
from functools import cache

@cache
def md5(msg):
    return hashlib.md5(msg.encode()).hexdigest()

def find(key, num):
    return next(v for v in range(1000000000) if md5(key + str(v)).startswith("0" * num))

key = open("./day4.txt").readline().strip()
print(find(key, 5))
print(find(key, 6))
