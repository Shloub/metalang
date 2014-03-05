#include<stdio.h>
#include<stdlib.h>

int devine_(int nombre, int* tab, int len){
  int min_ = tab[0];
  int max_ = tab[1];
  {
    int i;
    for (i = 2 ; i < len; i++)
    {
      printf("%d => ", i);
      int a = tab[i];
      printf("%d\n", a);
      if (tab[i] > max_ || tab[i] < min_)
        return 0;
      if (tab[i] < nombre)
        min_ = tab[i];
      if (tab[i] > nombre)
        max_ = tab[i];
      if (tab[i] == nombre && len != i + 1)
        return 0;
    }
  }
  return 1;
}

int main(void){
  int nombre = 0;
  scanf("%d", &nombre);
  scanf("%*[ \t\r\n]c");
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
  printf("%d %d\n", nombre, len);
  int *tab = malloc( len * sizeof(int));
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      int tmp = 0;
      scanf("%d", &tmp);
      scanf("%*[ \t\r\n]c");
      printf("%d ", tmp);
      tab[i] = tmp;
    }
  }
  printf("\n");
  int b = devine_(nombre, tab, len);
  if (b)
    printf("True");
  else
    printf("False");
  return 0;
}


