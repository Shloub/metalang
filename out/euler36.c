#include <stdio.h>
#include <stdlib.h>

int palindrome2(int* pow2, int n) {
  int k, j, i;
  int *t = calloc( 20 , sizeof(int));
  for (i = 0; i < 20; i++)
    t[i] = n / pow2[i] % 2 == 1;
  int nnum = 0;
  for (j = 1; j <= 19; j++)
    if (t[j])
    nnum = j;
  for (k = 0; k <= nnum / 2; k++)
    if (t[k] != t[nnum - k])
    return 0;
  return 1;
}

int main(void) {
  int a0, b, c, d, i;
  int p = 1;
  int *pow2 = calloc( 20 , sizeof(int));
  for (i = 0; i < 20; i++)
  {
    p *= 2;
    pow2[i] = p / 2;
  }
  int sum = 0;
  for (d = 1; d <= 9; d++)
  {
    if (palindrome2(pow2, d))
    {
      printf("%d\n", d);
      sum += d;
    }
    if (palindrome2(pow2, d * 10 + d))
    {
      printf("%d\n", d * 10 + d);
      sum += d * 10 + d;
    }
  }
  for (a0 = 0; a0 <= 4; a0++)
  {
    int a = a0 * 2 + 1;
    for (b = 0; b <= 9; b++)
    {
      for (c = 0; c <= 9; c++)
      {
        int num0 = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a;
        if (palindrome2(pow2, num0))
        {
          printf("%d\n", num0);
          sum += num0;
        }
        int num1 = a * 10000 + b * 1000 + c * 100 + b * 10 + a;
        if (palindrome2(pow2, num1))
        {
          printf("%d\n", num1);
          sum += num1;
        }
      }
      int num2 = a * 100 + b * 10 + a;
      if (palindrome2(pow2, num2))
      {
        printf("%d\n", num2);
        sum += num2;
      }
      int num3 = a * 1000 + b * 100 + b * 10 + a;
      if (palindrome2(pow2, num3))
      {
        printf("%d\n", num3);
        sum += num3;
      }
    }
  }
  printf("sum=%d\n", sum);
  return 0;
}


