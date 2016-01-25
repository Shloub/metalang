#include <iostream>
#include <vector>
int max2_(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int min2_(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

struct bigint {
  bool bigint_sign;
  int bigint_len;
  std::vector<int> * bigint_chiffres;
};

bigint * read_bigint(int len){
  char c;
  std::vector<int> *chiffres = new std::vector<int>( len );
  for (int j = 0 ; j < len; j++)
  {
    std::cin >> c >> std::noskipws;
    chiffres->at(j) = (int)(c);
  }
  for (int i = 0 ; i <= (len - 1) / 2; i ++)
  {
    int tmp = chiffres->at(i);
    chiffres->at(i) = chiffres->at(len - 1 - i);
    chiffres->at(len - 1 - i) = tmp;
  }
  bigint * e = new bigint();
  e->bigint_sign=true;
  e->bigint_len=len;
  e->bigint_chiffres=chiffres;
  return e;
}

void print_bigint(bigint * a){
  if (!a->bigint_sign)
    std::cout << '-';
  for (int i = 0 ; i < a->bigint_len; i++)
    std::cout << a->bigint_chiffres->at(a->bigint_len - 1 - i);
}

bool bigint_eq(bigint * a, bigint * b){
  /* Renvoie vrai si a = b */
  if (a->bigint_sign != b->bigint_sign)
    return false;
  else if (a->bigint_len != b->bigint_len)
    return false;
  else
  {
    for (int i = 0 ; i < a->bigint_len; i++)
      if (a->bigint_chiffres->at(i) != b->bigint_chiffres->at(i))
      return false;
    return true;
  }
}

bool bigint_gt(bigint * a, bigint * b){
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
        if (a->bigint_chiffres->at(j) > b->bigint_chiffres->at(j))
          return a->bigint_sign;
        else if (a->bigint_chiffres->at(j) < b->bigint_chiffres->at(j))
          return !a->bigint_sign;
    }
    return true;
  }
}

bool bigint_lt(bigint * a, bigint * b){
  return !bigint_gt(a, b);
}

bigint * add_bigint_positif(bigint * a, bigint * b){
  /* Une addition ou on en a rien a faire des signes */
  int len = max2_(a->bigint_len, b->bigint_len) + 1;
  int retenue = 0;
  std::vector<int> *chiffres = new std::vector<int>( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmp = retenue;
    if (i < a->bigint_len)
      tmp += a->bigint_chiffres->at(i);
    if (i < b->bigint_len)
      tmp += b->bigint_chiffres->at(i);
    retenue = tmp / 10;
    chiffres->at(i) = tmp % 10;
  }
  while (len > 0 && chiffres->at(len - 1) == 0)
    len --;
  bigint * f = new bigint();
  f->bigint_sign=true;
  f->bigint_len=len;
  f->bigint_chiffres=chiffres;
  return f;
}

bigint * sub_bigint_positif(bigint * a, bigint * b){
  /* Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
*/
  int len = a->bigint_len;
  int retenue = 0;
  std::vector<int> *chiffres = new std::vector<int>( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmp = retenue + a->bigint_chiffres->at(i);
    if (i < b->bigint_len)
      tmp -= b->bigint_chiffres->at(i);
    if (tmp < 0)
    {
      tmp += 10;
      retenue = -1;
    }
    else
      retenue = 0;
    chiffres->at(i) = tmp;
  }
  while (len > 0 && chiffres->at(len - 1) == 0)
    len --;
  bigint * g = new bigint();
  g->bigint_sign=true;
  g->bigint_len=len;
  g->bigint_chiffres=chiffres;
  return g;
}

bigint * neg_bigint(bigint * a){
  bigint * h = new bigint();
  h->bigint_sign=!a->bigint_sign;
  h->bigint_len=a->bigint_len;
  h->bigint_chiffres=a->bigint_chiffres;
  return h;
}

bigint * add_bigint(bigint * a, bigint * b){
  if (a->bigint_sign == b->bigint_sign)
  {
    if (a->bigint_sign)
      return add_bigint_positif(a, b);
    else
      return neg_bigint(add_bigint_positif(a, b));
  }
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

bigint * sub_bigint(bigint * a, bigint * b){
  return add_bigint(a, neg_bigint(b));
}

bigint * mul_bigint_cp(bigint * a, bigint * b){
  /* Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. */
  int len = a->bigint_len + b->bigint_len + 1;
  std::vector<int> *chiffres = new std::vector<int>( len );
  std::fill(chiffres->begin(), chiffres->end(), 0);
  for (int i = 0 ; i < a->bigint_len; i++)
  {
    int retenue = 0;
    for (int j = 0 ; j < b->bigint_len; j++)
    {
      chiffres->at(i + j) =
      chiffres->at(i + j) + retenue + b->bigint_chiffres->at(j) * a->bigint_chiffres->at(i);
      retenue = chiffres->at(i + j) / 10;
      chiffres->at(i + j) = chiffres->at(i + j) % 10;
    }
    chiffres->at(i + b->bigint_len) = chiffres->at(i + b->bigint_len) + retenue;
  }
  chiffres->at(a->bigint_len + b->bigint_len) =
  chiffres->at(a->bigint_len + b->bigint_len - 1) / 10;
  chiffres->at(a->bigint_len + b->bigint_len - 1) =
  chiffres->at(a->bigint_len + b->bigint_len - 1) % 10;
  for (int l = 0 ; l <= 2; l ++)
    if (len != 0 && chiffres->at(len - 1) == 0)
    len --;
  bigint * m = new bigint();
  m->bigint_sign=a->bigint_sign == b->bigint_sign;
  m->bigint_len=len;
  m->bigint_chiffres=chiffres;
  return m;
}

bigint * bigint_premiers_chiffres(bigint * a, int i){
  int len = min2_(i, a->bigint_len);
  while (len != 0 && a->bigint_chiffres->at(len - 1) == 0)
    len --;
  bigint * o = new bigint();
  o->bigint_sign=a->bigint_sign;
  o->bigint_len=len;
  o->bigint_chiffres=a->bigint_chiffres;
  return o;
}

bigint * bigint_shift(bigint * a, int i){
  std::vector<int> *chiffres = new std::vector<int>( a->bigint_len + i );
  for (int k = 0 ; k < a->bigint_len + i; k++)
    if (k >= i)
    chiffres->at(k) = a->bigint_chiffres->at(k - i);
  else
    chiffres->at(k) = 0;
  bigint * p = new bigint();
  p->bigint_sign=a->bigint_sign;
  p->bigint_len=a->bigint_len + i;
  p->bigint_chiffres=chiffres;
  return p;
}

bigint * mul_bigint(bigint * aa, bigint * bb){
  if (aa->bigint_len == 0)
    return aa;
  else if (bb->bigint_len == 0)
    return bb;
  else if (aa->bigint_len < 3 || bb->bigint_len < 3)
    return mul_bigint_cp(aa, bb);
  /* Algorithme de Karatsuba */
  int split = min2_(aa->bigint_len, bb->bigint_len) / 2;
  bigint * a = bigint_shift(aa, -split);
  bigint * b = bigint_premiers_chiffres(aa, split);
  bigint * c = bigint_shift(bb, -split);
  bigint * d = bigint_premiers_chiffres(bb, split);
  bigint * amoinsb = sub_bigint(a, b);
  bigint * cmoinsd = sub_bigint(c, d);
  bigint * ac = mul_bigint(a, c);
  bigint * bd = mul_bigint(b, d);
  bigint * amoinsbcmoinsd = mul_bigint(amoinsb, cmoinsd);
  bigint * acdec = bigint_shift(ac, 2 * split);
  return add_bigint(add_bigint(acdec, bd), bigint_shift(sub_bigint(add_bigint(ac, bd), amoinsbcmoinsd), split));
  /* ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd */
}

/*
Division,
Modulo
*/
int log10(int a){
  int out0 = 1;
  while (a >= 10)
  {
    a /= 10;
    out0++;
  }
  return out0;
}

bigint * bigint_of_int(int i){
  int size = log10(i);
  if (i == 0)
    size = 0;
  std::vector<int> *t = new std::vector<int>( size );
  std::fill(t->begin(), t->end(), 0);
  for (int k = 0 ; k < size; k++)
  {
    t->at(k) = i % 10;
    i /= 10;
  }
  bigint * q = new bigint();
  q->bigint_sign=true;
  q->bigint_len=size;
  q->bigint_chiffres=t;
  return q;
}

bigint * fact_bigint(bigint * a){
  bigint * one = bigint_of_int(1);
  bigint * out0 = one;
  while (!bigint_eq(a, one))
  {
    out0 = mul_bigint(a, out0);
    a = sub_bigint(a, one);
  }
  return out0;
}

int sum_chiffres_bigint(bigint * a){
  int out0 = 0;
  for (int i = 0 ; i < a->bigint_len; i++)
    out0 += a->bigint_chiffres->at(i);
  return out0;
}

/* http://projecteuler.net/problem=20 */
int euler20(){
  bigint * a = bigint_of_int(15);
  /* normalement c'est 100 */
  a = fact_bigint(a);
  return sum_chiffres_bigint(a);
}

bigint * bigint_exp(bigint * a, int b){
  if (b == 1)
    return a;
  else if (b % 2 == 0)
    return bigint_exp(mul_bigint(a, a), b / 2);
  else
    return mul_bigint(a, bigint_exp(a, b - 1));
}

bigint * bigint_exp_10chiffres(bigint * a, int b){
  a = bigint_premiers_chiffres(a, 10);
  if (b == 1)
    return a;
  else if (b % 2 == 0)
    return bigint_exp_10chiffres(mul_bigint(a, a), b / 2);
  else
    return mul_bigint(a, bigint_exp_10chiffres(a, b - 1));
}

void euler48(){
  bigint * sum = bigint_of_int(0);
  for (int i = 1 ; i <= 100; i ++)
  {
    /* 1000 normalement */
    bigint * ib = bigint_of_int(i);
    bigint * ibeib = bigint_exp_10chiffres(ib, i);
    sum = add_bigint(sum, ibeib);
    sum = bigint_premiers_chiffres(sum, 10);
  }
  std::cout << "euler 48 = ";
  print_bigint(sum);
  std::cout << "\n";
}

int euler16(){
  bigint * a = bigint_of_int(2);
  a = bigint_exp(a, 100);
  /* 1000 normalement */
  return sum_chiffres_bigint(a);
}

int euler25(){
  int i = 2;
  bigint * a = bigint_of_int(1);
  bigint * b = bigint_of_int(1);
  while (b->bigint_len < 100)
  {
    /* 1000 normalement */
    bigint * c = add_bigint(a, b);
    a = b;
    b = c;
    i++;
  }
  return i;
}

int euler29(){
  int maxA = 5;
  int maxB = 5;
  std::vector<bigint *> *a_bigint = new std::vector<bigint *>( maxA + 1 );
  for (int j = 0 ; j < maxA + 1; j++)
    a_bigint->at(j) = bigint_of_int(j * j);
  std::vector<bigint *> *a0_bigint = new std::vector<bigint *>( maxA + 1 );
  for (int j2 = 0 ; j2 < maxA + 1; j2++)
    a0_bigint->at(j2) = bigint_of_int(j2);
  std::vector<int> *b = new std::vector<int>( maxA + 1 );
  std::fill(b->begin(), b->end(), 2);
  int n = 0;
  bool found = true;
  while (found)
  {
    bigint * min0 = a0_bigint->at(0);
    found = false;
    for (int i = 2 ; i <= maxA; i ++)
      if (b->at(i) <= maxB)
    {
      if (found)
      {
        if (bigint_lt(a_bigint->at(i), min0))
          min0 = a_bigint->at(i);
      }
      else
      {
        min0 = a_bigint->at(i);
        found = true;
      }
    }
    if (found)
    {
      n++;
      for (int l = 2 ; l <= maxA; l ++)
        if (bigint_eq(a_bigint->at(l), min0) && b->at(l) <= maxB)
      {
        b->at(l) = b->at(l) + 1;
        a_bigint->at(l) = mul_bigint(a_bigint->at(l), a0_bigint->at(l));
      }
    }
  }
  return n;
}


int main(){
  std::cout << euler29() << "\n";
  bigint * sum = read_bigint(50);
  for (int i = 2 ; i <= 100; i ++)
  {
    std::cin >> std::skipws;
    bigint * tmp = read_bigint(50);
    sum = add_bigint(sum, tmp);
  }
  std::cout << "euler13 = ";
  print_bigint(sum);
  std::cout << "\neuler25 = " << euler25() << "\neuler16 = " << euler16() << "\n";
  euler48();
  std::cout << "euler20 = " << euler20() << "\n";
  bigint * a = bigint_of_int(999999);
  bigint * b = bigint_of_int(9951263);
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
  if (bigint_gt(a, b))
    std::cout << "True";
  else
    std::cout << "False";
  std::cout << "\n";
  return 0;
}

