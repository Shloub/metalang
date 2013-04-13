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
  struct toto * t = new toto();
  t->foo=v1;
  t->bar=0;
  t->blah=0;
  return t;
}

int result(std::vector<struct toto * >& t, int len){
  int out_ = 0;
  for (int j = 0 ; j < len; j++)
  {
    t.at(j)->blah = t.at(j)->blah + 1;
    out_ = out_ + t.at(j)->foo + t.at(j)->blah * t.at(j)->bar + t.at(j)->bar * t.at(j)->foo;
  }
  return out_;
}


int main(void){
  int h = 4;
  std::vector<struct toto * > t( h );
  for (int i = 0 ; i < h; i++)
  {
    t.at(i) = mktoto(i);
  }
  scanf("%d", &t.at(0)->bar);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &t.at(1)->blah);
  int k = result(t, 4);
  printf("%d", k);
  int l = t.at(2)->blah;
  printf("%d", l);
  return 0;
}

