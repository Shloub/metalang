def test( tab, len ):
    for i in range(0, len):
      print("%d " % ( tab[i] ), end='')
    print("")

t = [1] * 5
test(t, 5)

