#include <iostream>
#include <vector>
int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}


int main(){
  std::cout << min2(min2(2, 3), 4) << " " << min2(min2(2, 4), 3) << " " << min2(min2(3, 2), 4) << " " << min2(min2(3, 4), 2) << " " << min2(min2(4, 2), 3) << " " << min2(min2(4, 3), 2) << "\n";
  return 0;
}

