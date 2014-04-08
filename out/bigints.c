#include<stdio.h>
#include<stdlib.h>


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
  int bigint_sign;
  int bigint_len;
  int* bigint_chiffres;
} bigint;

struct bigint * read_bigint(){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
  char sign = '_';
  scanf("%c", &sign);
  scanf("%*[ \t\r\n]c");
  int *chiffres = malloc( len * sizeof(int));
  {
    int d;
    for (d = 0 ; d < len; d++)
    {
      char c = '_';
      scanf("%c", &c);
      chiffres[d] = c - '0';
    }
  }
  {
    int i;
    for (i = 0 ; i <= (len - 1) / 2; i++)
    {
      int tmp = chiffres[i];
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
    }
  }
  scanf("%*[ \t\r\n]c");
  struct bigint * m = malloc (sizeof(m) );
  m->bigint_sign=sign == '+';
  m->bigint_len=len;
  m->bigint_chiffres=chiffres;
  return m;
}

void print_bigint(struct bigint * a){
  if (!a->bigint_sign)
    printf("%c", '-');
  {
    int i;
    for (i = 0 ; i < a->bigint_len; i++)
    {
      int e = a->bigint_chiffres[a->bigint_len - 1 - i];
      printf("%d", e);
    }
  }
}

int bigint_eq(struct bigint * a, struct bigint * b){
  /* Renvoie vrai si a = b */
  if (a->bigint_sign != b->bigint_sign)
    return 0;
  else if (a->bigint_len != b->bigint_len)
    return 0;
  else
  {
    {
      int i;
      for (i = 0 ; i < a->bigint_len; i++)
        if (a->bigint_chiffres[i] != b->bigint_chiffres[i])
        return 0;
    }
    return 1;
  }
}

int bigint_gt(struct bigint * a, struct bigint * b){
  /* Renvoie vrai si a > b */
  if (a->bigint_sign && !b->bigint_sign)
    return 1;
  else if (!a->bigint_sign && b->bigint_sign)
    return 0;
  else
  {
    if (a->bigint_len > b->bigint_len)
      return a->bigint_sign;
    else if (a->bigint_len < b->bigint_len)
      return !a->bigint_sign;
    else
      {
      int i;
      for (i = 0 ; i < a->bigint_len; i++)
      {
        int j = a->bigint_len - 1 - i;
        if (a->bigint_chiffres[j] > b->bigint_chiffres[j])
          return a->bigint_sign;
        else if (a->bigint_chiffres[j] < b->bigint_chiffres[j])
          return !a->bigint_sign;
      }
    }
    return 1;
  }
}

int bigint_lt(struct bigint * a, struct bigint * b){
  return !bigint_gt(a, b);
}

struct bigint * add_bigint_positif(struct bigint * a, struct bigint * b){
  /* Une addition ou on en a rien a faire des signes */
  int len = max2(a->bigint_len, b->bigint_len) + 1;
  int retenue = 0;
  int *chiffres = malloc( len * sizeof(int));
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      int tmp = retenue;
      if (i < a->bigint_len)
        tmp += a->bigint_chiffres[i];
      if (i < b->bigint_len)
        tmp += b->bigint_chiffres[i];
      retenue = tmp / 10;
      chiffres[i] = tmp % 10;
    }
  }
  while (len > 0 && chiffres[len - 1] == 0)
    len --;
  struct bigint * n = malloc (sizeof(n) );
  n->bigint_sign=1;
  n->bigint_len=len;
  n->bigint_chiffres=chiffres;
  return n;
}

struct bigint * sub_bigint_positif(struct bigint * a, struct bigint * b){
  /* Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
*/
  int len = a->bigint_len;
  int retenue = 0;
  int *chiffres = malloc( len * sizeof(int));
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      int tmp = retenue + a->bigint_chiffres[i];
      if (i < b->bigint_len)
        tmp -= b->bigint_chiffres[i];
      if (tmp < 0)
      {
        tmp += 10;
        retenue = -1;
      }
      else
        retenue = 0;
      chiffres[i] = tmp;
    }
  }
  while (len > 0 && chiffres[len - 1] == 0)
    len --;
  struct bigint * o = malloc (sizeof(o) );
  o->bigint_sign=1;
  o->bigint_len=len;
  o->bigint_chiffres=chiffres;
  return o;
}

struct bigint * neg_bigint(struct bigint * a){
  struct bigint * p = malloc (sizeof(p) );
  p->bigint_sign=!a->bigint_sign;
  p->bigint_len=a->bigint_len;
  p->bigint_chiffres=a->bigint_chiffres;
  return p;
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
  int *chiffres = malloc( len * sizeof(int));
  {
    int k;
    for (k = 0 ; k < len; k++)
      chiffres[k] = 0;
  }
  {
    int i;
    for (i = 0 ; i < a->bigint_len; i++)
    {
      int retenue = 0;
      {
        int j;
        for (j = 0 ; j < b->bigint_len; j++)
        {
          chiffres[i + j] = chiffres[i + j] + retenue + b->bigint_chiffres[j] * a->bigint_chiffres[i];
          retenue = chiffres[i + j] / 10;
          chiffres[i + j] = chiffres[i + j] % 10;
        }
      }
      chiffres[i + b->bigint_len] = chiffres[i + b->bigint_len] + retenue;
    }
  }
  chiffres[a->bigint_len + b->bigint_len] = chiffres[a->bigint_len + b->bigint_len - 1] / 10;
  chiffres[a->bigint_len + b->bigint_len - 1] = chiffres[a->bigint_len + b->bigint_len - 1] % 10;
  {
    int l;
    for (l = 0 ; l <= 2; l++)
      if (len != 0 && chiffres[len - 1] == 0)
      len --;
  }
  struct bigint * q = malloc (sizeof(q) );
  q->bigint_sign=a->bigint_sign == b->bigint_sign;
  q->bigint_len=len;
  q->bigint_chiffres=chiffres;
  return q;
}

struct bigint * bigint_premiers_chiffres(struct bigint * a, int i){
  int len = min2(i, a->bigint_len);
  while (len != 0 && a->bigint_chiffres[len - 1] == 0)
    len --;
  struct bigint * r = malloc (sizeof(r) );
  r->bigint_sign=a->bigint_sign;
  r->bigint_len=len;
  r->bigint_chiffres=a->bigint_chiffres;
  return r;
}

struct bigint * bigint_shift(struct bigint * a, int i){
  int f = a->bigint_len + i;
  int *chiffres = malloc( f * sizeof(int));
  {
    int k;
    for (k = 0 ; k < f; k++)
      if (k >= i)
      chiffres[k] = a->bigint_chiffres[k - i];
    else
      chiffres[k] = 0;
  }
  struct bigint * s = malloc (sizeof(s) );
  s->bigint_sign=a->bigint_sign;
  s->bigint_len=a->bigint_len + i;
  s->bigint_chiffres=chiffres;
  return s;
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
  int *t = malloc( size * sizeof(int));
  {
    int j;
    for (j = 0 ; j < size; j++)
      t[j] = 0;
  }
  {
    int k;
    for (k = 0 ; k < size; k++)
    {
      t[k] = i % 10;
      i /= 10;
    }
  }
  struct bigint * u = malloc (sizeof(u) );
  u->bigint_sign=1;
  u->bigint_len=size;
  u->bigint_chiffres=t;
  return u;
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
  {
    int i;
    for (i = 0 ; i < a->bigint_len; i++)
      out_ += a->bigint_chiffres[i];
  }
  return out_;
}

/* http://projecteuler.net/problem=20 */
int euler20(){
  struct bigint * a = bigint_of_int(100);
  a = fact_bigint(a);
  return sum_chiffres_bigint(a);
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
  {
    int i;
    for (i = 1 ; i <= 1000; i++)
    {
      struct bigint * ib = bigint_of_int(i);
      struct bigint * ibeib = bigint_exp_10chiffres(ib, i);
      sum = add_bigint(sum, ibeib);
      sum = bigint_premiers_chiffres(sum, 10);
    }
  }
  printf("euler 48 = ");
  print_bigint(sum);
  printf("\n");
}

int main(void){
  euler48();
  printf("euler20 = ");
  int g = euler20();
  printf("%d\n", g);
  struct bigint * a = read_bigint();
  struct bigint * b = read_bigint();
  print_bigint(a);
  printf(">>1=");
  print_bigint(bigint_shift(a, -1));
  printf("\n");
  print_bigint(a);
  printf("*");
  print_bigint(b);
  printf("=");
  print_bigint(mul_bigint(a, b));
  printf("\n");
  print_bigint(a);
  printf("*");
  print_bigint(b);
  printf("=");
  print_bigint(mul_bigint_cp(a, b));
  printf("\n");
  print_bigint(a);
  printf("+");
  print_bigint(b);
  printf("=");
  print_bigint(add_bigint(a, b));
  printf("\n");
  print_bigint(b);
  printf("-");
  print_bigint(a);
  printf("=");
  print_bigint(sub_bigint(b, a));
  printf("\n");
  print_bigint(a);
  printf("-");
  print_bigint(b);
  printf("=");
  print_bigint(sub_bigint(a, b));
  printf("\n");
  print_bigint(a);
  printf(">");
  print_bigint(b);
  printf("=");
  int h = bigint_gt(a, b);
  if (h)
    printf("True");
  else
    printf("False");
  printf("\n");
  return 0;
}


