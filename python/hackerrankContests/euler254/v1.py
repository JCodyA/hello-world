# Enter your code here. Read input from STDIN. Print output to STDOUT
import math

class EulerSolution:
    def __init__(self):
        self.q = int(input())
        self.n = []
        self.m = []
        self.sfordlist = []
        self.sgsumlist = []
        for _ in range(self.q):
            n, m = input().split()
            self.n.append(n)
            self.m.append(m)
        self.flist = [sum([math.factorial(int(digit)) for digit in n]) for n in self.n]
        self.sflist = [sum([int(digit) for digit in str(fn)]) for fn in self.flist]
        print(self.flist)
        print(self.sflist)
        print(self.glist)
        for i in range(len(self.sgsumlist)):
            print(self.sgsumlist[i]%int(self.m[i]))
        #print(self.glist)
    def g(self, n, sfGoal):
        fn = sum([math.factorial(int(ndigit)) for ndigit in str(n)])
        sfn = sum([int(fndigit) for fndigit in str(fn)])
        self.glist.append(sfn)
        if sfn != sfGoal:
            self.g(n+1, sfGoal)
        else:
            pass
        
euler = EulerSolution()
                   

