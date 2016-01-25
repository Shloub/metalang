#include <iostream>
#include <vector>
int result(int sum, std::vector<int> * t, int maxIndex, std::vector<std::vector<int> *> * cache){
  if (cache->at(sum)->at(maxIndex) != 0)
    return cache->at(sum)->at(maxIndex);
  else if (sum == 0 || maxIndex == 0)
    return 1;
  else
  {
    int out0 = 0;
    int div = sum / t->at(maxIndex);
    for (int i = 0 ; i <= div; i ++)
      out0 += result(sum - i * t->at(maxIndex), t, maxIndex - 1, cache);
    cache->at(sum)->at(maxIndex) = out0;
    return out0;
  }
}


int main(){
  std::vector<int> *t = new std::vector<int>( 8 );
  std::fill(t->begin(), t->end(), 0);
  t->at(0) = 1;
  t->at(1) = 2;
  t->at(2) = 5;
  t->at(3) = 10;
  t->at(4) = 20;
  t->at(5) = 50;
  t->at(6) = 100;
  t->at(7) = 200;
  std::vector<std::vector<int> *> *cache = new std::vector<std::vector<int> *>( 201 );
  for (int j = 0 ; j < 201; j++)
  {
    std::vector<int> *o = new std::vector<int>( 8 );
    std::fill(o->begin(), o->end(), 0);
    cache->at(j) = o;
  }
  std::cout << result(200, t, 7, cache);
}

