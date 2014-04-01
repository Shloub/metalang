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
  bool bigint_sign;
  int bigint_len;
  std::vector<int > bigint_chiffres;
} bigint;

struct bigint * read_bigint(){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
  char sign = '_';
  scanf("%c", &sign);
  scanf("%*[ \t\r\n]c");
  std::vector<int > chiffres( len );
  for (int d = 0 ; d < len; d++)
  {
    char c = '_';
    scanf("%c", &c);
    chiffres.at(d) = c - '0';
  }
  for (int i = 0 ; i <= (len - 1) / 2; i ++)
  {
    int tmp = chiffres.at(i);
    chiffres.at(i) = chiffres.at(len - 1 - i);
    chiffres.at(len - 1 - i) = tmp;
  }
  scanf("%*[ \t\r\n]c");
  struct bigint * h = new bigint();
  h->bigint_sign=sign == '+';
  h->bigint_len=len;
  h->bigint_chiffres=chiffres;
  return h;
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
          return a->bigint_sign;
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
  if (chiffres.at(len - 1) == 0)
    len --;
  struct bigint * m = new bigint();
  m->bigint_sign=true;
  m->bigint_len=len;
  m->bigint_chiffres=chiffres;
  return m;
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
  struct bigint * n = new bigint();
  n->bigint_sign=true;
  n->bigint_len=len;
  n->bigint_chiffres=chiffres;
  return n;
}

struct bigint * neg_bigint(struct bigint * a){
  struct bigint * o = new bigint();
  o->bigint_sign=!a->bigint_sign;
  o->bigint_len=a->bigint_len;
  o->bigint_chiffres=a->bigint_chiffres;
  return o;
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
    if (chiffres.at(len - 1) == 0)
    len --;
  struct bigint * p = new bigint();
  p->bigint_sign=a->bigint_sign == b->bigint_sign;
  p->bigint_len=len;
  p->bigint_chiffres=chiffres;
  return p;
}

struct bigint * bigint_premiers_chiffres(struct bigint * a, int i){
  struct bigint * q = new bigint();
  q->bigint_sign=a->bigint_sign;
  q->bigint_len=i;
  q->bigint_chiffres=a->bigint_chiffres;
  return q;
}

struct bigint * bigint_shift(struct bigint * a, int i){
  int f = a->bigint_len + i;
  std::vector<int > chiffres( f );
  for (int k = 0 ; k < f; k++)
    if (k >= i)
    chiffres.at(k) = a->bigint_chiffres.at(k - i);
  else
    chiffres.at(k) = 0;
  struct bigint * r = new bigint();
  r->bigint_sign=a->bigint_sign;
  r->bigint_len=a->bigint_len + i;
  r->bigint_chiffres=chiffres;
  return r;
}

struct bigint * mul_bigint(struct bigint * aa, struct bigint * bb){
  if (aa->bigint_len < 3 || bb->bigint_len < 3)
    return mul_bigint_cp(aa, bb);
  /* Algorithme de Karatsuba */
  int split = max2(aa->bigint_len, bb->bigint_len) / 2;
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
Exp
*/

int main(void){
  struct bigint * a = read_bigint();
  struct bigint * b = read_bigint();
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
  bool g = bigint_gt(a, b);
  if (g)
    std::cout << "True";
  else
    std::cout << "False";
  std::cout << "\n";
  return 0;
}

