#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

@interface toto : NSObject
{
  @public int foo;
  @public int bar;
}
@end
@implementation toto 
@end

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  toto * param = [toto alloc];
  param->foo=0;
  param->bar=0;
  scanf("%d %d", &param->bar, &param->foo);
  printf("%d", param->bar + param->foo * param->bar);
  [pool drain];
  return 0;
}


