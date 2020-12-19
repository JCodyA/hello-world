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

    #generate final digit sums and print answers mod m
        
        for i in range(len(self.n)):
            finalsum = 0
            for item in self.glist[:self.n[i]]:
                finalsum += sum([int(digit) for digit in str(item)])
            print(finalsum%self.m[i])

    #function to generate glist
            
    def sfn(self, n):
        limit = max(self.n)
        while "" in self.glist:
            result = self.sfn(self.fn(n))
            print(result)
            self.sflist.append(result)
            if result<=limit and self.glist[result-1] == "":
                self.glist.insert(result-1, n)
                self.glist.pop(result)
            n += 1

    def fn(self, n):
        print("fn alled")
        return sum([math.factorial(int(ndigit)) for ndigit in str(n)])
    def sfn(self, n):
        print("sfn called")
        return sum([int(digit) for digit in str(n)])
        
euler = EulerSolution()
