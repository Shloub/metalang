#include <iostream>
#include <vector>

bool palindrome2(std::vector<int>& pow2, int n) {
    std::vector<bool> t( 20 );
    for (int i = 0; i <= 19; i += 1)
        t[i] = n / pow2[i] % 2 == 1;
    int nnum = 0;
    for (int j = 1; j <= 19; j += 1)
        if (t[j])
            nnum = j;
    for (int k = 0; k <= nnum / 2; k += 1)
        if (t[k] != t[nnum - k])
            return false;
    return true;
}


int main() {
    int p = 1;
    std::vector<int> pow2( 20 );
    for (int i = 0; i <= 19; i += 1)
    {
        p *= 2;
        pow2[i] = p / 2;
    }
    int sum = 0;
    for (int d = 1; d <= 9; d += 1)
    {
        if (palindrome2(pow2, d))
        {
            std::cout << d << "\n";
            sum += d;
        }
        if (palindrome2(pow2, d * 10 + d))
        {
            std::cout << d * 10 + d << "\n";
            sum += d * 10 + d;
        }
    }
    for (int a0 = 0; a0 <= 4; a0 += 1)
    {
        int a = a0 * 2 + 1;
        for (int b = 0; b <= 9; b += 1)
        {
            for (int c = 0; c <= 9; c += 1)
            {
                int num0 = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a;
                if (palindrome2(pow2, num0))
                {
                    std::cout << num0 << "\n";
                    sum += num0;
                }
                int num1 = a * 10000 + b * 1000 + c * 100 + b * 10 + a;
                if (palindrome2(pow2, num1))
                {
                    std::cout << num1 << "\n";
                    sum += num1;
                }
            }
            int num2 = a * 100 + b * 10 + a;
            if (palindrome2(pow2, num2))
            {
                std::cout << num2 << "\n";
                sum += num2;
            }
            int num3 = a * 1000 + b * 100 + b * 10 + a;
            if (palindrome2(pow2, num3))
            {
                std::cout << num3 << "\n";
                sum += num3;
            }
        }
    }
    std::cout << "sum=" << sum << "\n";
}

