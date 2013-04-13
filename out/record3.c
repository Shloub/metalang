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
  t->bar=0;
  t->blah=0;
  return t;
}

int result(struct toto ** t, int len){
  int out_ = 0;
  {
    int j;
    for (j = 0 ; j <= len - 1; j++)
    {
      t[j]->blah = t[j]->blah + 1;
      out_ = ((out_ + t[j]->foo) + (t[j]->blah * t[j]->bar)) + (t[j]->bar * t[j]->foo);
    }
  }
  return out_;
}

int main(void){
  int a = 4;
  struct toto * *t = malloc( (a) * sizeof(struct toto *) + sizeof(int));
  ((int*)t)[0]=a;
  t=(struct toto **)( ((int*)t)+1);
  {
    int i;
    for (i = 0 ; i <= a - 1; i++)
    {
      t[i] = mktoto(i);
    }
  }
  scanf("%d", &t[0]->bar);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &t[1]->blah);
  int b = result(t, 4);
  printf("%d", b);
  int c = t[2]->blah;
  printf("%d", c);
  return 0;
}


