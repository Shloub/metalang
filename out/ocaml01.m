#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int foo(){
  int i;
  for (i = 0 ; i <= 10; i++)
  {
    
  }
  return 0;
}

int bar(){
  int i;
  for (i = 0 ; i <= 10; i++)
  {
    int a = 0;
  }
  return 0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  
  [pool drain];
  return 0;
}


