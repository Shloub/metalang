#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }

void sort_(int* tab, int len){
  {
    int i;
    for (i = 0 ; i <= len - 1; i++)
    {
      {
        int j;
        for (j = i + 1 ; j <= len - 1; j++)
        {
          if (tab[i] > tab[j])
          {
            int tmp = tab[i];
            tab[i] = tab[j];
            tab[j] = tmp;
          }
        }
      }
    }
  }
}

int main(void){
  int len = 2;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  int *tab = malloc( (len) * sizeof(int) + sizeof(int));
  ((int*)tab)[0]=len;
  tab=(int*)( ((int*)tab)+1);
  {
    int i;
    for (i = 0 ; i <= len - 1; i++)
    {
      int tmp = 0;
      scanf("%d", &tmp);
      scanf("%*[ \t\r\n]c", 0);
      tab[i] = tmp;
    }
  }
  sort_(tab, len);
  {
    int a;
    for (a = 0 ; a <= (count(tab)) - 1; a++)
    {
      printf("%d", tab[a]);
    }
  }
  return 0;
}


