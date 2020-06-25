import golden_test
import random
from timeit import default_timer as timer

times = []
times_not_found = []

storage = []
for k in range(0, 5000):
    storage.append(random.randint(0, 65535))
#print("storage\n")

for i in range(0, 10000):
    #print(i, " loop\n")
    done = False
    ind = 0
    find = random.randint(0, 65535)
    while done == False:
        #print("while ", ind,"\n")
        #here is the problem
        start = timer()
        ind = golden_test.search(storage, find, ind+1)
        end = timer()
        if ind!= 0xffffffff:
            times.append(end-start)
            times_not_found.append(end-start)
        else:
            times_not_found.append(end-start)
            done = True
print("The average time for when the varible was found is ", (sum(times)/len(times))*1000, "milliseconds")
print("The average time for when the varible was or wasn't found is ", (sum(times_not_found)/len(times_not_found))*1000, "milliseconds")
