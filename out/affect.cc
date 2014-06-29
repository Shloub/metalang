#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
/*
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*/
class toto {
public:
  int foo;
  int bar;
  int blah;
};

toto * mktoto(int v1){
  toto * t = new toto();
  t->foo=v1;
  t->bar=v1;
  t->blah=v1;
  return t;
}

toto * mktoto2(int v1){
  toto * t = new toto();
  t->foo=v1 + 3;
  t->bar=v1 + 2;
  t->blah=v1 + 1;
  return t;
}

int result(toto * t_, toto * t2_){
  toto * t = t_;
  toto * t2 = t2_;
  toto * t3 = new toto();
  t3->foo=0;
  t3->bar=0;
  t3->blah=0;
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
  toto * t = mktoto(4);
  toto * t2 = mktoto(5);
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

