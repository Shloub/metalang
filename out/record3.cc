#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
class toto {
public:
  int foo;
  int bar;
  int blah;
};

toto * mktoto(int v1){
  toto * t = new toto();
  t->foo=v1;
  t->bar=0;
  t->blah=0;
  return t;
}

int result(std::vector<toto * >& t, int len){
  int out_ = 0;
  for (int j = 0 ; j < len; j++)
  {
    t.at(j)->blah = t.at(j)->blah + 1;
    out_ = out_ + t.at(j)->foo + t.at(j)->blah * t.at(j)->bar + t.at(j)->bar * t.at(j)->foo;
  }
  return out_;
}


int main(){
  int a = 4;
  std::vector<toto * > t( a );
  for (int i = 0 ; i < a; i++)
    t.at(i) = mktoto(i);
  scanf("%d %d", &t.at(0)->bar, &t.at(1)->blah);
  int b = result(t, 4);
  std::cout << b;
  int c = t.at(2)->blah;
  std::cout << c;
  return 0;
}

