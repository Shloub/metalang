#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int go_(std::vector<int >& tab, int a, int b){
  int m = (a + b) / 2;
  if (a == m)
  {
    if (tab.at(a) == m)
      return b;
    else
      return a;
  }
  int i = a;
  int j = b;
  while (i < j)
  {
    int e = tab.at(i);
    if (e < m)
      i ++;
    else
    {
      j --;
      tab.at(i) = tab.at(j);
      tab.at(j) = e;
    }
  }
  if (i < m)
    return go_(tab, a, m);
  else
    return go_(tab, m, b);
}

int plus_petit_(std::vector<int >& tab, int len){
  return go_(tab, 0, len);
}


int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
  std::vector<int > tab( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmp = 0;
    scanf("%d", &tmp);
    scanf("%*[ \t\r\n]c");
    tab.at(i) = tmp;
  }
  int c = plus_petit_(tab, len);
  std::cout << c;
  return 0;
}

