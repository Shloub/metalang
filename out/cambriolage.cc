#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int max2(int a, int b){
  if (a > b)
  {
    return a;
  }
  return b;
}

int nbPassePartout(int n, std::vector<std::vector<int > >& passepartout, int m, std::vector<std::vector<int > >& serrures){
  int max_ancient = 0;
  int max_recent = 0;
  for (int i = 0 ; i <= m - 1; i ++)
  {
    if ((serrures.at(i).at(0) == (-1)) && (serrures.at(i).at(1) > max_ancient))
    {
      max_ancient = serrures.at(i).at(1);
    }
    if ((serrures.at(i).at(0) == 1) && (serrures.at(i).at(1) > max_recent))
    {
      max_recent = serrures.at(i).at(1);
    }
  }
  int max_ancient_pp = 0;
  int max_recent_pp = 0;
  for (int i = 0 ; i <= n - 1; i ++)
  {
    std::vector<int > pp = passepartout.at(i);
    if ((pp.at(0) >= max_ancient) && (pp.at(1) >= max_recent))
    {
      return 1;
    }
    max_ancient_pp = max2(max_ancient_pp, pp.at(0));
    max_recent_pp = max2(max_recent_pp, pp.at(1));
  }
  if ((max_ancient_pp >= max_ancient) && (max_recent_pp >= max_recent))
  {
    return 2;
  }
  else
  {
    return 0;
  }
}


int main(void){
  int n = 0;
  scanf("%d", &n);
  scanf("%*[ \t\r\n]c", 0);
  std::vector<std::vector<int > > passepartout( n );
  for (int i = 0 ; i <= n - 1; i ++)
  {
    int o = 2;
    std::vector<int > out0( o );
    for (int j = 0 ; j <= o - 1; j ++)
    {
      int out_ = 0;
      scanf("%d", &out_);
      scanf("%*[ \t\r\n]c", 0);
      out0.at(j) = out_;
    }
    passepartout.at(i) = out0;
  }
  int m = 0;
  scanf("%d", &m);
  scanf("%*[ \t\r\n]c", 0);
  std::vector<std::vector<int > > serrures( m );
  for (int i = 0 ; i <= m - 1; i ++)
  {
    int p = 2;
    std::vector<int > out0( p );
    for (int j = 0 ; j <= p - 1; j ++)
    {
      int out_ = 0;
      scanf("%d", &out_);
      scanf("%*[ \t\r\n]c", 0);
      out0.at(j) = out_;
    }
    serrures.at(i) = out0;
  }
  int q = nbPassePartout(n, passepartout, m, serrures);
  printf("%d", q);
  return 0;
}

