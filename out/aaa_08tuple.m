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
  int g, f, bar_;
  scanf("%d %d %d ", &bar_, &f, &g);
  tuple_int_int * i = [tuple_int_int alloc];
  i->tuple_int_int_field_0=f;
  i->tuple_int_int_field_1=g;
  toto * t = [toto alloc];
  t->foo=i;
  t->bar=bar_;
  tuple_int_int * h = t->foo;
  int a = h->tuple_int_int_field_0;
  int b = h->tuple_int_int_field_1;
  printf("%d %d %d\n", a, b, t->bar);
  [pool drain];
  return 0;
}


