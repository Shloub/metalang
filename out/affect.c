#include<stdio.h>
#include<stdlib.h>

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
  struct toto * t__ = malloc (sizeof(t__) );
  t__->foo=v1;
  t__->bar=v1;
  t__->blah=v1;
  return t__;
}

int result(struct toto * t_, struct toto * t2_){
  struct toto * t__ = t_;
  struct toto * t2 = t2_;
  struct toto * t3 = malloc (sizeof(t3) );
  t3->foo=0;
  t3->bar=0;
  t3->blah=0;
  t3 = t2;
  t__ = t2;
  t2 = t3;
  t__->blah ++;
  int len = 1;
  int *cache0 = malloc( len * sizeof(int));
  {
    int i;
    for (i = 0 ; i < len; i++)
      cache0[i] = -i;
  }
  int *cache1 = malloc( len * sizeof(int));
  {
    int j;
    for (j = 0 ; j < len; j++)
      cache1[j] = j;
  }
  int* cache2 = cache0;
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
  printf("%d", a);
  int b = t__->blah;
  printf("%d", b);
  return 0;
}


