#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
void sort_(std::vector<int >& tab, int len){
  for (int i = 0 ; i < len; i++)
    for (int j = i + 1 ; j < len; j++)
      if (tab.at(i) > tab.at(j))
  {
    int tmp = tab.at(i);
    tab.at(i) = tab.at(j);
    tab.at(j) = tmp;
  }
}


int main(void){
  int len = 2;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  std::vector<int > tab( len );
  for (int i_ = 0 ; i_ < len; i_++)
  {
    int tmp = 0;
    scanf("%d", &tmp);
    scanf("%*[ \t\r\n]c", 0);
    tab.at(i_) = tmp;
  }
  sort_(tab, len);
  for (int i = 0 ; i < len; i++)
  {
    int a = tab.at(i);
    printf("%d", a);
  }
  return 0;
}

