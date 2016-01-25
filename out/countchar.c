#include <stdio.h>
#include <stdlib.h>


int nth(char* tab, char tofind, int len) {
  int i;
  int out0 = 0;
  for (i = 0; i < len; i++)
    if (tab[i] == tofind)
    out0++;
  return out0;
}

int main(void) {
  int i;
  int len = 0;
  scanf("%d ", &len);
  char tofind = '\x00';
  scanf("%c ", &tofind);
  char *tab = calloc( len , sizeof(char));
  for (i = 0; i < len; i++)
  {
    char tmp = '\x00';
    scanf("%c", &tmp);
    tab[i] = tmp;
  }
  int result = nth(tab, tofind, len);
  printf("%d", result);
  return 0;
}


