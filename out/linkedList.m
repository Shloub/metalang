#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

@interface intlist : NSObject
{
  @public int head;
  @public intlist * tail;
}
@end
@implementation intlist 
@end

intlist * cons(intlist * list, int i){
  intlist * out0 = [intlist alloc];
  out0->head=i;
  out0->tail=list;
  return out0;
}

intlist * rev2(intlist * empty, intlist * acc, intlist * torev){
  if (torev == empty)
    return acc;
  else
  {
    intlist * acc2 = [intlist alloc];
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
    scanf("%d", &i);
    if (i != 0)
      list = cons(list, i);
  }
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  
  [pool drain];
  return 0;
}


