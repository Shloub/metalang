#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

@interface toto : NSObject
{
  @public int foo;
  @public int bar;
  @public int blah;
}
@end
@implementation toto 
@end


toto * mktoto(int v1) {
    toto * t = [toto alloc];
    t->foo=v1;
    t->bar=0;
    t->blah=0;
    return t;
}


int result(toto * t) {
    t->blah++;
    return t->foo + t->blah * t->bar + t->bar * t->foo;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  toto * t = mktoto(4);
  scanf("%d %d", &t->bar, &t->blah);
  printf("%d", result(t));
  [pool drain];
  return 0;
}


