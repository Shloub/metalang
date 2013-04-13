#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }

struct toto;
typedef struct toto {
  int foo;
  int bar;
  int blah;
} toto;

struct toto * mktoto(int v1){
  struct toto * t = malloc (sizeof(t) );
  t->foo=v1;
  t->bar=v1;
  t->blah=v1;
  return t;
}

int result(struct toto * t_, struct toto * t2_){
  struct toto * t = t_;
  struct toto * t2 = t2_;
  struct toto * t3 = malloc (sizeof(t3) );
  t3->foo=0;
  t3->bar=0;
  t3->blah=0;
  t3 = t2;
  t = t2;
  t2 = t3;
  t->blah = t->blah + 1;
  int len = 1;
  int *cache0 = malloc( (len) * sizeof(int) + sizeof(int));
  ((int*)cache0)[0]=len;
  cache0=(int*)( ((int*)cache0)+1);
  {
    int i;
    for (i = 0 ; i <= len - 1; i++)
    {
      cache0[i] = -i;
    }
  }
  int *cache1 = malloc( (len) * sizeof(int) + sizeof(int));
  ((int*)cache1)[0]=len;
  cache1=(int*)( ((int*)cache1)+1);
  {
    int i;
    for (i = 0 ; i <= len - 1; i++)
    {
      cache1[i] = i;
    }
  }
  int* cache2 = cache0;
  cache0 = cache1;
  cache2 = cache0;
  return (t->foo + (t->blah * t->bar)) + (t->bar * t->foo);
}

int main(void){
  struct toto * t = mktoto(4);
  struct toto * t2 = mktoto(5);
  scanf("%d", &t->bar);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &t->blah);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &t2->bar);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &t->blah);
  int a = result(t, t2);
  printf("%d", a);
  int b = t->blah;
  printf("%d", b);
  return 0;
}


