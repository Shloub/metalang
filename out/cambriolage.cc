#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int max2(int a, int b){
  if (a > b)
    return a;
  return b;
}

int nbPassePartout(int n, std::vector<std::vector<int > >& passepartout, int m, std::vector<std::vector<int > >& serrures){
  int max_ancient = 0;
  int max_recent = 0;
  for (int i = 0 ; i < m; i++)
  {
    if (serrures.at(i).at(0) == -1 && serrures.at(i).at(1) > max_ancient)
      max_ancient = serrures.at(i).at(1);
    if (serrures.at(i).at(0) == 1 && serrures.at(i).at(1) > max_recent)
      max_recent = serrures.at(i).at(1);
  }
  int max_ancient_pp = 0;
  int max_recent_pp = 0;
  for (int i = 0 ; i < n; i++)
  {
    std::vector<int > pp = passepartout.at(i);
    if (pp.at(0) >= max_ancient && pp.at(1) >= max_recent)
      return 1;
    max_ancient_pp = max2(max_ancient_pp, pp.at(0));
    max_recent_pp = max2(max_recent_pp, pp.at(1));
  }
  if (max_ancient_pp >= max_ancient && max_recent_pp >= max_recent)
    return 2;
  else
    return 0;
}


int main(void){
  int n = 0;
  scanf("%d", &n);
  scanf("%*[ \t\r\n]c");
  std::vector<std::vector<int > > passepartout( n );
  for (int i = 0 ; i < n; i++)
  {
    int c = 2;
    std::vector<int > out0( c );
    for (int j = 0 ; j < c; j++)
    {
      int out__ = 0;
      scanf("%d", &out__);
      scanf("%*[ \t\r\n]c");
      out0.at(j) = out__;
    }
    passepartout.at(i) = out0;
  }
  int m = 0;
  scanf("%d", &m);
  scanf("%*[ \t\r\n]c");
  std::vector<std::vector<int > > serrures( m );
  for (int k = 0 ; k < m; k++)
  {
    int d = 2;
    std::vector<int > out1( d );
    for (int l = 0 ; l < d; l++)
    {
      int out_ = 0;
      scanf("%d", &out_);
      scanf("%*[ \t\r\n]c");
      out1.at(l) = out_;
    }
    serrures.at(k) = out1;
  }
  int e = nbPassePartout(n, passepartout, m, serrures);
  std::cout << e;
  return 0;
}

