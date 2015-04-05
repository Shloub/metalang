#include <stdio.h>
#include <stdlib.h>

int devine0(int nombre, int* tab, int len){
  int i;
  int min0 = tab[0];
  int max0 = tab[1];
  for (i = 2 ; i < len; i++)
  {
    if (tab[i] > max0 || tab[i] < min0)
      return 0;
    if (tab[i] < nombre)
      min0 = tab[i];
    if (tab[i] > nombre)
      max0 = tab[i];
    if (tab[i] == nombre && len != i + 1)
      return 0;
  }
  return 1;
}

int main(void){
  int i, tmp, len, nombre;
  scanf("%d %d ", &nombre, &len);
  int *tab = calloc( len , sizeof(int));
  for (i = 0 ; i < len; i++)
  {
    scanf("%d ", &tmp);
    tab[i] = tmp;
  }
  int a = devine0(nombre, tab, len);
  if (a)
    printf("True");
  else
    printf("False");
  return 0;
}


