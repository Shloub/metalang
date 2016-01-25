#include <iostream>
#include <vector>

template <typename T> std::vector<std::vector<T>> read_matrix(int l, int c) {
  std::vector<std::vector<T>> matrix(l, std::vector<T>(c));
  std::cin >> std::skipws;
  for (std::vector<T>& line : matrix)
    for (T& elem : line)
      std::cin >> elem;
  return matrix;
}

int max2_(int a, int b) {
  if (a > b)
    return a;
  else
    return b;
}


int find(int n, std::vector<std::vector<int>>& m, int x, int y, int dx, int dy) {
  if (x < 0 || x == 20 || y < 0 || y == 20)
    return -1;
  else if (n == 0)
    return 1;
  else
    return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy);
}

struct tuple_int_int {
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
};


int main() {
  std::vector<tuple_int_int> directions(8);
  for (int i = 0; i < 8; i++)
    if (i == 0)
  {
    tuple_int_int c;
    c.tuple_int_int_field_0 = 0;
    c.tuple_int_int_field_1 = 1;
    directions[i] = c;
  }
  else if (i == 1)
  {
    tuple_int_int d;
    d.tuple_int_int_field_0 = 1;
    d.tuple_int_int_field_1 = 0;
    directions[i] = d;
  }
  else if (i == 2)
  {
    tuple_int_int e;
    e.tuple_int_int_field_0 = 0;
    e.tuple_int_int_field_1 = -1;
    directions[i] = e;
  }
  else if (i == 3)
  {
    tuple_int_int f;
    f.tuple_int_int_field_0 = -1;
    f.tuple_int_int_field_1 = 0;
    directions[i] = f;
  }
  else if (i == 4)
  {
    tuple_int_int g;
    g.tuple_int_int_field_0 = 1;
    g.tuple_int_int_field_1 = 1;
    directions[i] = g;
  }
  else if (i == 5)
  {
    tuple_int_int h;
    h.tuple_int_int_field_0 = 1;
    h.tuple_int_int_field_1 = -1;
    directions[i] = h;
  }
  else if (i == 6)
  {
    tuple_int_int k;
    k.tuple_int_int_field_0 = -1;
    k.tuple_int_int_field_1 = 1;
    directions[i] = k;
  }
  else
  {
    tuple_int_int l;
    l.tuple_int_int_field_0 = -1;
    l.tuple_int_int_field_1 = -1;
    directions[i] = l;
  }
  int max0 = 0;
  std::vector<std::vector<int>> m = read_matrix<int>(20, 20);
  for (int j = 0; j <= 7; j ++)
  {
    tuple_int_int o = directions[j];
    int dx = o.tuple_int_int_field_0;
    int dy = o.tuple_int_int_field_1;
    for (int x = 0; x <= 19; x ++)
      for (int y = 0; y <= 19; y ++)
        max0 = max2_(max0, find(4, m, x, y, dx, dy));
  }
  std::cout << max0 << "\n";
}

