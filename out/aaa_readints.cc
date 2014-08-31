#include <iostream>
#include <vector>

int main(){
  int w, f;
  std::cin >> f >> std::skipws;
  int len = f;
  std::cout << len << "=len\n";
  std::vector<int > *h = new std::vector<int>( len );
  for (int k = 0 ; k < len; k++)
  {
    std::cin >> h->at(k) >> std::skipws;
  }
  std::vector<int> * tab1 = h;
  for (int i = 0 ; i < len; i++)
  {
    std::cout << i << "=>" << tab1->at(i) << "\n";
  }
  std::cin >> len >> std::skipws;
  std::vector<std::vector<int> * > *r = new std::vector<std::vector<int> *>( len - 1 );
  for (int s = 0 ; s < len - 1; s++)
  {
    std::vector<int > *u = new std::vector<int>( len );
    for (int v = 0 ; v < len; v++)
    {
      std::cin >> w >> std::skipws;
      u->at(v) = w;
    }
    r->at(s) = u;
  }
  std::vector<std::vector<int> *> * tab2 = r;
  for (int i = 0 ; i <= len - 2; i ++)
  {
    for (int j = 0 ; j < len; j++)
    {
      std::cout << tab2->at(i)->at(j) << " ";
    }
    std::cout << "\n";
  }
  return 0;
}

