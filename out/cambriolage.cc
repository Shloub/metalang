#include <iostream>
#include <vector>
#include <algorithm>


int nbPassePartout(int n, std::vector<std::vector<int> *> * passepartout, int m, std::vector<std::vector<int> *> * serrures) {
    int max_ancient = 0;
    int max_recent = 0;
    for (int i = 0; i < m; i++)
    {
        if (serrures->at(i)->at(0) == -1 && serrures->at(i)->at(1) > max_ancient)
            max_ancient = serrures->at(i)->at(1);
        if (serrures->at(i)->at(0) == 1 && serrures->at(i)->at(1) > max_recent)
            max_recent = serrures->at(i)->at(1);
    }
    int max_ancient_pp = 0;
    int max_recent_pp = 0;
    for (int i = 0; i < n; i++)
    {
        std::vector<int> * pp = passepartout->at(i);
        if (pp->at(0) >= max_ancient && pp->at(1) >= max_recent)
            return 1;
        max_ancient_pp = std::max(max_ancient_pp, pp->at(0));
        max_recent_pp = std::max(max_recent_pp, pp->at(1));
    }
    if (max_ancient_pp >= max_ancient && max_recent_pp >= max_recent)
        return 2;
    else
        return 0;
}

int main() {
    int out_, m, out01, n;
    std::cin >> n;
    std::vector<std::vector<int> *> *passepartout = new std::vector<std::vector<int> *>( n );
    for (int i = 0; i < n; i++)
    {
        std::vector<int> *out0 = new std::vector<int>( 2 );
        for (int j = 0; j < 2; j++)
        {
            std::cin >> out01;
            out0->at(j) = out01;
        }
        passepartout->at(i) = out0;
    }
    std::cin >> m;
    std::vector<std::vector<int> *> *serrures = new std::vector<std::vector<int> *>( m );
    for (int k = 0; k < m; k++)
    {
        std::vector<int> *out1 = new std::vector<int>( 2 );
        for (int l = 0; l < 2; l++)
        {
            std::cin >> out_;
            out1->at(l) = out_;
        }
        serrures->at(k) = out1;
    }
    std::cout << nbPassePartout(n, passepartout, m, serrures);
}

