#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
struct toto;
typedef struct toto {
  int foo;
  int bar;
} toto;


int main(void){
  struct toto * param = new toto();
  param->foo=0;
  param->bar=0;
  scanf("%d", &param->bar);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &param->foo);
  int a = param->bar + param->foo * param->bar;
  std::cout << a;
  return 0;
}

