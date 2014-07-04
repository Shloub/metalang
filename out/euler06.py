import math
lim = 100;
sum = math.trunc((lim * (lim + 1)) / 2);
carressum = sum * sum;
sumcarres = math.trunc((lim * (lim + 1) * (2 * lim + 1)) / 6);
a = carressum - sumcarres;
print("%d" % a, end='')

