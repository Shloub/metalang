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

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i, e, d;
  for (i = 1 ; i <= 3; i++)
  {
    scanf("%d %d ", &d, &e);
    tuple_int_int * f = [tuple_int_int alloc];
    f->tuple_int_int_field_0=d;
    f->tuple_int_int_field_1=e;
    int a = f->tuple_int_int_field_0;
    int b = f->tuple_int_int_field_1;
    printf("a = %d b = %d\n", a, b);
  }
  [pool drain];
  return 0;
}


