#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

@interface foo : NSObject
{
  @public int a;
  @public int* b;
  @public int* c;
  @public int** d;
  @public int* e;
  @public foo * f;
  @public foo ** g;
  @public foo ** h;
}
@end
@implementation foo 
@end


int default0(int* a, foo * b, int** c, foo ** d, int* e, foo ** f) {
    return 0;
}


void aa(foo * b) {
    
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int* a = NULL;
  printf("___\n");
  [pool drain];
  return 0;
}


