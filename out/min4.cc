#include <iostream>
#include <vector>
int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}


int main(){
  std::cout << min2(min2(min2(1, 2), 3), 4) << " " << min2(min2(min2(1, 2), 4), 3) << " " << min2(min2(min2(1, 3), 2), 4) << " " << min2(min2(min2(1, 3), 4), 2) << " " << min2(min2(min2(1, 4), 2), 3) << " " << min2(min2(min2(1, 4), 3), 2) << "\n" << min2(min2(min2(2, 1), 3), 4) << " " << min2(min2(min2(2, 1), 4), 3) << " " << min2(min2(min2(2, 3), 1), 4) << " " << min2(min2(min2(2, 3), 4), 1) << " " << min2(min2(min2(2, 4), 1), 3) << " " << min2(min2(min2(2, 4), 3), 1) << "\n" << min2(min2(min2(3, 1), 2), 4) << " " << min2(min2(min2(3, 1), 4), 2) << " " << min2(min2(min2(3, 2), 1), 4) << " " << min2(min2(min2(3, 2), 4), 1) << " " << min2(min2(min2(3, 4), 1), 2) << " " << min2(min2(min2(3, 4), 2), 1) << "\n" << min2(min2(min2(4, 1), 2), 3) << " " << min2(min2(min2(4, 1), 3), 2) << " " << min2(min2(min2(4, 2), 1), 3) << " " << min2(min2(min2(4, 2), 3), 1) << " " << min2(min2(min2(4, 3), 1), 2) << " " << min2(min2(min2(4, 3), 2), 1) << "\n";
  return 0;
}

