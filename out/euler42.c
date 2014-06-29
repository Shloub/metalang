#include<stdio.h>
#include<stdlib.h>
#include<math.h>


int isqrt(int c){
  return sqrt(c);
}


int is_triangular(int n){
  /*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   */
  int a = isqrt(n * 2);
  return a * (a + 1) == n * 2;
}

int score(){
  scanf("%*[ \t\r\n]c");
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
  if (is_triangular(sum))
    return 1;
  else
    return 0;
}

int main(void){
  {
    int i;
    for (i = 1 ; i <= 55; i++)
      if (is_triangular(i))
    {
      printf("%d ", i);
    }
  }
  printf("\n");
  int sum = 0;
  int n = 0;
  scanf("%d", &n);
  {
    int i;
    for (i = 1 ; i <= n; i++)
      sum += score();
  }
  printf("%d\n", sum);
  return 0;
}


