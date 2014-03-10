#include<stdio.h>
#include<stdlib.h>

int max2(int a, int b){
  if (a > b)
    return a;
  return b;
}

int nbPassePartout(int n, int** passepartout, int m, int** serrures){
  int max_ancient = 0;
  int max_recent = 0;
  {
    int i;
    for (i = 0 ; i < m; i++)
    {
      if (serrures[i][0] == -1 && serrures[i][1] > max_ancient)
        max_ancient = serrures[i][1];
      if (serrures[i][0] == 1 && serrures[i][1] > max_recent)
        max_recent = serrures[i][1];
    }
  }
  int max_ancient_pp = 0;
  int max_recent_pp = 0;
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      int* pp = passepartout[i];
      if (pp[0] >= max_ancient && pp[1] >= max_recent)
        return 1;
      max_ancient_pp = max2(max_ancient_pp, pp[0]);
      max_recent_pp = max2(max_recent_pp, pp[1]);
    }
  }
  if (max_ancient_pp >= max_ancient && max_recent_pp >= max_recent)
    return 2;
  else
    return 0;
}

int main(void){
  int n = 0;
  scanf("%d", &n);
  scanf("%*[ \t\r\n]c");
  int* *passepartout = malloc( n * sizeof(int*));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      int c = 2;
      int *out0 = malloc( c * sizeof(int));
      {
        int j;
        for (j = 0 ; j < c; j++)
        {
          int out__ = 0;
          scanf("%d", &out__);
          scanf("%*[ \t\r\n]c");
          out0[j] = out__;
        }
      }
      passepartout[i] = out0;
    }
  }
  int m = 0;
  scanf("%d", &m);
  scanf("%*[ \t\r\n]c");
  int* *serrures = malloc( m * sizeof(int*));
  {
    int k;
    for (k = 0 ; k < m; k++)
    {
      int d = 2;
      int *out1 = malloc( d * sizeof(int));
      {
        int l;
        for (l = 0 ; l < d; l++)
        {
          int out_ = 0;
          scanf("%d", &out_);
          scanf("%*[ \t\r\n]c");
          out1[l] = out_;
        }
      }
      serrures[k] = out1;
    }
  }
  int e = nbPassePartout(n, passepartout, m, serrures);
  printf("%d", e);
  return 0;
}


