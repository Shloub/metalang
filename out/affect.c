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
  struct toto * c = malloc (sizeof(c) );
  c->foo=v1
  +
  1;
  c->bar=v1;
  c->blah=v1;
  struct toto * t = c;
  return t;
}

int result(struct toto * t_, struct toto * t2_){
  struct toto * t = t_;
  struct toto * t2 = t2_;
  struct toto * d = malloc (sizeof(d) );
  d->foo=0;
  d->bar=0;
  d->blah=0;
  struct toto * t3 = d;
  t3 = t2;
  t = t2;
  t2 = t3;
  t->blah ++;
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
  printf("%d", a);
  int b = t->blah;
  printf("%d", b);
  return 0;
}


