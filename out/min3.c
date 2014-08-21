#include<stdio.h>
#include<stdlib.h>

int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int main(void){
  int e = 2;
  int f = 3;
  int g = 4;
  int d = min2(min2(e, f), g);
  printf("%d ", d);
  int i = 2;
  int j = 4;
  int k = 3;
  int h = min2(min2(i, j), k);
  printf("%d ", h);
  int m = 3;
  int n = 2;
  int o = 4;
  int l = min2(min2(m, n), o);
  printf("%d ", l);
  int q = 3;
  int r = 4;
  int s = 2;
  int p = min2(min2(q, r), s);
  printf("%d ", p);
  int u = 4;
  int v = 2;
  int w = 3;
  int t = min2(min2(u, v), w);
  printf("%d ", t);
  int y = 4;
  int z = 3;
  int ba = 2;
  int x = min2(min2(y, z), ba);
  printf("%d\n", x);
  return 0;
}


