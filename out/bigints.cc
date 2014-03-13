#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>

int max2(int a, int b){
  if (a > b)
    return a;
  return b;
}

struct bigint;
typedef struct bigint {
  bool sign;
  int chiffres_len;
  std::vector<int > chiffres;
} bigint;

struct bigint * read_big_int(){
  std::cout << "read_big_int";
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
  std::cout << len << "=len ";
  char sign = '_';
  scanf("%c", &sign);
  std::cout << sign << "=sign\n";
  std::vector<int > chiffres( len );
  for (int d = 0 ; d < len; d++)
  {
    char c = '_';
    scanf("%c", &c);
    std::cout << c << "=c\n";
    chiffres.at(d) = c - '0';
  }
  for (int i = 0 ; i <= len / 2; i ++)
  {
    int tmp = chiffres.at(i);
    chiffres.at(i) = chiffres.at(len - 1 - i);
    chiffres.at(len - 1 - i) = tmp;
  }
  scanf("%*[ \t\r\n]c");
  struct bigint * out_ = new bigint();
  out_->sign=sign
  ==
  '+';
  out_->chiffres_len=len;
  out_->chiffres=chiffres;
  return out_;
}

void print_big_int(struct bigint * a){
  if (a->sign)
    std::cout << "+";
  else
    std::cout << "-";
  for (int i = 0 ; i < a->chiffres_len; i++)
  {
    int e = a->chiffres.at(i);
    std::cout << e;
  }
}

struct bigint * neg_big_int(struct bigint * a){
  struct bigint * out_ = new bigint();
  out_->sign=!a->sign;
  out_->chiffres_len=a->chiffres_len;
  out_->chiffres=a->chiffres;
  return out_;
}

struct bigint * add_big_int(struct bigint * a, struct bigint * b){
  int len = max2(a->chiffres_len, b->chiffres_len) + 1;
  int retenue = 0;
  bool sign = true;
  std::vector<int > chiffres( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmp = retenue;
    if (i < a->chiffres_len)
      tmp += a->chiffres.at(i);
    if (i < b->chiffres_len)
      tmp += b->chiffres.at(i);
    retenue = tmp / 10;
    chiffres.at(i) = tmp % 10;
  }
  struct bigint * out_ = new bigint();
  out_->sign=sign;
  out_->chiffres_len=len;
  out_->chiffres=chiffres;
  return out_;
}

/*
def @bigint mul_big_int(@bigint a, @bigint b)

end

def @bigint exp_big_int(@bigint a, @bigint b)

end

def @bigint print_big_int(@bigint b)

end
*/

int main(void){
  struct bigint * a = read_big_int();
  struct bigint * b = read_big_int();
  print_big_int(add_big_int(a, b));
  return 0;
}

