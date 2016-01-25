#include <iostream>
#include <vector>
int exp0(int a, int e){
  int o = 1;
  for (int i = 1 ; i <= e; i ++)
    o *= a;
  return o;
}

int e(std::vector<int> * t, int n){
  for (int i = 1 ; i <= 8; i ++)
    if (n >= t->at(i) * i)
    n -= t->at(i) * i;
  else
  {
    int nombre = exp0(10, i - 1) + n / i;
    int chiffre = i - 1 - n % i;
    return nombre / exp0(10, chiffre) % 10;
  }
  return -1;
}


int main(){
  std::vector<int> *t = new std::vector<int>( 9 );
  for (int i = 0 ; i < 9; i++)
    t->at(i) = exp0(10, i) - exp0(10, i - 1);
  for (int i2 = 1 ; i2 <= 8; i2 ++)
    std::cout << i2 << " => " << t->at(i2) << "\n";
  for (int j = 0 ; j <= 80; j ++)
    std::cout << e(t, j);
  std::cout << "\n";
  for (int k = 1 ; k <= 50; k ++)
    std::cout << k;
  std::cout << "\n";
  for (int j2 = 169 ; j2 <= 220; j2 ++)
    std::cout << e(t, j2);
  std::cout << "\n";
  for (int k2 = 90 ; k2 <= 110; k2 ++)
    std::cout << k2;
  std::cout << "\n";
  int out0 = 1;
  for (int l = 0 ; l <= 6; l ++)
  {
    int puiss = exp0(10, l);
    int v = e(t, puiss - 1);
    out0 *= v;
    std::cout << "10^" << l << "=" << puiss << " v=" << v << "\n";
  }
  std::cout << out0 << "\n";
  return 0;
}

