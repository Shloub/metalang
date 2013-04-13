#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }

int nth(char* tab, char tofind, int len){
  int out_ = 0;
  {
    int i;
    for (i = 0 ; i <= len - 1; i++)
    {
      if (tab[i] == tofind)
      {
        out_ = out_ + 1;
      }
    }
  }
  return out_;
}

int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  char tofind = '\000';
  scanf("%c", &tofind);
  scanf("%*[ \t\r\n]c", 0);
  char *tab = malloc( (len) * sizeof(char) + sizeof(int));
  ((int*)tab)[0]=len;
  tab=(char*)( ((int*)tab)+1);
  {
    int i;
    for (i = 0 ; i <= len - 1; i++)
    {
      char tmp = '\000';
      scanf("%c", &tmp);
      tab[i] = tmp;
    }
  }
  int result = nth(tab, tofind, len);
  printf("%d", result);
  return 0;
}


