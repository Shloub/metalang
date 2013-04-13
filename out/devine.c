#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }

int devine_(int nombre, int* tab, int len){
  int min_ = tab[0];
  int max_ = tab[1];
  {
    int i;
    for (i = 2 ; i <= len - 1; i++)
    {
      if ((tab[i] > max_) || (tab[i] < min_))
      {
        return 0;
      }
      if (tab[i] < nombre)
      {
        min_ = tab[i];
      }
      if (tab[i] > nombre)
      {
        max_ = tab[i];
      }
      if ((tab[i] == nombre) && (len != (i + 1)))
      {
        return 0;
      }
    }
  }
  return 1;
}

int main(void){
  int nombre = 0;
  scanf("%d", &nombre);
  scanf("%*[ \t\r\n]c", 0);
  int len = 0;
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
  int a = devine_(nombre, tab, len);
  if (a)
  {
    printf("%s", "True");
  }
  else
  {
    printf("%s", "False");
  }
  return 0;
}


