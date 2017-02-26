#include <iostream>
#include <vector>

bool h(int i) {
    /*  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end */
    int j = i - 2;
    while (j <= i + 2)
    {
        if (i % j == 5)
            return true;
        j++;
    }
    return false;
}

int main() {
    int j = 0;
    for (int k = 0; k < 11; k++)
    {
        j += k;
        std::cout << j << "\n";
    }
    int i = 4;
    while (i < 10)
    {
        std::cout << i;
        i++;
        j += i;
    }
    std::cout << j << i << "FIN TEST\n";
}

