#include <stdio.h>
#include <stdlib.h>

int max2_(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int main(void){
  int k, j;
  char e, c;
  int i = 1;
  int *last = calloc( 5 , sizeof(int));
  for (j = 0 ; j < 5; j++)
  {
    scanf("%c", &c);
    int d = (int)(c) - (int)('0');
    i *= d;
    last[j] = d;
  }
  int max0 = i;
  int index = 0;
  int nskipdiv = 0;
  for (k = 1 ; k <= 995; k++)
  {
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
    max0 = max2_(max0, i);
  }
  printf("%d\n", max0);
  return 0;
}


