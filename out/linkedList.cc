#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
struct intlist;
typedef struct intlist {
  int head;
  struct intlist * tail;
} intlist;

struct intlist * cons(struct intlist * list, int i){
  struct intlist * out_ = new intlist();
  out_->head=i;
  out_->tail=list;
  return out_;
}

struct intlist * rev2(struct intlist * empty, struct intlist * acc, struct intlist * torev){
  if (torev == empty)
    return acc;
  else
  {
    struct intlist * acc2 = new intlist();
    acc2->head=torev->head;
    acc2->tail=acc;
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

