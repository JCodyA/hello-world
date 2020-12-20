#advent of code day 2 2020
#check passwords that match their policies from file
#ie:  1-3 a: adcde, matchs its policy because it has
#1 - 3 "a" chars in pass.  1-3 b: cded does not, no "b" chars
#debugging lines in triple quotes """

#open data file and process data into usable list

file = open(r"passList", "r")
rawData = file.readlines()
passlist = []
numGoodPass = 0
for line in rawData:
    passlist.append(line.split("\n")[0])

#perform checks to see if passwords match their policies

for line in passlist:
    minval, rest = line.split("-",2)
    maxval, letter, passpart= rest.split()    
    """print("minval is %s maxval is %s letter is %s passpart is %s"%
    (minval,maxval,letter,passpart))"""
    
    minval, maxval = int(minval), int(maxval)
    letter = letter.split(":")[0]
    """print(letter)"""
    
    lettercount = 0
    for char in passpart:
        if char == letter:
            lettercount += 1
    """print("lettercount is %d for password %s"%
            (lettercount,passpart))"""
              
    if lettercount >= minval and lettercount <= maxval:
        numGoodPass += 1
        """print(", this pass is good")"""
        
print("num of good passwords is %d"%(numGoodPass))
