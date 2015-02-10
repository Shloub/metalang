#include <iostream>
#include <vector>
class tuple_int_int {
public:
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
};

class toto {
public:
  tuple_int_int * foo;
  int bar;
};


int main(){
  int g, f, bar_;
  std::cin >> bar_ >> std::skipws >> f >> g;
  tuple_int_int * i = new tuple_int_int();
  i->tuple_int_int_field_0=f;
  i->tuple_int_int_field_1=g;
  toto * t = new toto();
  t->foo=i;
  t->bar=bar_;
  tuple_int_int * h = t->foo;
  int a = h->tuple_int_int_field_0;
  int b = h->tuple_int_int_field_1;
  std::cout << a << " " << b << " " << t->bar << "\n";
  return 0;
}

