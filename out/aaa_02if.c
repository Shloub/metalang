#include <stdio.h>
#include <stdlib.h>

int f(int i){
  if (i == 0)
    return 1;
  return 0;
}

int main(void){
  if (f(4))
    printf("true <-\n ->\n");
  else
    printf("false <-\n ->\n");
  printf("small test end\n");
  return 0;
}


