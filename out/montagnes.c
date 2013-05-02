#include<stdio.h>
#include<stdlib.h>

int montagnes_(int* tab, int len){
  int max_ = 1;
  int j = 1;
  int i = len - 2;
  while (i >= 0)
  {
    int x = tab[i];
    while (j >= 0 && x > tab[len - j])
      j --;
    j ++;
    tab[len - j] = x;
    if (j > max_)
      max_ = j;
    i --;
  }
  return max_;
}

int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  int *tab = malloc( len * sizeof(int));
  
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      int x = 0;
      scanf("%d", &x);
      scanf("%*[ \t\r\n]c", 0);
      tab[i] = x;
    }
  }
  int a = montagnes_(tab, len);
  printf("%d", a);
  return 0;
}


