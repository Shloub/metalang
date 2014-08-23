#include <iostream>
#include <vector>
std::vector<std::vector<int> *> * read_int_matrix(int x, int y){
  std::vector<std::vector<int> * > *tab = new std::vector<std::vector<int> *>( y );
  for (int z = 0 ; z < y; z++)
  {
    std::vector<int > *b = new std::vector<int>( x );
    for (int c = 0 ; c < x; c++)
    {
      int d = 0;
      std::cin >> d >> std::skipws;
      b->at(c) = d;
    }
    std::vector<int> * a = b;
    tab->at(z) = a;
  }
  return tab;
}


int main(){
  int f = 0;
  std::cin >> f >> std::skipws;
  int len = f;
  std::cout << len << "=len\n";
  std::vector<int > *h = new std::vector<int>( len );
  for (int k = 0 ; k < len; k++)
  {
    int l = 0;
    std::cin >> l >> std::skipws;
    h->at(k) = l;
  }
  std::vector<int> * tab1 = h;
  for (int i = 0 ; i < len; i++)
  {
    std::cout << i << "=>" << tab1->at(i) << "\n";
  }
  int o = 0;
  std::cin >> o >> std::skipws;
  len = o;
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

