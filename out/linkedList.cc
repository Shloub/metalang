#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
class intlist {
public:
  int head;
  intlist * tail;
};

intlist * cons(intlist * list, int i){
  intlist * out_ = new intlist();
  out_->head=i;
  out_->tail=list;
  return out_;
}

intlist * rev2(intlist * empty, intlist * acc, intlist * torev){
  if (torev == empty)
    return acc;
  else
  {
    intlist * acc2 = new intlist();
    acc2->head=torev->head;
    acc2->tail=acc;
    return rev2(empty, acc, torev->tail);
  }
}

intlist * rev(intlist * empty, intlist * torev){
  return rev2(empty, empty, torev);
}

void test(intlist * empty){
  intlist * list = empty;
  int i = -1;
  while (i != 0)
  {
    std::cin >> i >> std::noskipws;
    if (i != 0)
      list = cons(list, i);
  }
}


int main(){
  
  return 0;
}

