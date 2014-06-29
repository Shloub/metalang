#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>

int score(){
  scanf("%*[ \t\r\n]c");
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
  int sum = 0;
  for (int i = 1 ; i <= len; i ++)
  {
    char c = '_';
    scanf("%c", &c);
    sum += (c - 'A') + 1;
    /*		print c print " " print sum print " " */
  }
  return sum;
}


int main(){
  int sum = 0;
  int n = 0;
  scanf("%d", &n);
  for (int i = 1 ; i <= n; i ++)
    sum += i * score();
  std::cout << sum << "\n";
  return 0;
}

