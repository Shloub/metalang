import java.util.*



int lim = 100
int sum = (lim * (lim + 1)).intdiv(2)
int carressum = sum * sum
int sumcarres = (lim * (lim + 1) * (2 * lim + 1)).intdiv(6)
print(carressum - sumcarres)

