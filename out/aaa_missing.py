def read_int(  ):
    return int(input());

def read_int_line( n ):
    return list(map(int, input().split()));

"""
  Ce test a été généré par Metalang.
"""
def result( len, tab ):
    tab2 = [None] * len
    for i in range(0, len):
      tab2[i] = False;
    for i1 in range(0, len):
      tab2[tab[i1]] = True;
    for i2 in range(0, len):
      if not (tab2[i2]):
        return i2;
    return -(1);

a = int(input());
len = a;
print("%d\n" % ( len ), end='')
b = list(map(int, input().split()));
tab = b;
print("%d" % result(len, tab), end='')

