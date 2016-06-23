import math
def mod(x, y):
    return x - y * math.trunc(x / y)


def is_leap(year):
    return mod(year, 400) == 0 or mod(year, 100) != 0 and mod(year, 4) == 0

def ndayinmonth(month, year):
    if month == 0:
        return 31
    elif month == 1:
        if is_leap(year):
            return 29
        else:
            return 28
    elif month == 2:
        return 31
    elif month == 3:
        return 30
    elif month == 4:
        return 31
    elif month == 5:
        return 30
    elif month == 6:
        return 31
    elif month == 7:
        return 31
    elif month == 8:
        return 30
    elif month == 9:
        return 31
    elif month == 10:
        return 30
    elif month == 11:
        return 31
    return 0

month = 0
year = 1901
dayofweek = 1
# 01-01-1901 : mardi 

count = 0
while year != 2001:
    ndays = ndayinmonth(month, year)
    dayofweek = mod(dayofweek + ndays, 7)
    month += 1
    if month == 12:
        month = 0
        year += 1
    if mod(dayofweek, 7) == 6:
        count += 1
print("%d\n" % count, end='')

