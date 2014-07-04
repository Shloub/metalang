#include <iostream>
#include <vector>
int max2(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int pgcd(int a, int b){
  int c = min2(a, b);
  int d = max2(a, b);
  int reste = d % c;
  if (reste == 0)
    return c;
  else
    return pgcd(c, reste);
}


int main(){
  int top = 1;
  int bottom = 1;
  for (int i = 1 ; i <= 9; i ++)
    for (int j = 1 ; j <= 9; j ++)
      for (int k = 1 ; k <= 9; k ++)
        if (i != j && j != k)
  {
    int a = i * 10 + j;
    int b = j * 10 + k;
    if (a * k == i * b)
    {
      std::cout << a << "/" << b << "\n";
      top *= a;
      bottom *= b;
    }
  }
  std::cout << top << "/" << bottom << "\n";
  int p = pgcd(top, bottom);
  std::cout << "pgcd=" << p << "\n";
  int e = bottom / p;
  std::cout << e << "\n";
  return 0;
}

