#include <iostream>
#include <vector>
int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int min3_(int a, int b, int c){
  return min2(min2(a, b), c);
}


int main(){
  int e = 2;
  int f = 3;
  int g = 4;
  int d = min2(min2(e, f), g);
  std::cout << d << " ";
  int i = 2;
  int j = 4;
  int k = 3;
  int h = min2(min2(i, j), k);
  std::cout << h << " ";
  int m = 3;
  int n = 2;
  int o = 4;
  int l = min2(min2(m, n), o);
  std::cout << l << " ";
  int q = 3;
  int r = 4;
  int s = 2;
  int p = min2(min2(q, r), s);
  std::cout << p << " ";
  int u = 4;
  int v = 2;
  int w = 3;
  int t = min2(min2(u, v), w);
  std::cout << t << " ";
  int y = 4;
  int z = 3;
  int ba = 2;
  int x = min2(min2(y, z), ba);
  std::cout << x << "\n";
  return 0;
}

