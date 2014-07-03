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
      j --;
    j ++;
    tab.at(len - j) = x;
    if (j > max_)
      max_ = j;
    i --;
  }
  return max_;
}


int main(){
  int len = 0;
  std::cin >> len >> std::skipws;
  std::vector<int > tab( len );
  for (int i = 0 ; i < len; i++)
  {
    int x = 0;
    std::cin >> x >> std::skipws;
    tab.at(i) = x;
  }
  int a = montagnes_(tab, len);
  std::cout << a;
  return 0;
}

