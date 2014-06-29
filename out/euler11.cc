#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int max2(int a, int b){
  if (a > b)
    return a;
  return b;
}

std::vector<int > read_int_line(int n){
  std::vector<int > tab( n );
  for (int i = 0 ; i < n; i++)
  {
    int t = 0;
    std::cin >> t >> std::skipws;
    tab.at(i) = t;
  }
  return tab;
}

std::vector<std::vector<int > > read_int_matrix(int x, int y){
  std::vector<std::vector<int > > tab( y );
  for (int z = 0 ; z < y; z++)
  {
    std::cin >> std::skipws;
    tab.at(z) = read_int_line(x);
  }
  return tab;
}

int find(int n, std::vector<std::vector<int > >& m, int x, int y, int dx, int dy){
  if (x < 0 || x == 20 || y < 0 || y == 20)
    return -1;
  else if (n == 0)
    return 1;
  else
    return m.at(y).at(x) * find(n - 1, m, x + dx, y + dy, dx, dy);
}

class tuple_int_int {
public:
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
};


int main(){
  int c = 8;
  std::vector<tuple_int_int * > directions( c );
  for (int i = 0 ; i < c; i++)
    if (i == 0)
  {
    tuple_int_int * p = new tuple_int_int();
    p->tuple_int_int_field_0=0;
    p->tuple_int_int_field_1=1;
    directions.at(i) = p;
  }
  else if (i == 1)
  {
    tuple_int_int * o = new tuple_int_int();
    o->tuple_int_int_field_0=1;
    o->tuple_int_int_field_1=0;
    directions.at(i) = o;
  }
  else if (i == 2)
  {
    tuple_int_int * l = new tuple_int_int();
    l->tuple_int_int_field_0=0;
    l->tuple_int_int_field_1=-1;
    directions.at(i) = l;
  }
  else if (i == 3)
  {
    tuple_int_int * k = new tuple_int_int();
    k->tuple_int_int_field_0=-1;
    k->tuple_int_int_field_1=0;
    directions.at(i) = k;
  }
  else if (i == 4)
  {
    tuple_int_int * h = new tuple_int_int();
    h->tuple_int_int_field_0=1;
    h->tuple_int_int_field_1=1;
    directions.at(i) = h;
  }
  else if (i == 5)
  {
    tuple_int_int * g = new tuple_int_int();
    g->tuple_int_int_field_0=1;
    g->tuple_int_int_field_1=-1;
    directions.at(i) = g;
  }
  else if (i == 6)
  {
    tuple_int_int * f = new tuple_int_int();
    f->tuple_int_int_field_0=-1;
    f->tuple_int_int_field_1=1;
    directions.at(i) = f;
  }
  else
  {
    tuple_int_int * e = new tuple_int_int();
    e->tuple_int_int_field_0=-1;
    e->tuple_int_int_field_1=-1;
    directions.at(i) = e;
  }
  int max_ = 0;
  std::vector<std::vector<int > > m = read_int_matrix(20, 20);
  for (int j = 0 ; j <= 7; j ++)
  {
    tuple_int_int * d = directions.at(j);
    int dx = d->tuple_int_int_field_0;
    int dy = d->tuple_int_int_field_1;
    for (int x = 0 ; x <= 19; x ++)
      for (int y = 0 ; y <= 19; y ++)
        max_ = max2(max_, find(4, m, x, y, dx, dy));
  }
  std::cout << max_ << "\n";
  return 0;
}

