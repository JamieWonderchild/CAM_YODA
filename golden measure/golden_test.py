def search(storage, x, index):
    a = (x >> 8) & 0xff#first 8 bits
    b = x & 0xff #last 8 bits
    if a==0:
        for i in range(index, len(storage)):
            if (storage[i]>> 8 & 0xff) == b or (storage[i]& 0xff)==b:
                return i
    else:
        for i in range(index, len(storage)):
            if storage[i] == x:
                return i

    return 0xffffffff
