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

int main(void){
  int* l0 = read_int_line(1);
  int len = l0[0];
  printf("%d", len);
  printf("%s", "=len\n");
  int* tab1 = read_int_line(len);
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      printf("%d", i);
      printf("%s", "=>");
      int a = tab1[i];
      printf("%d", a);
      printf("%s", "\n");
    }
  }
  int* tab2 = read_int_line(len);
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      printf("%d", i);
      printf("%s", "=>");
      int b = tab2[i];
      printf("%d", b);
      printf("%s", "\n");
    }
  }
  return 0;
}


