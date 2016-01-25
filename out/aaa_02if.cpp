#include <iostream>
#include <vector>
bool f(int i){
  if (i == 0)
    return true;
  return false;
}


int main(){
  if (f(4))
    std::cout << "true <-\n ->\n";
  else
    std::cout << "false <-\n ->\n";
  std::cout << "small test end\n";
}

