#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int* copytab(int* tab, int len){
  int i;
  int *o = malloc( len * sizeof(int));
  for (i = 0 ; i < len; i++)
    o[i] = tab[i];
  return o;
}

void bubblesort(int* tab, int len){
  int i, j;
  for (i = 0 ; i < len; i++)
    for (j = i + 1 ; j < len; j++)
      if (tab[i] > tab[j])
  {
    int tmp = tab[i];
    tab[i] = tab[j];
    tab[j] = tmp;
  }
}

void qsort_(int* tab, int len, int i, int j){
  if (i < j)
  {
    int i0 = i;
    int j0 = j;
    /* pivot : tab[0] */
    while (i != j)
      if (tab[i] > tab[j])
    {
      if (i == j - 1)
      {
        /* on inverse simplement*/
        int tmp = tab[i];
        tab[i] = tab[j];
        tab[j] = tmp;
        i ++;
      }
      else
      {
        /* on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] */
        int tmp = tab[i];
        tab[i] = tab[j];
        tab[j] = tab[i + 1];
        tab[i + 1] = tmp;
        i ++;
      }
    }
    else
      j --;
    qsort_(tab, len, i0, i - 1);
    qsort_(tab, len, i + 1, j0);
  }
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i, i_;
  int len = 2;
  scanf("%d ", &len);
  int *tab = malloc( len * sizeof(int));
  for (i_ = 0 ; i_ < len; i_++)
  {
    int tmp = 0;
    scanf("%d ", &tmp);
    tab[i_] = tmp;
  }
  int* tab2 = copytab(tab, len);
  bubblesort(tab2, len);
  for (i = 0 ; i < len; i++)
  {
    printf("%d ", tab2[i]);
  }
  printf("\n");
  int* tab3 = copytab(tab, len);
  qsort_(tab3, len, 0, len - 1);
  for (i = 0 ; i < len; i++)
  {
    printf("%d ", tab3[i]);
  }
  printf("\n");
  [pool drain];
  return 0;
}


