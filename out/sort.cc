#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
void sort_(std::vector<int >& tab, int len){
  for (int i = 0 ; i <= len - 1; i ++)
  {
    for (int j = i + 1 ; j <= len - 1; j ++)
    {
      if (tab.at(i) > tab.at(j))
      {
        int tmp = tab.at(i);
        tab.at(i) = tab.at(j);
        tab.at(j) = tmp;
      }
    }
  }
}


int main(void){
  int len = 2;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  std::vector<int > tab( len );
  for (int i = 0 ; i <= len - 1; i ++)
  {
    int tmp = 0;
    scanf("%d", &tmp);
    scanf("%*[ \t\r\n]c", 0);
    tab.at(i) = tmp;
  }
  sort_(tab, len);
  for (int f = 0 ; f <= (tab.size()) - 1; f ++)
  {
    printf("%d", tab.at(f));
  }
  return 0;
}

