import java.util.*



int n = 10
/* normalement on doit mettre 20 mais là on se tape un overflow */
n++;
int[][] tab = new int[n][]
for (int i = 0; i < n; i++)
{
    int[] tab2 = new int[n]
    for (int j = 0; j < n; j++)
      tab2[j] = 0
    tab[i] = tab2
}
for (int l = 0; l < n; l++)
{
    tab[n - 1][l] = 1
    tab[l][n - 1] = 1
}
for (int o = 2; o <= n; o ++)
{
    int r = n - o
    for (int p = 2; p <= n; p ++)
    {
        int q = n - p
        tab[r][q] = tab[r + 1][q] + tab[r][q + 1]
    }
}
for (int m = 0; m < n; m++)
{
    for (int k = 0; k < n; k++)
      System.out.printf("%s ", tab[m][k]);
    print("\n")
}
System.out.printf("%s\n", tab[0][0]);

