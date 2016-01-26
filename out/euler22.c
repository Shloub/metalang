#include <stdio.h>
#include <stdlib.h>


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
    return sum;
}

int main(void) {
    int i, n;
    int sum = 0;
    scanf("%d", &n);
    for (i = 1; i <= n; i++)
      sum += i * score();
    printf("%d\n", sum);
    return 0;
}


