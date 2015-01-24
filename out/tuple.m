#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

@interface tuple_int_int : NSObject
{
  @public int tuple_int_int_field_0;
  @public int tuple_int_int_field_1;
}
@end
@implementation tuple_int_int 
@end

tuple_int_int * f(tuple_int_int * tuple0){
  tuple_int_int * e = [tuple_int_int alloc];
  e->tuple_int_int_field_0=tuple0->tuple_int_int_field_0 + 1;
  e->tuple_int_int_field_1=tuple0->tuple_int_int_field_1 + 1;
  return e;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  tuple_int_int * g = [tuple_int_int alloc];
  g->tuple_int_int_field_0=0;
  g->tuple_int_int_field_1=1;
  tuple_int_int * t = f(g);
  printf("%d -- %d--\n", t->tuple_int_int_field_0, t->tuple_int_int_field_1);
  [pool drain];
  return 0;
}


