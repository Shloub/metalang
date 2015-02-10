#include <iostream>
#include <vector>

int main(){
  int b, a;
  for (int i = 1 ; i <= 3; i ++)
  {
    std::cin >> a >> std::skipws >> b;
    std::cout << "a = " << a << " b = " << b << "\n";
  }
  std::vector<int > *l = new std::vector<int>( 10 );
  for (int k = 0 ; k < 10; k++)
  {
    std::cin >> l->at(k) >> std::skipws;
  }
  for (int j = 0 ; j <= 9; j ++)
  {
    std::cout << l->at(j) << "\n";
  }
  return 0;
}

