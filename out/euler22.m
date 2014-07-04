#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int score(){
  scanf(" ");
  int len = 0;
  scanf("%d ", &len);
  int sum = 0;
  {
    int i;
    for (i = 1 ; i <= len; i++)
    {
      char c = '_';
      scanf("%c", &c);
      sum += (c - 'A') + 1;
      /*		print c print " " print sum print " " */
    }
  }
  return sum;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int sum = 0;
  int n = 0;
  scanf("%d", &n);
  {
    int i;
    for (i = 1 ; i <= n; i++)
      sum += i * score();
  }
  printf("%d\n", sum);
  [pool drain];
  return 0;
}


