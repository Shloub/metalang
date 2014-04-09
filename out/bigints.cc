#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>

int max2(int a, int b){
  if (a > b)
    return a;
  return b;
}

int min2(int a, int b){
  if (a < b)
    return a;
  return b;
}

struct bigint;
typedef struct bigint {
  bool bigint_sign;
  int bigint_len;
  std::vector<int > bigint_chiffres;
} bigint;

struct bigint * read_bigint(int len){
  std::vector<int > chiffres( len );
  for (int j = 0 ; j < len; j++)
  {
    char c = '_';
    scanf("%c", &c);
    chiffres.at(j) = c;
  }
  for (int i = 0 ; i <= (len - 1) / 2; i ++)
  {
    int tmp = chiffres.at(i);
    chiffres.at(i) = chiffres.at(len - 1 - i);
    chiffres.at(len - 1 - i) = tmp;
  }
  struct bigint * o = new bigint();
  o->bigint_sign=true;
  o->bigint_len=len;
  o->bigint_chiffres=chiffres;
  return o;
}

void print_bigint(struct bigint * a){
  if (!a->bigint_sign)
    std::cout << '-';
  for (int i = 0 ; i < a->bigint_len; i++)
  {
    int e = a->bigint_chiffres.at(a->bigint_len - 1 - i);
    std::cout << e;
  }
}

bool bigint_eq(struct bigint * a, struct bigint * b){
  /* Renvoie vrai si a = b */
  if (a->bigint_sign != b->bigint_sign)
    return false;
  else if (a->bigint_len != b->bigint_len)
    return false;
  else
  {
    for (int i = 0 ; i < a->bigint_len; i++)
      if (a->bigint_chiffres.at(i) != b->bigint_chiffres.at(i))
      return false;
    return true;
  }
}

bool bigint_gt(struct bigint * a, struct bigint * b){
  /* Renvoie vrai si a > b */
  if (a->bigint_sign && !b->bigint_sign)
    return true;
  else if (!a->bigint_sign && b->bigint_sign)
    return false;
  else
  {
    if (a->bigint_len > b->bigint_len)
      return a->bigint_sign;
    else if (a->bigint_len < b->bigint_len)
      return !a->bigint_sign;
    else
      for (int i = 0 ; i < a->bigint_len; i++)
      {
        int j = a->bigint_len - 1 - i;
        if (a->bigint_chiffres.at(j) > b->bigint_chiffres.at(j))
          return a->bigint_sign;
        else if (a->bigint_chiffres.at(j) < b->bigint_chiffres.at(j))
          return !a->bigint_sign;
    }
    return true;
  }
}

bool bigint_lt(struct bigint * a, struct bigint * b){
  return !bigint_gt(a, b);
}

struct bigint * add_bigint_positif(struct bigint * a, struct bigint * b){
  /* Une addition ou on en a rien a faire des signes */
  int len = max2(a->bigint_len, b->bigint_len) + 1;
  int retenue = 0;
  std::vector<int > chiffres( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmp = retenue;
    if (i < a->bigint_len)
      tmp += a->bigint_chiffres.at(i);
    if (i < b->bigint_len)
      tmp += b->bigint_chiffres.at(i);
    retenue = tmp / 10;
    chiffres.at(i) = tmp % 10;
  }
  while (len > 0 && chiffres.at(len - 1) == 0)
    len --;
  struct bigint * p = new bigint();
  p->bigint_sign=true;
  p->bigint_len=len;
  p->bigint_chiffres=chiffres;
  return p;
}

struct bigint * sub_bigint_positif(struct bigint * a, struct bigint * b){
  /* Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
*/
  int len = a->bigint_len;
  int retenue = 0;
  std::vector<int > chiffres( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmp = retenue + a->bigint_chiffres.at(i);
    if (i < b->bigint_len)
      tmp -= b->bigint_chiffres.at(i);
    if (tmp < 0)
    {
      tmp += 10;
      retenue = -1;
    }
    else
      retenue = 0;
    chiffres.at(i) = tmp;
  }
  while (len > 0 && chiffres.at(len - 1) == 0)
    len --;
  struct bigint * q = new bigint();
  q->bigint_sign=true;
  q->bigint_len=len;
  q->bigint_chiffres=chiffres;
  return q;
}

struct bigint * neg_bigint(struct bigint * a){
  struct bigint * r = new bigint();
  r->bigint_sign=!a->bigint_sign;
  r->bigint_len=a->bigint_len;
  r->bigint_chiffres=a->bigint_chiffres;
  return r;
}

struct bigint * add_bigint(struct bigint * a, struct bigint * b){
  if (a->bigint_sign == b->bigint_sign)
    if (a->bigint_sign)
    return add_bigint_positif(a, b);
  else
    return neg_bigint(add_bigint_positif(a, b));
  else if (a->bigint_sign)
  {
    /* a positif, b negatif */
    if (bigint_gt(a, neg_bigint(b)))
      return sub_bigint_positif(a, b);
    else
      return neg_bigint(sub_bigint_positif(b, a));
  }
  else
  {
    /* a negatif, b positif */
    if (bigint_gt(neg_bigint(a), b))
      return neg_bigint(sub_bigint_positif(a, b));
    else
      return sub_bigint_positif(b, a);
  }
}

struct bigint * sub_bigint(struct bigint * a, struct bigint * b){
  return add_bigint(a, neg_bigint(b));
}

struct bigint * mul_bigint_cp(struct bigint * a, struct bigint * b){
  /* Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. */
  int len = a->bigint_len + b->bigint_len + 1;
  std::vector<int > chiffres( len );
  for (int k = 0 ; k < len; k++)
    chiffres.at(k) = 0;
  for (int i = 0 ; i < a->bigint_len; i++)
  {
    int retenue = 0;
    for (int j = 0 ; j < b->bigint_len; j++)
    {
      chiffres.at(i + j) = chiffres.at(i + j) + retenue + b->bigint_chiffres.at(j) * a->bigint_chiffres.at(i);
      retenue = chiffres.at(i + j) / 10;
      chiffres.at(i + j) = chiffres.at(i + j) % 10;
    }
    chiffres.at(i + b->bigint_len) = chiffres.at(i + b->bigint_len) + retenue;
  }
  chiffres.at(a->bigint_len + b->bigint_len) = chiffres.at(a->bigint_len + b->bigint_len - 1) / 10;
  chiffres.at(a->bigint_len + b->bigint_len - 1) = chiffres.at(a->bigint_len + b->bigint_len - 1) % 10;
  for (int l = 0 ; l <= 2; l ++)
    if (len != 0 && chiffres.at(len - 1) == 0)
    len --;
  struct bigint * s = new bigint();
  s->bigint_sign=a->bigint_sign == b->bigint_sign;
  s->bigint_len=len;
  s->bigint_chiffres=chiffres;
  return s;
}

struct bigint * bigint_premiers_chiffres(struct bigint * a, int i){
  int len = min2(i, a->bigint_len);
  while (len != 0 && a->bigint_chiffres.at(len - 1) == 0)
    len --;
  struct bigint * u = new bigint();
  u->bigint_sign=a->bigint_sign;
  u->bigint_len=len;
  u->bigint_chiffres=a->bigint_chiffres;
  return u;
}

struct bigint * bigint_shift(struct bigint * a, int i){
  int f = a->bigint_len + i;
  std::vector<int > chiffres( f );
  for (int k = 0 ; k < f; k++)
    if (k >= i)
    chiffres.at(k) = a->bigint_chiffres.at(k - i);
  else
    chiffres.at(k) = 0;
  struct bigint * v = new bigint();
  v->bigint_sign=a->bigint_sign;
  v->bigint_len=a->bigint_len + i;
  v->bigint_chiffres=chiffres;
  return v;
}

struct bigint * mul_bigint(struct bigint * aa, struct bigint * bb){
  if (aa->bigint_len == 0)
    return aa;
  else if (bb->bigint_len == 0)
    return bb;
  else if (aa->bigint_len < 3 || bb->bigint_len < 3)
    return mul_bigint_cp(aa, bb);
  /* Algorithme de Karatsuba */
  int split = min2(aa->bigint_len, bb->bigint_len) / 2;
  struct bigint * a = bigint_shift(aa, -split);
  struct bigint * b = bigint_premiers_chiffres(aa, split);
  struct bigint * c = bigint_shift(bb, -split);
  struct bigint * d = bigint_premiers_chiffres(bb, split);
  struct bigint * amoinsb = sub_bigint(a, b);
  struct bigint * cmoinsd = sub_bigint(c, d);
  struct bigint * ac = mul_bigint(a, c);
  struct bigint * bd = mul_bigint(b, d);
  struct bigint * amoinsbcmoinsd = mul_bigint(amoinsb, cmoinsd);
  struct bigint * acdec = bigint_shift(ac, 2 * split);
  return add_bigint(add_bigint(acdec, bd), bigint_shift(sub_bigint(add_bigint(ac, bd), amoinsbcmoinsd), split));
  /* ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd */
}

/*
Division,
Modulo
*/
int log10(int a){
  int out_ = 1;
  while (a >= 10)
  {
    a /= 10;
    out_ ++;
  }
  return out_;
}

struct bigint * bigint_of_int(int i){
  int size = log10(i);
  if (i == 0)
    size = 0;
  std::vector<int > t( size );
  for (int j = 0 ; j < size; j++)
    t.at(j) = 0;
  for (int k = 0 ; k < size; k++)
  {
    t.at(k) = i % 10;
    i /= 10;
  }
  struct bigint * w = new bigint();
  w->bigint_sign=true;
  w->bigint_len=size;
  w->bigint_chiffres=t;
  return w;
}

struct bigint * fact_bigint(struct bigint * a){
  struct bigint * one = bigint_of_int(1);
  struct bigint * out_ = one;
  while (!bigint_eq(a, one))
  {
    out_ = mul_bigint(a, out_);
    a = sub_bigint(a, one);
  }
  return out_;
}

int sum_chiffres_bigint(struct bigint * a){
  int out_ = 0;
  for (int i = 0 ; i < a->bigint_len; i++)
    out_ += a->bigint_chiffres.at(i);
  return out_;
}

/* http://projecteuler.net/problem=20 */
int euler20(){
  struct bigint * a = bigint_of_int(100);
  a = fact_bigint(a);
  return sum_chiffres_bigint(a);
}

struct bigint * bigint_exp(struct bigint * a, int b){
  if (b == 1)
    return a;
  else if ((b % 2) == 0)
    return bigint_exp(mul_bigint(a, a), b / 2);
  else
    return mul_bigint(a, bigint_exp(a, b - 1));
}

struct bigint * bigint_exp_10chiffres(struct bigint * a, int b){
  a = bigint_premiers_chiffres(a, 10);
  if (b == 1)
    return a;
  else if ((b % 2) == 0)
    return bigint_exp_10chiffres(mul_bigint(a, a), b / 2);
  else
    return mul_bigint(a, bigint_exp_10chiffres(a, b - 1));
}

void euler48(){
  struct bigint * sum = bigint_of_int(0);
  for (int i = 1 ; i <= 1000; i ++)
  {
    struct bigint * ib = bigint_of_int(i);
    struct bigint * ibeib = bigint_exp_10chiffres(ib, i);
    sum = add_bigint(sum, ibeib);
    sum = bigint_premiers_chiffres(sum, 10);
  }
  std::cout << "euler 48 = ";
  print_bigint(sum);
  std::cout << "\n";
}

int euler16(){
  struct bigint * a = bigint_of_int(2);
  a = bigint_exp(a, 1000);
  return sum_chiffres_bigint(a);
}

int euler25(){
  int i = 2;
  struct bigint * a = bigint_of_int(1);
  struct bigint * b = bigint_of_int(1);
  while (b->bigint_len < 1000)
  {
    struct bigint * c = add_bigint(a, b);
    a = b;
    b = c;
    i ++;
  }
  return i;
}


int main(void){
  struct bigint * sum = read_bigint(50);
  for (int i = 2 ; i <= 100; i ++)
  {
    scanf("%*[ \t\r\n]c");
    struct bigint * tmp = read_bigint(50);
    sum = add_bigint(sum, tmp);
  }
  std::cout << "euler13 = ";
  print_bigint(sum);
  std::cout << "\n" << "euler25 = ";
  int g = euler25();
  std::cout << g << "\n" << "euler16 = ";
  int h = euler16();
  std::cout << h << "\n";
  euler48();
  std::cout << "euler20 = ";
  int m = euler20();
  std::cout << m << "\n";
  struct bigint * a = bigint_of_int(999999);
  struct bigint * b = bigint_of_int(9951263);
  print_bigint(a);
  std::cout << ">>1=";
  print_bigint(bigint_shift(a, -1));
  std::cout << "\n";
  print_bigint(a);
  std::cout << "*";
  print_bigint(b);
  std::cout << "=";
  print_bigint(mul_bigint(a, b));
  std::cout << "\n";
  print_bigint(a);
  std::cout << "*";
  print_bigint(b);
  std::cout << "=";
  print_bigint(mul_bigint_cp(a, b));
  std::cout << "\n";
  print_bigint(a);
  std::cout << "+";
  print_bigint(b);
  std::cout << "=";
  print_bigint(add_bigint(a, b));
  std::cout << "\n";
  print_bigint(b);
  std::cout << "-";
  print_bigint(a);
  std::cout << "=";
  print_bigint(sub_bigint(b, a));
  std::cout << "\n";
  print_bigint(a);
  std::cout << "-";
  print_bigint(b);
  std::cout << "=";
  print_bigint(sub_bigint(a, b));
  std::cout << "\n";
  print_bigint(a);
  std::cout << ">";
  print_bigint(b);
  std::cout << "=";
  bool n = bigint_gt(a, b);
  if (n)
    std::cout << "True";
  else
    std::cout << "False";
  std::cout << "\n";
  return 0;
}

