#include <stdio.h>
#include <stdlib.h>

int is_number(char c){
  return (int)(c) <= (int)('9') && (int)(c) >= (int)('0');
}

/*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/
int npi0(char* str, int len){
  int i;
  int *stack = malloc( len * sizeof(int));
  for (i = 0 ; i < len; i++)
    stack[i] = 0;
  int ptrStack = 0;
  int ptrStr = 0;
  while (ptrStr < len)
    if (str[ptrStr] == ' ')
    ptrStr ++;
  else if (is_number(str[ptrStr]))
  {
    int num = 0;
    while (str[ptrStr] != ' ')
    {
      num = num * 10 + (int)(str[ptrStr]) - (int)('0');
      ptrStr ++;
    }
    stack[ptrStack] = num;
    ptrStack ++;
  }
  else if (str[ptrStr] == '+')
  {
    stack[ptrStack - 2] = stack[ptrStack - 2] + stack[ptrStack - 1];
    ptrStack --;
    ptrStr ++;
  }
  return stack[0];
}

int main(void){
  int i;
  int len = 0;
  scanf("%d ", &len);
  char *tab = malloc( len * sizeof(char));
  for (i = 0 ; i < len; i++)
  {
    char tmp = '\x00';
    scanf("%c", &tmp);
    tab[i] = tmp;
  }
  int result = npi0(tab, len);
  printf("%d", result);
  return 0;
}


