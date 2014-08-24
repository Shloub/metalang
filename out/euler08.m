#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int max2(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int k, j;
  int i = 1;
  int *last = malloc( 5 * sizeof(int));
  for (j = 0 ; j < 5; j++)
  {
    char c = '_';
    scanf("%c", &c);
    int d = (int)(c) - (int)('0');
    i *= d;
    last[j] = d;
  }
  int max_ = i;
  int index = 0;
  int nskipdiv = 0;
  for (k = 1 ; k <= 995; k++)
  {
    char e = '_';
    scanf("%c", &e);
    int f = (int)(e) - (int)('0');
    if (f == 0)
    {
      i = 1;
      nskipdiv = 4;
    }
    else
    {
      i *= f;
      if (nskipdiv < 0)
        i /= last[index];
      nskipdiv --;
    }
    last[index] = f;
    index = (index + 1) % 5;
    max_ = max2(max_, i);
  }
  printf("%d\n", max_);
  [pool drain];
  return 0;
}


