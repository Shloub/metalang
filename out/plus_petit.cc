#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int go(std::vector<int >& tab, int a, int b){
  int m = (a + b) / 2;
  if (a == m)
  {
    if (tab.at(a) == m)
    {
      return b;
    }
    else
    {
      return a;
    }
  }
  int i = a;
  int j = b;
  while (i < j)
  {
    int e = tab.at(i);
    if (e < m)
    {
      i = i + 1;
    }
    else
    {
      j = j - 1;
      tab.at(i) = tab.at(j);
      tab.at(j) = e;
    }
  }
  if (i < m)
  {
    return go(tab, a, m);
  }
  else
  {
    return go(tab, m, b);
  }
}

int plus_petit_(std::vector<int >& tab, int len){
  return go(tab, 0, len);
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
  int g = plus_petit_(tab, len);
  printf("%d", g);
  return 0;
}

