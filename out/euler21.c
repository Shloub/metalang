#include <stdio.h>
#include <stdlib.h>


int eratostene(int* t, int max0) {
    int i;
    int n = 0;
    for (i = 2; i < max0; i++)
        if (t[i] == i)
        {
            n++;
            int j = i * i;
            while (j < max0 && j > 0)
            {
                t[j] = 0;
                j += i;
            }
        }
    return n;
}

int fillPrimesFactors(int* t, int n, int* primes, int nprimes) {
    int i;
    for (i = 0; i < nprimes; i++)
    {
        int d = primes[i];
        while (n % d == 0)
        {
            t[d]++;
            n /= d;
        }
        if (n == 1)
            return primes[i];
    }
    return n;
}

int sumdivaux2(int* t, int n, int i) {
    while (i < n && t[i] == 0)
        i++;
    return i;
}

int sumdivaux(int* t, int n, int i) {
    int j;
    if (i > n)
        return 1;
    else if (t[i] == 0)
        return sumdivaux(t, n, sumdivaux2(t, n, i + 1));
    else
    {
        int o = sumdivaux(t, n, sumdivaux2(t, n, i + 1));
        int out0 = 0;
        int p = i;
        for (j = 1; j <= t[i]; j++)
        {
            out0 += p;
            p *= i;
        }
        return (out0 + 1) * o;
    }
}

int sumdiv(int nprimes, int* primes, int n) {
    int i;
    int *t = calloc(n + 1, sizeof(int));
    for (i = 0; i <= n; i++)
        t[i] = 0;
    int max0 = fillPrimesFactors(t, n, primes, nprimes);
    return sumdivaux(t, max0, 0);
}int main(void) {
     int n, k, o, j;
     int maximumprimes = 1001;
     int *era = calloc(maximumprimes, sizeof(int));
     for (j = 0; j < maximumprimes; j++)
         era[j] = j;
     int nprimes = eratostene(era, maximumprimes);
     int *primes = calloc(nprimes, sizeof(int));
     for (o = 0; o < nprimes; o++)
         primes[o] = 0;
     int l = 0;
     for (k = 2; k < maximumprimes; k++)
         if (era[k] == k)
         {
             primes[l] = k;
             l++;
         }
     printf("%d == %d\n", l, nprimes);
     int sum = 0;
     for (n = 2; n < 1001; n++)
     {
         int other = sumdiv(nprimes, primes, n) - n;
         if (other > n)
         {
             int othersum = sumdiv(nprimes, primes, other) - other;
             if (othersum == n)
             {
                 printf("%d & %d\n", other, n);
                 sum += other + n;
             }
         }
     }
     printf("\n%d\n", sum);
     return 0;
}


