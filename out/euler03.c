#include<stdio.h>
#include<stdlib.h>
#include<math.h>

int main(void){
  int maximum = 1;
  int b0 = 2;
  int a = 408464633;
  int sqrtia = (int)sqrt(a);
  while (a != 1)
  {
    int b = b0;
    int found = 0;
    while (b <= sqrtia)
    {
      if ((a % b) == 0)
      {
        a /= b;
        b0 = b;
        b = a;
        int e = (int)sqrt(a);
        sqrtia = e;
        found = 1;
      }
      b ++;
    }
    if (!found)
    {
      printf("%d\n", a);
      a = 1;
    }
  }
  return 0;
}


