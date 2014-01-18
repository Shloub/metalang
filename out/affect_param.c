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
void foo(int a){
  a = 4;
}

int main(void){
  int a = 0;
  foo(a);
  printf("%d", a);
  printf("%s", "\n");
  return 0;
}


