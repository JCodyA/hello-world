# Enter your code here. Read input from STDIN. Print output to STDOUT
import math

#class EulerSolution 
class EulerSolution:
    def __init__(self):

    #Get input, setup needed lists
        
        self.q = int(input())
        self.n = []
        self.m = []
        self.sflist = []
        for _ in range(self.q):
            n, m = input().split()
            self.n.append(int(n))
            self.m.append(int(m))
        self.glist = ["" for _ in range(max(self.n))]
        self.sfn(1)
        print(self.glist)

    #generate final digit sums and print answers mod m
        
        for i in range(len(self.n)):
            finalsum = 0
            for item in self.glist[:self.n[i]]:
                finalsum += sum([int(digit) for digit in str(item)])
            print(finalsum%self.m[i])

    #function to generate glist
            
    def sfn(self, n):
        while "" in self.glist:
            fn = sum([math.factorial(int(ndigit)) for ndigit in str(n)])
            sfn = sum([int(fndigit) for fndigit in str(fn)])
            self.sflist.append(sfn)
            if sfn<=max(self.n) and self.glist[sfn-1] == "":
                self.glist.insert(sfn-1, n)
                self.glist.pop(sfn)
            n += 1
        
euler = EulerSolution()                  
