#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

typedef enum foo_t {
  Foo,
  Bar,
  Blah
} foo_t;
int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  foo_t foo_val = Foo;
  [pool drain];
  return 0;
}


