#include<stdio.h>
#include<stdlib.h>

int nth_(char* tab, char tofind, int len){
  int out_ = 0;
  {
    int i;
    for (i = 0 ; i < len; i++)
      if (tab[i] == tofind)
      out_ ++;
  }
  return out_;
}

int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
  char tofind = '\000';
  scanf("%c", &tofind);
  scanf("%*[ \t\r\n]c");
  char *tab = malloc( len * sizeof(char));
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      char tmp = '\000';
      scanf("%c", &tmp);
      tab[i] = tmp;
    }
  }
  int result = nth_(tab, tofind, len);
  printf("%d", result);
  return 0;
}


