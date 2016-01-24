#include <iostream>
#include <vector>
std::vector<std::vector<int> > read_int_matrix(int x, int y){
  std::vector<std::vector<int> > matrix(y);
  for (int i = 0; i < y; i++)
  {
    std::vector<int>& line = matrix[i];
    line.resize(x);
    for (int j = 0; j < x; j++)
    {
        std::cin >> line[j] >> std::skipws;
    }
  }
  return matrix;
}

int main(){
  int len;
  std::cin >> len >> std::skipws;
  std::cout << len << "=len\n";
  std::vector<int > tab1(len);
  for (int a = 0 ; a < len; a++)
  {
    std::cin >> tab1[a] >> std::skipws;
  }
  for (int i = 0 ; i < len; i++)
    std::cout << i << "=>" << tab1[i] << "\n";
  std::cin >> len >> std::skipws;
  std::vector<std::vector<int > > tab2 = read_int_matrix(len, len - 1);
  for (int i = 0 ; i <= len - 2; i ++)
  {
    for (int j = 0 ; j < len; j++)
      std::cout << tab2[i][j] << " ";
    std::cout << "\n";
  }
  return 0;
}

