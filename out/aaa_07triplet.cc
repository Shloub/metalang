#include <iostream>
#include <vector>

int main(){
  int c, b, a;
  for (int i = 1 ; i <= 3; i ++)
  {
    std::cin >> a >> std::skipws >> b >> c;
    std::cout << "a = " << a << " b = " << b << "c =" << c << "\n";
  }
  std::vector<int > *l = new std::vector<int>( 10 );
  for (int d = 0 ; d < 10; d++)
  {
    std::cin >> l->at(d) >> std::skipws;
  }
  for (int j = 0 ; j <= 9; j ++)
  {
    std::cout << l->at(j) << "\n";
  }
  return 0;
}

