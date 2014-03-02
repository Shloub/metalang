#include<stdio.h>
#include<stdlib.h>

void sort_(int* tab, int len){
  {
    int i;
    for (i = 0 ; i < len; i++)
      {
      int j;
      for (j = i + 1 ; j < len; j++)
        if (tab[i] > tab[j])
      {
        int tmp = tab[i];
        tab[i] = tab[j];
        tab[j] = tmp;
      }
    }
  }
}

int main(void){
  int len = 2;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
  int *tab = malloc( len * sizeof(int));
  {
    int i_;
    for (i_ = 0 ; i_ < len; i_++)
    {
      int tmp = 0;
      scanf("%d", &tmp);
      scanf("%*[ \t\r\n]c");
      tab[i_] = tmp;
    }
  }
  sort_(tab, len);
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      int a = tab[i];
      printf("%d", a);
    }
  }
  return 0;
}


