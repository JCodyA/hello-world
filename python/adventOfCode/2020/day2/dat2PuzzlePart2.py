#advent of code day 2 part 2 2020
#check passwords that match their policies from file
#new pass policy, 1-3 a: abcde means a must be the
#first number or 3rd number
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
    firstindex, rest = line.split("-",2)
    secondindex, letter, passpart= rest.split()    
    firstindex, secondindex = int(firstindex)-1, int(secondindex)-1
    letter = letter.split(":")[0]
    """print("first is %d, second is %d, letter is %s, pass is %s"%
          (firstindex,secondindex,letter,passpart))"""
    
    if (letter == passpart[firstindex] and
        letter != passpart[secondindex]) or (letter == passpart[secondindex]
                                             and letter != passpart[firstindex]):
        numGoodPass += 1
        """print("%s is a good pass"%(passpart))"""
    """else:
        print("first is %d, second is %d, letter is %s, pass is %s"%
              (firstindex,secondindex,letter,passpart))
        print("this is a bad pass")"""
        
        
print("num of good passwords is %d"%(numGoodPass))
