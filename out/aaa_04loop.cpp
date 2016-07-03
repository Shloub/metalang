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
        j += 1;
    }
    return false;
}


int main(void) {
    int j = 0;
    for (int k = 0; k <= 10; k += 1)
    {
        j += k;
        std::cout << j << "\n";
    }
    int i = 4;
    while (i < 10)
    {
        std::cout << i;
        i += 1;
        j += i;
    }
    std::cout << j << i << "FIN TEST\n";
    return 0;
}

