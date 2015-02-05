#include <iostream>
#include <vector>
class tuple_int_int {
public:
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
};


int main(){
  int e, d;
  for (int i = 1 ; i <= 3; i ++)
  {
    std::cin >> d >> std::skipws >> e;
    tuple_int_int * f = new tuple_int_int();
    f->tuple_int_int_field_0=d;
    f->tuple_int_int_field_1=e;
    int a = f->tuple_int_int_field_0;
    int b = f->tuple_int_int_field_1;
    std::cout << "a = " << a << " b = " << b << "\n";
  }
  return 0;
}

