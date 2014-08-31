#include <iostream>
#include <vector>
int min2_(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int pathfind_aux(std::vector<std::vector<int> *> * cache, std::vector<std::vector<char> *> * tab, int x, int y, int posX, int posY){
  if (posX == x - 1 && posY == y - 1)
    return 0;
  else if (posX < 0 || posY < 0 || posX >= x || posY >= y)
    return x * y * 10;
  else if (tab->at(posY)->at(posX) == '#')
    return x * y * 10;
  else if (cache->at(posY)->at(posX) != -1)
    return cache->at(posY)->at(posX);
  else
  {
    cache->at(posY)->at(posX) = x * y * 10;
    int val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY);
    int val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY);
    int val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1);
    int val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1);
    int n = min2_(val1, val2);
    int o = min2_(n, val3);
    int p = min2_(o, val4);
    int q = p;
    int m = q;
    int out_ = 1 + m;
    cache->at(posY)->at(posX) = out_;
    return out_;
  }
}

int pathfind(std::vector<std::vector<char> *> * tab, int x, int y){
  std::vector<std::vector<int> * > *cache = new std::vector<std::vector<int> *>( y );
  for (int i = 0 ; i < y; i++)
  {
    std::vector<int > *tmp = new std::vector<int>( x );
    for (int j = 0 ; j < x; j++)
      tmp->at(j) = -1;
    cache->at(i) = tmp;
  }
  return pathfind_aux(cache, tab, x, y, 0, 0);
}


int main(){
  int x = 0;
  int y = 0;
  std::cin >> x >> std::skipws >> y;
  std::vector<std::vector<char> * > *tab = new std::vector<std::vector<char> *>( y );
  for (int i = 0 ; i < y; i++)
  {
    std::vector<char > *tab2 = new std::vector<char>( x );
    for (int j = 0 ; j < x; j++)
    {
      char tmp = '\000';
      std::cin >> tmp >> std::noskipws;
      tab2->at(j) = tmp;
    }
    std::cin >> std::skipws;
    tab->at(i) = tab2;
  }
  int result = pathfind(tab, x, y);
  std::cout << result;
  return 0;
}

