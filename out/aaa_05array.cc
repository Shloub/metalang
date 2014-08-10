#include <iostream>
#include <vector>
std::vector<bool> * id(std::vector<bool> * b){
  return b;
}

void g(std::vector<bool> * t, int index){
  t->at(index) = false;
}


int main(){
  int c = 5;
  std::vector<bool > *a = new std::vector<bool>( c );
  for (int i = 0 ; i < c; i++)
  {
    std::cout << i;
    a->at(i) = (i % 2) == 0;
  }
  bool d = a->at(0);
  if (d)
    std::cout << "True";
  else
    std::cout << "False";
  std::cout << "\n";
  g(id(a), 0);
  bool e = a->at(0);
  if (e)
    std::cout << "True";
  else
    std::cout << "False";
  std::cout << "\n";
  return 0;
}

