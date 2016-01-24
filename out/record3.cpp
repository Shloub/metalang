#include <iostream>
#include <vector>
struct toto {
  int foo;
  int bar;
  int blah;
};

toto mktoto(int v1){
  toto t;
  t.foo = v1;
  t.bar = 0;
  t.blah = 0;
  return t;
}

int result(std::vector<toto >& t, int len){
  int out0 = 0;
  for (int j = 0 ; j < len; j++)
  {
    t[j].blah = t[j].blah + 1;
    out0 = out0 + t[j].foo + t[j].blah * t[j].bar + t[j].bar * t[j].foo;
  }
  return out0;
}


int main(){
  std::vector<toto > t(4);
  for (int i = 0 ; i < 4; i++)
    t[i] = mktoto(i);
  std::cin >> t[0].bar >> std::skipws >> t[1].blah >> std::noskipws;
  int titi = result(t, 4);
  std::cout << titi << t[2].blah;
  return 0;
}

