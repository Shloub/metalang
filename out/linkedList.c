#include<stdio.h>
#include<stdlib.h>

struct intlist;
typedef struct intlist {
  int head;
  struct intlist * tail;
} intlist;

struct intlist * cons(struct intlist * list, int i){
  struct intlist * a = malloc (sizeof(a) );
  a->head=i;
  a->tail=list;
  struct intlist * out_ = a;
  return out_;
}

struct intlist * rev2(struct intlist * empty, struct intlist * acc, struct intlist * torev){
  if (torev == empty)
    return acc;
  else
  {
    struct intlist * b = malloc (sizeof(b) );
    b->head=torev->head;
    b->tail=acc;
    struct intlist * acc2 = b;
    return rev2(empty, acc, torev->tail);
  }
}

struct intlist * rev(struct intlist * empty, struct intlist * torev){
  return rev2(empty, empty, torev);
}

void test(struct intlist * empty){
  struct intlist * list = empty;
  int i = -1;
  while (i != 0)
  {
    scanf("%d", &i);
    if (i != 0)
      list = cons(list, i);
  }
}

int main(void){
  
  return 0;
}


