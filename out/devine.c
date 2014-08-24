#include<stdio.h>
#include<stdlib.h>

int devine_(int nombre, int* tab, int len){
  int i;
  int min_ = tab[0];
  int max_ = tab[1];
  for (i = 2 ; i < len; i++)
  {
    if (tab[i] > max_ || tab[i] < min_)
      return 0;
    if (tab[i] < nombre)
      min_ = tab[i];
    if (tab[i] > nombre)
      max_ = tab[i];
    if (tab[i] == nombre && len != i + 1)
      return 0;
  }
  return 1;
}

int main(void){
  int i;
  int nombre = 0;
  scanf("%d ", &nombre);
  int len = 0;
  scanf("%d ", &len);
  int *tab = malloc( len * sizeof(int));
  for (i = 0 ; i < len; i++)
  {
    int tmp = 0;
    scanf("%d ", &tmp);
    tab[i] = tmp;
  }
  int a = devine_(nombre, tab, len);
  if (a)
    printf("True");
  else
    printf("False");
  return 0;
}


