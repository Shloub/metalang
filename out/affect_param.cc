#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
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
  std::cout << "\n";
  return 0;
}

