#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
struct toto;
typedef struct toto {
  int foo;
  int bar;
  int blah;
} toto;

struct toto * mktoto(int v1){
  struct toto * t_ = new toto();
  t_->foo=v1;
  t_->bar=0;
  t_->blah=0;
  return t_;
}

int result(std::vector<struct toto * >& t_, int len){
  int out_ = 0;
  for (int j = 0 ; j < len; j++)
  {
    t_.at(j)->blah = t_.at(j)->blah + 1;
    out_ = out_ + t_.at(j)->foo + t_.at(j)->blah * t_.at(j)->bar + t_.at(j)->bar * t_.at(j)->foo;
  }
  return out_;
}


int main(void){
  int a = 4;
  std::vector<struct toto * > t_( a );
  for (int i = 0 ; i < a; i++)
    t_.at(i) = mktoto(i);
  scanf("%d", &t_.at(0)->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t_.at(1)->blah);
  int b = result(t_, 4);
  std::cout << b;
  int c = t_.at(2)->blah;
  std::cout << c;
  return 0;
}

