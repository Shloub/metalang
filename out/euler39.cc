#include <iostream>
#include <vector>
#include<cmath>

int main() {
    std::vector<int> *t = new std::vector<int>( 1001 );
    std::fill(t->begin(), t->end(), 0);
    for (int a = 1; a < 1001; a++)
        for (int b = 1; b < 1001; b++)
        {
            int c2 = a * a + b * b;
            int c = (int)sqrt(c2);
            if (c * c == c2)
            {
                int p = a + b + c;
                if (p < 1001)
                    t->at(p)++;
            }
        }
    int j = 0;
    for (int k = 1; k < 1001; k++)
        if (t->at(k) > t->at(j))
            j = k;
    std::cout << j;
}

