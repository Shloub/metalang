import java.util.*



int sum = 0
for (int i = 0; i <= 999; i += 1)
    if (i % 3 == 0 || i % 5 == 0)
        sum += i
System.out.printf("%d\n", sum)

