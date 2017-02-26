#include <stdio.h>
#include <stdlib.h>
#include <math.h>




int is_triangular(int n) {
    /*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   */
    int a = (int)sqrt(n * 2);
    return a * (a + 1) == n * 2;
}


int score() {
    int i, len;
    char c;
    scanf(" %d ", &len);
    int sum = 0;
    for (i = 1; i <= len; i++)
    {
        scanf("%c", &c);
        sum += (int)(c) - (int)('A') + 1;
        /*		print c print " " print sum print " " */
    }
    if (is_triangular(sum))
        return 1;
    else
        return 0;
}
int main(void) {
    int n, i;
    for (i = 1; i < 56; i++)
        if (is_triangular(i))
            printf("%d ", i);
    printf("\n");
    int sum = 0;
    scanf("%d", &n);
    for (i = 1; i <= n; i++)
        sum += score();
    printf("%d\n", sum);
    return 0;
}


