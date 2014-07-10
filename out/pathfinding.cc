#include <iostream>
#include <vector>
int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int min3(int a, int b, int c){
  return min2(min2(a, b), c);
}

int min4(int a, int b, int c, int d){
  int f = min2(a, b);
  int e = min2(min2(f, c), d);
  return e;
}

int pathfind_aux(std::vector<std::vector<int > >& cache, std::vector<std::vector<char > >& tab, int x, int y, int posX, int posY){
  if (posX == x - 1 && posY == y - 1)
    return 0;
  else if (posX < 0 || posY < 0 || posX >= x || posY >= y)
    return x * y * 10;
  else if (tab.at(posY).at(posX) == '#')
    return x * y * 10;
  else if (cache.at(posY).at(posX) != -1)
    return cache.at(posY).at(posX);
  else
  {
    cache.at(posY).at(posX) = x * y * 10;
    int val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY);
    int val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY);
    int val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1);
    int val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1);
    int h = min2(val1, val2);
    int k = min2(min2(h, val3), val4);
    int g = k;
    int out_ = 1 + g;
    cache.at(posY).at(posX) = out_;
    return out_;
  }
}

int pathfind(std::vector<std::vector<char > >& tab, int x, int y){
  std::vector<std::vector<int > > cache( y );
  for (int i = 0 ; i < y; i++)
  {
    std::vector<int > tmp( x );
    for (int j = 0 ; j < x; j++)
      tmp.at(j) = -1;
    cache.at(i) = tmp;
  }
  return pathfind_aux(cache, tab, x, y, 0, 0);
}


int main(){
  int x = 0;
  int y = 0;
  std::cin >> x >> std::skipws >> y;
  std::vector<std::vector<char > > tab( y );
  for (int i = 0 ; i < y; i++)
  {
    std::vector<char > tab2( x );
    for (int j = 0 ; j < x; j++)
    {
      char tmp = '\000';
      std::cin >> tmp >> std::noskipws;
      tab2.at(j) = tmp;
    }
    std::cin >> std::skipws;
    tab.at(i) = tab2;
  }
  int result = pathfind(tab, x, y);
  std::cout << result;
  return 0;
}

