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


tuple_int_int * f(tuple_int_int * tuple0) {
    tuple_int_int * c = tuple0;
    int a = c->tuple_int_int_field_0;
    int b = c->tuple_int_int_field_1;
    tuple_int_int * d = [tuple_int_int alloc];
    d->tuple_int_int_field_0 = a + 1;
    d->tuple_int_int_field_1 = b + 1;
    return d;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  tuple_int_int * e = [tuple_int_int alloc];
  e->tuple_int_int_field_0 = 0;
  e->tuple_int_int_field_1 = 1;
  tuple_int_int * t = f(e);
  tuple_int_int * g = t;
  int a = g->tuple_int_int_field_0;
  int b = g->tuple_int_int_field_1;
  printf("%d -- %d--\n", a, b);
  [pool drain];
  return 0;
}


