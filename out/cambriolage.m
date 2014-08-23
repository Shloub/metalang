#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int max2(int a, int b){
  if (a > b)
    return a;
  else
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
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int n = 0;
  scanf("%d ", &n);
  int* *passepartout = malloc( n * sizeof(int*));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      int *out0 = malloc( 2 * sizeof(int));
      {
        int j;
        for (j = 0 ; j < 2; j++)
        {
          int out__ = 0;
          scanf("%d ", &out__);
          out0[j] = out__;
        }
      }
      passepartout[i] = out0;
    }
  }
  int m = 0;
  scanf("%d ", &m);
  int* *serrures = malloc( m * sizeof(int*));
  {
    int k;
    for (k = 0 ; k < m; k++)
    {
      int *out1 = malloc( 2 * sizeof(int));
      {
        int l;
        for (l = 0 ; l < 2; l++)
        {
          int out_ = 0;
          scanf("%d ", &out_);
          out1[l] = out_;
        }
      }
      serrures[k] = out1;
    }
  }
  printf("%d", nbPassePartout(n, passepartout, m, serrures));
  [pool drain];
  return 0;
}


