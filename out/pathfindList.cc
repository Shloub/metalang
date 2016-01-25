#include <iostream>
#include <vector>
int pathfind_aux(std::vector<int> * cache, std::vector<int> * tab, int len, int pos){
  if (pos >= len - 1)
    return 0;
  else if (cache->at(pos) != -1)
    return cache->at(pos);
  else
  {
    cache->at(pos) = len * 2;
    int posval = pathfind_aux(cache, tab, len, tab->at(pos));
    int oneval = pathfind_aux(cache, tab, len, pos + 1);
    int out0 = 0;
    if (posval < oneval)
      out0 = 1 + posval;
    else
      out0 = 1 + oneval;
    cache->at(pos) = out0;
    return out0;
  }
}

int pathfind(std::vector<int> * tab, int len){
  std::vector<int> *cache = new std::vector<int>( len );
  for (int i = 0 ; i < len; i++)
    cache->at(i) = -1;
  return pathfind_aux(cache, tab, len, 0);
}


int main(){
  int len = 0;
  std::cin >> len >> std::skipws;
  std::vector<int> *tab = new std::vector<int>( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmp = 0;
    std::cin >> tmp >> std::skipws;
    tab->at(i) = tmp;
  }
  int result = pathfind(tab, len);
  std::cout << result;
  return 0;
}

