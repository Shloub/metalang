#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int montagnes_(std::vector<int >& tab, int len){
  int max_ = 1;
  int j = 1;
  int i = len - 2;
  while (i >= 0)
  {
    int x = tab.at(i);
    while (j >= 0 && x > tab.at(len - j))
    {
      j = j - 1;
    }
    j = j + 1;
    tab.at(len - j) = x;
    if (j > max_)
    {
      max_ = j;
    }
    i = i - 1;
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
    int x = 0;
    scanf("%d", &x);
    scanf("%*[ \t\r\n]c", 0);
    tab.at(i) = x;
  }
  int d = montagnes_(tab, len);
  printf("%d", d);
  return 0;
}

