#include<stdio.h>
#include<stdlib.h>

int** read_int_matrix(int x, int y){
  int* *tab = malloc( y * sizeof(int*));
  {
    int z;
    for (z = 0 ; z < y; z++)
    {
      int *b = malloc( x * sizeof(int));
      {
        int c;
        for (c = 0 ; c < x; c++)
        {
          int d = 0;
          scanf("%d ", &d);
          b[c] = d;
        }
      }
      int* a = b;
      tab[z] = a;
    }
  }
  return tab;
}

int main(void){
  int f = 0;
  scanf("%d ", &f);
  int len = f;
  printf("%d=len\n", len);
  int *h = malloc( len * sizeof(int));
  {
    int k;
    for (k = 0 ; k < len; k++)
    {
      int l = 0;
      scanf("%d ", &l);
      h[k] = l;
    }
  }
  int* tab1 = h;
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      printf("%d=>%d\n", i, tab1[i]);
    }
  }
  int o = 0;
  scanf("%d ", &o);
  len = o;
  int** tab2 = read_int_matrix(len, len - 1);
  {
    int i;
    for (i = 0 ; i <= len - 2; i++)
    {
      {
        int j;
        for (j = 0 ; j < len; j++)
        {
          printf("%d ", tab2[i][j]);
        }
      }
      printf("\n");
    }
  }
  return 0;
}


