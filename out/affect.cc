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
  struct toto * c = new toto();
  c->foo=v1;
  c->bar=v1;
  c->blah=v1;
  struct toto * t = c;
  return t;
}

struct toto * mktoto2(int v1){
  struct toto * d = new toto();
  d->foo=v1
  +
  3;
  d->bar=v1
  +
  2;
  d->blah=v1
  +
  1;
  struct toto * t = d;
  return t;
}

int result(struct toto * t_, struct toto * t2_){
  struct toto * t = t_;
  struct toto * t2 = t2_;
  struct toto * e = new toto();
  e->foo=0;
  e->bar=0;
  e->blah=0;
  struct toto * t3 = e;
  t3 = t2;
  t = t2;
  t2 = t3;
  t->blah ++;
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
  return t->foo + t->blah * t->bar + t->bar * t->foo;
}


int main(void){
  struct toto * t = mktoto(4);
  struct toto * t2 = mktoto(5);
  scanf("%d", &t->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t->blah);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t2->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t->blah);
  int a = result(t, t2);
  std::cout << a;
  int b = t->blah;
  std::cout << b;
  return 0;
}

