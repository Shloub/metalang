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

@interface toto : NSObject
{
  @public tuple_int_int * foo;
  @public int bar;
}
@end
@implementation toto 
@end

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int d, c, bar_;
  scanf("%d %d %d ", &bar_, &c, &d);
  tuple_int_int * e = [tuple_int_int alloc];
  e->tuple_int_int_field_0 = c;
  e->tuple_int_int_field_1 = d;
  toto * t = [toto alloc];
  t->foo = e;
  t->bar = bar_;
  tuple_int_int * f = t->foo;
  int a = f->tuple_int_int_field_0;
  int b = f->tuple_int_int_field_1;
  printf("%d %d %d\n", a, b, t->bar);
  [pool drain];
  return 0;
}


