import java.util.*



/*
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17
Find the sum of all 0 to 9 pandigital numbers with this property.

d4 % 2 == 0
(d3 + d4 + d5) % 3 == 0
d6 = 5 ou d6 = 0
(d5 * 100 + d6 * 10 + d7  ) % 7 == 0
(d6 * 100 + d7 * 10 + d8  ) % 11 == 0
(d7 * 100 + d8 * 10 + d9  ) % 13 == 0
(d8 * 100 + d9 * 10 + d10 ) % 17 == 0


d4 % 2 == 0
d6 = 5 ou d6 = 0

(d3 + d4 + d5) % 3 == 0
(d5 * 2 + d6 * 3 + d7) % 7 == 0
*/
boolean[] allowed = new boolean[10]
for (int i = 0; i < 10; i += 1)
    allowed[i] = true
for (int i6 = 0; i6 < 2; i6 += 1)
{
    int d6 = i6 * 5
    if (allowed[d6])
    {
        allowed[d6] = false
        for (int d7 = 0; d7 < 10; d7 += 1)
            if (allowed[d7])
            {
                allowed[d7] = false
                for (int d8 = 0; d8 < 10; d8 += 1)
                    if (allowed[d8])
                    {
                        allowed[d8] = false
                        for (int d9 = 0; d9 < 10; d9 += 1)
                            if (allowed[d9])
                            {
                                allowed[d9] = false
                                for (int d10 = 1; d10 < 10; d10 += 1)
                                    if (allowed[d10] && (d6 * 100 + d7 * 10 + d8) % 11 == 0 && (d7 * 100 + d8 * 10 + d9) % 13 == 0 && (d8 * 100 + d9 * 10 + d10) % 17 == 0)
                                    {
                                        allowed[d10] = false
                                        for (int d5 = 0; d5 < 10; d5 += 1)
                                            if (allowed[d5])
                                            {
                                                allowed[d5] = false
                                                if ((d5 * 100 + d6 * 10 + d7) % 7 == 0)
                                                    for (int i4 = 0; i4 < 5; i4 += 1)
                                                    {
                                                        int d4 = i4 * 2
                                                        if (allowed[d4])
                                                        {
                                                            allowed[d4] = false
                                                            for (int d3 = 0; d3 < 10; d3 += 1)
                                                                if (allowed[d3])
                                                                {
                                                                    allowed[d3] = false
                                                                    if ((d3 + d4 + d5) % 3 == 0)
                                                                        for (int d2 = 0; d2 < 10; d2 += 1)
                                                                            if (allowed[d2])
                                                                            {
                                                                                allowed[d2] = false
                                                                                for (int d1 = 0; d1 < 10; d1 += 1)
                                                                                    
                                                                                if (allowed[d1])
                                                                                {
                                                                                allowed[d1] = false
                                                                                System.out.printf("%d%d%d%d%d%d%d%d%d%d + ", d1, d2, d3, d4, d5, d6, d7, d8, d9, d10)
                                                                                allowed[d1] = true
                                                                                }
                                                                                allowed[d2] = true
                                                                            }
                                                                    allowed[d3] = true
                                                                }
                                                            allowed[d4] = true
                                                        }
                                                    }
                                                allowed[d5] = true
                                            }
                                        allowed[d10] = true
                                    }
                                allowed[d9] = true
                            }
                        allowed[d8] = true
                    }
                allowed[d7] = true
            }
        allowed[d6] = true
    }
}
System.out.printf("%d\n", 0)

