import hashlib
from functools import cache

@cache
def md5(s):
    return hashlib.md5(s.encode('utf-8')).hexdigest()

def password(s):
    i, found = 0, 0
    pw = "________"
    while found < 8:
        h = md5(s + str(i))
        if h.startswith('0' * 5):
            pw = pw[:found] + h[5] + pw[found + 1:]
            found += 1
        i += 1
        print(pw, end="\r")
    print()

def password2(s):
    i, found = 0, 0
    pw = "________"
    while found < 8:
        h = md5(s + str(i))
        if h.startswith('0' * 5):
            pos = int(h[5], 16)
            if pos <= 7 and pw[pos] == '_':
                pw = pw[:pos] + h[6] + pw[pos + 1:]
                found += 1
        i += 1
        print(f"i = {i} | {pw}", end="\r")
    print()

password(my_input)
password2(my_input)
