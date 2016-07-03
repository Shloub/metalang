#include <iostream>
#include <vector>
#include <algorithm>

int nbPassePartout(int n, std::vector<std::vector<int>>& passepartout, int m, std::vector<std::vector<int>>& serrures) {
    int max_ancient = 0;
    int max_recent = 0;
    for (int i = 0; i < m; i += 1)
    {
        if (serrures[i][0] == -1 && serrures[i][1] > max_ancient)
            max_ancient = serrures[i][1];
        if (serrures[i][0] == 1 && serrures[i][1] > max_recent)
            max_recent = serrures[i][1];
    }
    int max_ancient_pp = 0;
    int max_recent_pp = 0;
    for (int i = 0; i < n; i += 1)
    {
        std::vector<int> pp = passepartout[i];
        if (pp[0] >= max_ancient && pp[1] >= max_recent)
            return 1;
        max_ancient_pp = std::max(max_ancient_pp, pp[0]);
        max_recent_pp = std::max(max_recent_pp, pp[1]);
    }
    if (max_ancient_pp >= max_ancient && max_recent_pp >= max_recent)
        return 2;
    else
        return 0;
}


int main() {
    int out_, m, out01, n;
    std::cin >> n;
    std::vector<std::vector<int>> passepartout( n );
    for (int i = 0; i < n; i += 1)
    {
        std::vector<int> out0( 2 );
        for (int j = 0; j <= 1; j += 1)
        {
            std::cin >> out01;
            out0[j] = out01;
        }
        passepartout[i] = out0;
    }
    std::cin >> m;
    std::vector<std::vector<int>> serrures( m );
    for (int k = 0; k < m; k += 1)
    {
        std::vector<int> out1( 2 );
        for (int l = 0; l <= 1; l += 1)
        {
            std::cin >> out_;
            out1[l] = out_;
        }
        serrures[k] = out1;
    }
    std::cout << nbPassePartout(n, passepartout, m, serrures);
}

