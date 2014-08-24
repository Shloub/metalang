#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>
#include<math.h>

int is_triangular(int n){
  /*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   */
  int d = n * 2;
  int a = (int)sqrt(d);
  return a * (a + 1) == n * 2;
}

int score(){
  int i;
  scanf(" ");
  int len = 0;
  scanf("%d ", &len);
  int sum = 0;
  for (i = 1 ; i <= len; i++)
  {
    char c = '_';
    scanf("%c", &c);
    sum += ((int)(c) - (int)('A')) + 1;
    /*		print c print " " print sum print " " */
  }
  if (is_triangular(sum))
    return 1;
  else
    return 0;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i;
  for (i = 1 ; i <= 55; i++)
    if (is_triangular(i))
  {
    printf("%d ", i);
  }
  printf("\n");
  int sum = 0;
  int n = 0;
  scanf("%d", &n);
  for (i = 1 ; i <= n; i++)
    sum += score();
  printf("%d\n", sum);
  [pool drain];
  return 0;
}


