
bar_ = int(input())
t = {"foo":list(map(int, input().split())), "bar":bar_}
(a, b) = t["foo"]
print("%d %d %d\n" % (a, b, t["bar"]), end='')

