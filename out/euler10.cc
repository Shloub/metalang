#include <iostream>
#include <vector>

int eratostene(std::vector<int> * t, int max0) {
    int sum = 0;
    for (int i = 2; i < max0; i++)
      if (t->at(i) == i)
    {
        sum += i;
        if (max0 / i > i)
        {
            int j = i * i;
            while (j < max0 && j > 0)
            {
                t->at(j) = 0;
                j += i;
            }
        }
    }
    return sum;
}


int main() {
    int n = 100000;
    /* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
    std::vector<int> *t = new std::vector<int>( n );
    for (int i = 0; i < n; i++)
      t->at(i) = i;
    t->at(1) = 0;
    std::cout << eratostene(t, n) << "\n";
}

