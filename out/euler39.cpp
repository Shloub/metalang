#include <iostream>
#include <vector>
#include<cmath>

int main(void) {
    std::vector<int> t( 1001, 0 );
    for (int a = 1; a <= 1000; a += 1)
        for (int b = 1; b <= 1000; b += 1)
        {
            int c2 = a * a + b * b;
            int c = (int)sqrt(c2);
            if (c * c == c2)
            {
                int p = a + b + c;
                if (p <= 1000)
                    t[p] += 1;
            }
        }
    int j = 0;
    for (int k = 1; k <= 1000; k += 1)
        if (t[k] > t[j])
            j = k;
    std::cout << j;
    return 0;
}

