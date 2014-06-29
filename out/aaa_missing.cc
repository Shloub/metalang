#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int read_int(){
  int out_ = 0;
  scanf("%d", &out_);
  scanf("%*[ \t\r\n]c");
  return out_;
}

std::vector<int > read_int_line(int n){
  std::vector<int > tab( n );
  for (int i = 0 ; i < n; i++)
  {
    int t = 0;
    scanf("%d", &t);
    scanf("%*[ \t\r\n]c");
    tab.at(i) = t;
  }
  return tab;
}

/*
  Ce test a été généré par Metalang.
*/
int result(int len, std::vector<int >& tab){
  std::vector<bool > tab2( len );
  for (int i = 0 ; i < len; i++)
    tab2.at(i) = false;
  for (int i1 = 0 ; i1 < len; i1++)
    tab2.at(tab.at(i1)) = true;
  for (int i2 = 0 ; i2 < len; i2++)
    if (!tab2.at(i2))
    return i2;
  return -1;
}


int main(){
  int len = read_int();
  std::cout << len << "\n";
  std::vector<int > tab = read_int_line(len);
  int a = result(len, tab);
  std::cout << a;
  return 0;
}

