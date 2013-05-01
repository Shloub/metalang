#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int summax(std::vector<int >& lst, int len){
  int current = 0;
  int max_ = 0;
  for (int i = 0 ; i < len; i++)
  {
    current = current + lst.at(i);
    if (current < 0)
      current = 0;
    if (max_ < current)
      max_ = current;
  }
  return max_;
}


int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  std::vector<int > tab( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmp = 0;
    scanf("%d", &tmp);
    scanf("%*[ \t\r\n]c", 0);
    tab.at(i) = tmp;
  }
  int result = summax(tab, len);
  printf("%d", result);
  return 0;
}

