
def fib(n):
    if n==1:
        return [1]
    if n==2:
        return [1,1]
    else:
        fibs = [1,1]
        for i in range(2,n):
            fibs.append(fibs[i-1] + fibs[i-2])
        return fibs

print(fib(10))