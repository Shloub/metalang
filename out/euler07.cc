#include <iostream>
#include <vector>

bool divisible(int n, std::vector<int> * t, int size) {
    for (int i = 0; i < size; i++)
        if (n % t->at(i) == 0)
            return true;
    return false;
}


int find(int n, std::vector<int> * t, int used, int nth) {
    while (used != nth)
        if (divisible(n, t, used))
            n++;
        else
        {
            t->at(used) = n;
            n++;
            used++;
        }
    return t->at(used - 1);
}

int main() {
    int n = 10001;
    std::vector<int> *t = new std::vector<int>( n );
    std::fill(t->begin(), t->end(), 2);
    std::cout << find(3, t, 1, n) << "\n";
}

