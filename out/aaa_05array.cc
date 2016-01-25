#include <iostream>
#include <vector>
std::vector<bool> * id(std::vector<bool> * b) {
  return b;
}

void g(std::vector<bool> * t, int index) {
  t->at(index) = false;
}


int main() {
  int j = 0;
  std::vector<bool> *a = new std::vector<bool>( 5 );
  for (int i = 0; i < 5; i++)
  {
    std::cout << i;
    j += i;
    a->at(i) = i % 2 == 0;
  }
  std::cout << j << " ";
  if (a->at(0))
    std::cout << "True";
  else
    std::cout << "False";
  std::cout << "\n";
  g(id(a), 0);
  if (a->at(0))
    std::cout << "True";
  else
    std::cout << "False";
  std::cout << "\n";
}

