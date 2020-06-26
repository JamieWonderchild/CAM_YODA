import random
from timeit import default_timer as timer

def search(table, x, index):
    a = (x >> 8) & 0xff#this turns a into the first 8 bits of the input
    b = x & 0xff #this turns b into the last 8 bits of the input
    if a==0: #i.e if it is only an 8 bit input
        for i in range(index, len(table)):
            if (table[i]>> 8 & 0xff) == b or (table[i]& 0xff)==b:
            #check if the 8 bit number is either of the 2 8 bit(16 bit) elements stored in the table
                return i #return the location in the table
    else:
        for i in range(index, len(table)):
            if table[i] == x:#check if the 16 bit input matches the element in the table
                return i #return the location in the table

    return 0xffffffff #return 0xffffffff if the input is not found
table_size = [100,200,500,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000]
#This is the table size that is being generated
times_found = []
for l in table_size:
    table = []
    for k in range(0, l):#generate 5000 random 16 bit equivalent elements for the table
        table.append(random.randint(0, 65535))
    for i in range(0, 10000):
        done = False
        ind = 0
        find = random.randint(0, 65535)
        while done == False:#keep looping until the whole array has been searched
            start = timer()
            ind = search(table, find, ind)#run a search for the string
            end = timer()
            if ind == 0xffffffff: done = True
            times_found.append(end-start)
            ind +=1

    print(l, " ", (sum(times_found)/len(times_found))*1000000)
