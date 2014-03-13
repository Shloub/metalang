#include<stdio.h>
#include<stdlib.h>


int max2(int a, int b){
  if (a > b)
    return a;
  return b;
}

struct bigint;
typedef struct bigint {
  int sign;
  int chiffres_len;
  int* chiffres;
} bigint;

struct bigint * read_big_int(){
  printf("read_big_int");
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
  printf("%d=len ", len);
  char sign = '_';
  scanf("%c", &sign);
  printf("%c=sign\n", sign);
  int *chiffres = malloc( len * sizeof(int));
  {
    int d;
    for (d = 0 ; d < len; d++)
    {
      char c = '_';
      scanf("%c", &c);
      printf("%c=c\n", c);
      chiffres[d] = c - '0';
    }
  }
  {
    int i;
    for (i = 0 ; i <= len / 2; i++)
    {
      int tmp = chiffres[i];
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
    }
  }
  scanf("%*[ \t\r\n]c");
  struct bigint * out_ = malloc (sizeof(out_) );
  out_->sign=sign
  ==
  '+';
  out_->chiffres_len=len;
  out_->chiffres=chiffres;
  return out_;
}

void print_big_int(struct bigint * a){
  if (a->sign)
    printf("+");
  else
    printf("-");
  {
    int i;
    for (i = 0 ; i < a->chiffres_len; i++)
    {
      int e = a->chiffres[i];
      printf("%d", e);
    }
  }
}

struct bigint * neg_big_int(struct bigint * a){
  struct bigint * out_ = malloc (sizeof(out_) );
  out_->sign=!a->sign;
  out_->chiffres_len=a->chiffres_len;
  out_->chiffres=a->chiffres;
  return out_;
}

struct bigint * add_big_int(struct bigint * a, struct bigint * b){
  int len = max2(a->chiffres_len, b->chiffres_len) + 1;
  int retenue = 0;
  int sign = 1;
  int *chiffres = malloc( len * sizeof(int));
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      int tmp = retenue;
      if (i < a->chiffres_len)
        tmp += a->chiffres[i];
      if (i < b->chiffres_len)
        tmp += b->chiffres[i];
      retenue = tmp / 10;
      chiffres[i] = tmp % 10;
    }
  }
  struct bigint * out_ = malloc (sizeof(out_) );
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


