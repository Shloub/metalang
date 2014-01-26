#include<stdio.h>
#include<stdlib.h>

int* read_int_line(int n){
  int *tab = malloc( n * sizeof(int));
  
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      int t = 0;
      scanf("%d", &t);
      scanf("%*[ \t\r\n]c", 0);
      tab[i] = t;
    }
  }
  return tab;
}

int** read_int_matrix(int x, int y){
  int* *tab = malloc( y * sizeof(int*));
  
  {
    int z;
    for (z = 0 ; z < y; z++)
    {
      int* out_ = read_int_line(x);
      scanf("%*[ \t\r\n]c", 0);
      tab[z] = out_;
    }
  }
  return tab;
}

int main(void){
  int* l0 = read_int_line(1);
  int len = l0[0];
  printf("%d", len);
  printf("=len\n");
  int* tab1 = read_int_line(len);
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      printf("%d", i);
      printf("=>");
      int a = tab1[i];
      printf("%d", a);
      printf("\n");
    }
  }
  l0 = read_int_line(1);
  len = l0[0];
  int** tab2 = read_int_matrix(len, len - 1);
  {
    int i;
    for (i = 0 ; i <= len - 2; i++)
    {
      {
        int j;
        for (j = 0 ; j < len; j++)
        {
          int b = tab2[i][j];
          printf("%d", b);
          printf(" ");
        }
      }
      printf("\n");
    }
  }
  return 0;
}


