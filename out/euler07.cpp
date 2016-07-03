#include <iostream>
#include <vector>

bool divisible(int n, std::vector<int>& t, int size) {
    for (int i = 0; i < size; i += 1)
        if (n % t[i] == 0)
            return true;
    return false;
}


int find(int n, std::vector<int>& t, int used, int nth) {
    while (used != nth)
        if (divisible(n, t, used))
            n += 1;
        else
        {
            t[used] = n;
            n += 1;
            used += 1;
        }
    return t[used - 1];
}


int main(void) {
    int n = 10001;
    std::vector<int> t( n, 2 );
    std::cout << find(3, t, 1, n) << "\n";
    return 0;
}

