#include <iostream>
#include <vector>

int main(){
  std::cout << "Hello World";
  int a = 5;
  std::cout << (4 + 6) * 2 << " " << "\n" << a << "foo" << "";
  bool b = 1 + (1 + 1) * 2 * (3 + 8) / 4 - (1 - 2) - 3 == 12 && true;
  if (b)
    std::cout << "True";
  else
    std::cout << "False";
  std::cout << "\n";
  bool c = (3 * (4 + 5 + 6) * 2 == 45) == false;
  if (c)
    std::cout << "True";
  else
    std::cout << "False";
  std::cout << " ";
  bool d = (2 == 1) == false;
  if (d)
    std::cout << "True";
  else
    std::cout << "False";
  std::cout << " " << (4 + 1) / 3 / (2 + 1) << 4 * 1 / 3 / 2 * 1;
  bool e = !(!(a == 0) && !(a == 4));
  if (e)
    std::cout << "True";
  else
    std::cout << "False";
  bool f = true && !false && !(true && false);
  if (f)
    std::cout << "True";
  else
    std::cout << "False";
  std::cout << "\n";
  return 0;
}

