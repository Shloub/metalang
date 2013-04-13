#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int fibo_(int a, int b, int i){
  int out_ = 0;
  int a2 = a;
  int b2 = b;
  for (int j = 0 ; j <= i + 1; j ++)
  {
    out_ = out_ + a2;
    int tmp = b2;
    b2 = b2 + a2;
    a2 = tmp;
  }
  return out_;
}


int main(void){
  int a = 0;
  int b = 0;
  int i = 0;
  scanf("%d", &a);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &b);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &i);
  int e = fibo_(a, b, i);
  printf("%d", e);
  return 0;
}

