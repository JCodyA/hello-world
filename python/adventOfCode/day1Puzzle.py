#brute force approace, but the list is small. 

#open text file named input in same dir, process raw strings into list of ints

file = open(r"input", "r")
rawnumlist = file.readlines()
numlist = []
for line in rawnumlist:
    numlist.append(int(line.split("\n")[0]))

#check sums of three elements and find the set that
#adds to 2020.  also print the product for the answer submission


for x in numlist:
    for y in numlist:
        for z in numlist:
            if (x+y+z)==2020:
                print("x is %d and y is %d and z is %d"%(x,y,z))
                print("xyz is %d"%(x*y*z))
                break #break out of nested loops so avoid extra work
        else:
            continue
        break
    else:
        continue
    break
