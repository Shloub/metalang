#include<stdio.h>
#include<stdlib.h>

struct toto;
typedef struct toto {
  int foo;
  int bar;
  int blah;
} toto;

struct toto * mktoto(int v1){
  struct toto * t_ = malloc (sizeof(t_) );
  t_->foo=v1;
  t_->bar=0;
  t_->blah=0;
  return t_;
}

int result(struct toto ** t_, int len){
  int out_ = 0;
  {
    int j;
    for (j = 0 ; j < len; j++)
    {
      t_[j]->blah = t_[j]->blah + 1;
      out_ = out_ + t_[j]->foo + t_[j]->blah * t_[j]->bar + t_[j]->bar * t_[j]->foo;
    }
  }
  return out_;
}

int main(void){
  int a = 4;
  struct toto * *t_ = malloc( a * sizeof(struct toto *));
  {
    int i;
    for (i = 0 ; i < a; i++)
      t_[i] = mktoto(i);
  }
  scanf("%d", &t_[0]->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t_[1]->blah);
  int b = result(t_, 4);
  printf("%d", b);
  int c = t_[2]->blah;
  printf("%d", c);
  return 0;
}


