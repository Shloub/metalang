#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
/*
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*/
struct toto;
typedef struct toto {
  int foo;
  int bar;
  int blah;
} toto;

struct toto * mktoto(int v1){
  struct toto * t__ = new toto();
  t__->foo=v1;
  t__->bar=v1;
  t__->blah=v1;
  return t__;
}

int result(struct toto * t_, struct toto * t2_){
  struct toto * t__ = t_;
  struct toto * t2 = t2_;
  struct toto * t3 = new toto();
  t3->foo=0;
  t3->bar=0;
  t3->blah=0;
  t3 = t2;
  t__ = t2;
  t2 = t3;
  t__->blah ++;
  int len = 1;
  std::vector<int > cache0( len );
  for (int i = 0 ; i < len; i++)
    cache0.at(i) = -i;
  std::vector<int > cache1( len );
  for (int j = 0 ; j < len; j++)
    cache1.at(j) = j;
  std::vector<int > cache2 = cache0;
  cache0 = cache1;
  cache2 = cache0;
  return t__->foo + t__->blah * t__->bar + t__->bar * t__->foo;
}


int main(void){
  struct toto * t__ = mktoto(4);
  struct toto * t2 = mktoto(5);
  scanf("%d", &t__->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t__->blah);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t2->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t__->blah);
  int a = result(t__, t2);
  std::cout << a;
  int b = t__->blah;
  std::cout << b;
  return 0;
}

