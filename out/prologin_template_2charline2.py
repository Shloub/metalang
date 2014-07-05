def read_int(  ):
    return int(input());

def read_char_line( n ):
    return list(input());

def programme_candidat( tableau1, taille1, tableau2, taille2 ):
    out_ = 0;
    for i in range(0, taille1):
      out_ += ord(tableau1[i]) * i
      a = tableau1[i];
      print("%c" % a, end='')
    print("--")
    for j in range(0, taille2):
      out_ += ord(tableau2[j]) * j * 100
      b = tableau2[j];
      print("%c" % b, end='')
    print("--")
    return out_;

taille1 = read_int();
taille2 = read_int();
tableau1 = read_char_line(taille1);
tableau2 = read_char_line(taille2);
c = programme_candidat(tableau1, taille1, tableau2, taille2);
print("%d\n" % ( c ), end='')

