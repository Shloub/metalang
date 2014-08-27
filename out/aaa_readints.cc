#include <iostream>
#include <vector>
std::vector<std::vector<int> *> * read_int_matrix(int x, int y){
  int d;
  std::vector<std::vector<int> * > *tab = new std::vector<std::vector<int> *>( y );
  for (int z = 0 ; z < y; z++)
  {
    std::vector<int > *b = new std::vector<int>( x );
    for (int c = 0 ; c < x; c++)
    {
      std::cin >> d >> std::skipws;
      b->at(c) = d;
    }
    tab->at(z) = b;
  }
  return tab;
}


int main(){
  int f;
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
  std::vector<std::vector<int> *> * tab2 = read_int_matrix(len, len - 1);
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

