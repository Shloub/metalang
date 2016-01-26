#include <iostream>
#include <vector>
struct toto {
  int foo;
  int bar;
  int blah;
};


toto * mktoto(int v1) {
  toto * t = new toto();
  t->foo=v1;
  t->bar=0;
  t->blah=0;
  return t;
}


int result(std::vector<toto *> * t, int len) {
  int out0 = 0;
  for (int j = 0; j < len; j++)
  {
    t->at(j)->blah = t->at(j)->blah + 1;
    out0 =
    out0 + t->at(j)->foo + t->at(j)->blah * t->at(j)->bar + t->at(j)->bar * t->at(j)->foo;
  }
  return out0;
}


int main() {
  std::vector<toto *> *t = new std::vector<toto *>( 4 );
  for (int i = 0; i < 4; i++)
    t->at(i) = mktoto(i);
  std::cin >> t->at(0)->bar >> t->at(1)->blah >> std::noskipws;
  int titi = result(t, 4);
  std::cout << titi << t->at(2)->blah;
}

