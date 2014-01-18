#include<stdio.h>
#include<stdlib.h>

typedef enum lng {
  LANG_C,
  LANG_Pas,
  LANG_Cc,
  LANG_Cs,
  LANG_Java,
  LANG_Js,
  LANG_Ml,
  LANG_Php,
  LANG_Rb,
  LANG_Py,
  LANG_Tex,
  LANG_Metalang
} lng;
int main(void){
  int i = 0;
  i ++;
  printf("%d", i);
  i += 55;
  printf("%d", i);
  i *= 13;
  printf("%d", i);
  i /= 2;
  printf("%d", i);
  i ++;
  printf("%d", i);
  i /= 3;
  printf("%d", i);
  i --;
  printf("%d", i);
  return 0;
}


