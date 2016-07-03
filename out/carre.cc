#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    int y, x;
    std::cin >> x >> y;
    std::vector<std::vector<int> *> *tab = new std::vector<std::vector<int> *>( y );
    for (int d = 0; d < y; d += 1)
    {
        std::vector<int> *e = new std::vector<int>( x );
        for (int f = 0; f < x; f += 1)
        {
            std::cin >> e->at(f);
        }
        tab->at(d) = e;
    }
    for (int ix = 1; ix < x; ix += 1)
        for (int iy = 1; iy < y; iy += 1)
            if (tab->at(iy)->at(ix) == 1)
                tab->at(iy)->at(ix) = std::min({tab->at(iy)->at(ix - 1), tab->at(iy - 1)->at(ix), tab->at(iy - 1)->at(ix - 1)}) + 1;
    for (int jy = 0; jy < y; jy += 1)
    {
        for (int jx = 0; jx < x; jx += 1)
            std::cout << tab->at(jy)->at(jx) << " ";
        std::cout << "\n";
    }
}

