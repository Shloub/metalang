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

int result(toto * t){
  t->blah ++;
  return t->foo + t->blah * t->bar + t->bar * t->foo;
}


int main(){
  toto * t = mktoto(4);
  std::cin >> t->bar >> std::skipws >> t->blah >> std::noskipws;
  std::cout << result(t);
  return 0;
}

