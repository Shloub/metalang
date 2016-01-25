#include <iostream>
#include <vector>
int periode(std::vector<int> * restes, int len, int a, int b){
  while (a != 0)
  {
    int chiffre = a / b;
    int reste = a % b;
    for (int i = 0 ; i < len; i++)
      if (restes->at(i) == reste)
      return len - i;
    restes->at(len) = reste;
    len++;
    a = reste * 10;
  }
  return 0;
}


int main(){
  std::vector<int> *t = new std::vector<int>( 1000 );
  std::fill(t->begin(), t->end(), 0);
  int m = 0;
  int mi = 0;
  for (int i = 1 ; i <= 1000; i ++)
  {
    int p = periode(t, 0, 1, i);
    if (p > m)
    {
      mi = i;
      m = p;
    }
  }
  std::cout << mi << "\n" << m << "\n";
}

