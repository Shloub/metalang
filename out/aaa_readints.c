#include<stdio.h>
#include<stdlib.h>

int read_int(){
  int out_ = 0;
  scanf("%d ", &out_);
  return out_;
}

int* read_int_line(int n){
  int *tab = malloc( n * sizeof(int));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      int t = 0;
      scanf("%d ", &t);
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
      scanf("%*[ \t\r\n]c");
      tab[z] = read_int_line(x);
    }
  }
  return tab;
}

int main(void){
  int len = read_int();
  printf("%d=len\n", len);
  int* tab1 = read_int_line(len);
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      printf("%d=>", i);
      int a = tab1[i];
      printf("%d\n", a);
    }
  }
  len = read_int();
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
          printf("%d ", b);
        }
      }
      printf("\n");
    }
  }
  return 0;
}


