#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
/* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
*/
int find0(int len, std::vector<std::vector<int > >& tab, std::vector<std::vector<int > >& cache, int x, int y){
  /*
	Cette fonction est récursive
	*/
  if (y == len - 1)
    return tab.at(y).at(x);
  else if (x > y)
    return -10000;
  else if (cache.at(y).at(x) != 0)
    return cache.at(y).at(x);
  int result = 0;
  int out0 = find0(len, tab, cache, x, y + 1);
  int out1 = find0(len, tab, cache, x + 1, y + 1);
  if (out0 > out1)
    result = out0 + tab.at(y).at(x);
  else
    result = out1 + tab.at(y).at(x);
  cache.at(y).at(x) = result;
  return result;
}

int find(int len, std::vector<std::vector<int > >& tab){
  std::vector<std::vector<int > > tab2( len );
  for (int i = 0 ; i < len; i++)
  {
    int a = i + 1;
    std::vector<int > tab3( a );
    for (int j = 0 ; j < a; j++)
      tab3.at(j) = 0;
    tab2.at(i) = tab3;
  }
  return find0(len, tab, tab2, 0, 0);
}


int main(){
  int len = 0;
  std::cin >> len >> std::skipws;
  std::vector<std::vector<int > > tab( len );
  for (int i = 0 ; i < len; i++)
  {
    int b = i + 1;
    std::vector<int > tab2( b );
    for (int j = 0 ; j < b; j++)
    {
      int tmp = 0;
      std::cin >> tmp >> std::skipws;
      tab2.at(j) = tmp;
    }
    tab.at(i) = tab2;
  }
  int c = find(len, tab);
  std::cout << c << "\n";
  for (int k = 0 ; k < len; k++)
  {
    for (int l = 0 ; l <= k; l ++)
    {
      int d = tab.at(k).at(l);
      std::cout << d << " ";
    }
    std::cout << "\n";
  }
  return 0;
}

