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

int result(struct toto * t_){
  t_->blah ++;
  return t_->foo + t_->blah * t_->bar + t_->bar * t_->foo;
}


int main(void){
  struct toto * t_ = mktoto(4);
  scanf("%d", &t_->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t_->blah);
  int a = result(t_);
  std::cout << a;
  int b = t_->blah;
  std::cout << b;
  return 0;
}

