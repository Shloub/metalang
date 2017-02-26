#include <stdio.h>
#include <stdlib.h>



int programme_candidat(char* tableau1, int taille1, char* tableau2, int taille2) {
    int j, i;
    int out0 = 0;
    for (i = 0; i < taille1; i++)
    {
        out0 += (int)(tableau1[i]) * i;
        printf("%c", tableau1[i]);
    }
    printf("--\n");
    for (j = 0; j < taille2; j++)
    {
        out0 += (int)(tableau2[j]) * j * 100;
        printf("%c", tableau2[j]);
    }
    printf("--\n");
    return out0;
}
int main(void) {
    int b, taille2, a, taille1;
    scanf("%d ", &taille1);
    char *tableau1 = calloc(taille1, sizeof(char));
    for (a = 0; a < taille1; a++)
        scanf("%c", &tableau1[a]);
    scanf(" %d ", &taille2);
    char *tableau2 = calloc(taille2, sizeof(char));
    for (b = 0; b < taille2; b++)
        scanf("%c", &tableau2[b]);
    scanf(" ");
    printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
    return 0;
}


