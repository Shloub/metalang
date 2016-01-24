#include <iostream>
#include <vector>
int result(int sum, std::vector<int >& t, int maxIndex, std::vector<std::vector<int > >& cache){
  if (cache[sum][maxIndex] != 0)
    return cache[sum][maxIndex];
  else if (sum == 0 || maxIndex == 0)
    return 1;
  else
  {
    int out0 = 0;
    int div = sum / t[maxIndex];
    for (int i = 0 ; i <= div; i ++)
      out0 += result(sum - i * t[maxIndex], t, maxIndex - 1, cache);
    cache[sum][maxIndex] = out0;
    return out0;
  }
}


int main(){
  std::vector<int > t(8, 0);
  t[0] = 1;
  t[1] = 2;
  t[2] = 5;
  t[3] = 10;
  t[4] = 20;
  t[5] = 50;
  t[6] = 100;
  t[7] = 200;
  std::vector<std::vector<int > > cache(201);
  for (int j = 0 ; j < 201; j++)
  {
    std::vector<int > o(8, 0);
    cache[j] = o;
  }
  std::cout << result(200, t, 7, cache);
  return 0;
}

