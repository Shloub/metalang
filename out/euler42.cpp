#include <iostream>
#include <vector>
#include<cmath>

bool is_triangular(int n) {
    /*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   */
    int a = (int)sqrt(n * 2);
    return a * (a + 1) == n * 2;
}


int score() {
    int len;
    char c;
    std::cin >> std::skipws >> len;
    int sum = 0;
    for (int i = 1; i <= len; i++)
    {
        std::cin >> c >> std::noskipws;
        sum += (int)(c) - (int)('A') + 1;
        /*		print c print " " print sum print " " */
    }
    if (is_triangular(sum))
        return 1;
    else
        return 0;
}


int main() {
    int n;
    for (int i = 1; i < 56; i++)
        if (is_triangular(i))
            std::cout << i << " ";
    std::cout << "\n";
    int sum = 0;
    std::cin >> n >> std::noskipws;
    for (int i = 1; i <= n; i++)
        sum += score();
    std::cout << sum << "\n";
}

