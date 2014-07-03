#include <iostream>
#include <vector>
int summax(std::vector<int >& lst, int len){
  int current = 0;
  int max_ = 0;
  for (int i = 0 ; i < len; i++)
  {
    current += lst.at(i);
    if (current < 0)
      current = 0;
    if (max_ < current)
      max_ = current;
  }
  return max_;
}


int main(){
  int len = 0;
  std::cin >> len >> std::skipws;
  std::vector<int > tab( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmp = 0;
    std::cin >> tmp >> std::skipws;
    tab.at(i) = tmp;
  }
  int result = summax(tab, len);
  std::cout << result;
  return 0;
}

