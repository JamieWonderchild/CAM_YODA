#input is 16 bits from board which correspond to 2 8 bit ascci characters
#array of records (2 characters), take 16 bit, convert to 2 characters and get index of it in the array*/
from timeit import default_timer as timer
storage = [1,2,3,4,1, 654]
user_input = eval(input("What are you looking for:\n"))

def search(x, index):
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

def again(loc):
    if loc!= 0xffffffff:
        redo = eval(input("Would you like to search again?:\n"))
        #if they want to continue searching
        if redo == 1:
            start = timer()
            a = search(user_input, loc+1)
            end = timer()
            print("it is in location ", a)
            print("it took ", end-start,"s\n")
            again(a)
    else:
        print("done")

start = timer()
a = search(user_input, 0)
end = timer()
print("it is in location ", a)
print("it took ", end-start,"s\n")
again(a)
