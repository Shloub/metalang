#include <iostream>
#include <vector>
int max2(int a, int b){
  if (a > b)
    return a;
  else
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
    int e = x;
    std::vector<int > f( e );
    for (int g = 0 ; g < e; g++)
    {
      int h = 0;
      std::cin >> h >> std::skipws;
      f.at(g) = h;
    }
    std::vector<int > d = f;
    tab.at(z) = d;
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
    tuple_int_int * v = new tuple_int_int();
    v->tuple_int_int_field_0=0;
    v->tuple_int_int_field_1=1;
    directions.at(i) = v;
  }
  else if (i == 1)
  {
    tuple_int_int * u = new tuple_int_int();
    u->tuple_int_int_field_0=1;
    u->tuple_int_int_field_1=0;
    directions.at(i) = u;
  }
  else if (i == 2)
  {
    tuple_int_int * s = new tuple_int_int();
    s->tuple_int_int_field_0=0;
    s->tuple_int_int_field_1=-1;
    directions.at(i) = s;
  }
  else if (i == 3)
  {
    tuple_int_int * r = new tuple_int_int();
    r->tuple_int_int_field_0=-1;
    r->tuple_int_int_field_1=0;
    directions.at(i) = r;
  }
  else if (i == 4)
  {
    tuple_int_int * q = new tuple_int_int();
    q->tuple_int_int_field_0=1;
    q->tuple_int_int_field_1=1;
    directions.at(i) = q;
  }
  else if (i == 5)
  {
    tuple_int_int * p = new tuple_int_int();
    p->tuple_int_int_field_0=1;
    p->tuple_int_int_field_1=-1;
    directions.at(i) = p;
  }
  else if (i == 6)
  {
    tuple_int_int * o = new tuple_int_int();
    o->tuple_int_int_field_0=-1;
    o->tuple_int_int_field_1=1;
    directions.at(i) = o;
  }
  else
  {
    tuple_int_int * l = new tuple_int_int();
    l->tuple_int_int_field_0=-1;
    l->tuple_int_int_field_1=-1;
    directions.at(i) = l;
  }
  int max_ = 0;
  std::vector<std::vector<int > > m = read_int_matrix(20, 20);
  for (int j = 0 ; j <= 7; j ++)
  {
    tuple_int_int * k = directions.at(j);
    int dx = k->tuple_int_int_field_0;
    int dy = k->tuple_int_int_field_1;
    for (int x = 0 ; x <= 19; x ++)
      for (int y = 0 ; y <= 19; y ++)
        max_ = max2(max_, find(4, m, x, y, dx, dy));
  }
  std::cout << max_ << "\n";
  return 0;
}

