#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int nth(std::vector<char >& tab, char tofind, int len){
  int out_ = 0;
  for (int i = 0 ; i < len; i++)
    if (tab.at(i) == tofind)
    out_ ++;
  return out_;
}


int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  char tofind = '\000';
  scanf("%c", &tofind);
  scanf("%*[ \t\r\n]c", 0);
  std::vector<char > tab( len );
  for (int i = 0 ; i < len; i++)
  {
    char tmp = '\000';
    scanf("%c", &tmp);
    tab.at(i) = tmp;
  }
  int result = nth(tab, tofind, len);
  printf("%d", result);
  return 0;
}

