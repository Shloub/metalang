#include<stdio.h>
#include<stdlib.h>

int main(void){
  int j, s, v, w, i, k, f;
  scanf("%d ", &f);
  int len = f;
  printf("%d=len\n", len);
  int *h = malloc( len * sizeof(int));
  for (k = 0 ; k < len; k++)
  {
    scanf("%d ", &h[k]);
  }
  int* tab1 = h;
  for (i = 0 ; i < len; i++)
  {
    printf("%d=>%d\n", i, tab1[i]);
  }
  scanf("%d ", &len);
  int* *r = malloc( (len - 1) * sizeof(int*));
  for (s = 0 ; s < len - 1; s++)
  {
    int *u = malloc( len * sizeof(int));
    for (v = 0 ; v < len; v++)
    {
      scanf("%d ", &w);
      u[v] = w;
    }
    r[s] = u;
  }
  int** tab2 = r;
  for (i = 0 ; i <= len - 2; i++)
  {
    for (j = 0 ; j < len; j++)
    {
      printf("%d ", tab2[i][j]);
    }
    printf("\n");
  }
  return 0;
}


