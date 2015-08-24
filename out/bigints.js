var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
function read_char_(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}
function stdinsep(){
    if (current_char == null) current_char = read_char0();
    while (current_char.match(/[\n\t\s]/g))
        current_char = read_char0();
}
function read_bigint(len){
  var chiffres = new Array(len);
  for (var j = 0 ; j < len; j++)
  {
    c=read_char_();
    chiffres[j] = c.charCodeAt(0);
  }
  for (var i = 0 ; i <= ~~((len - 1) / 2); i++)
  {
    var tmp = chiffres[i];
    chiffres[i] = chiffres[len - 1 - i];
    chiffres[len - 1 - i] = tmp;
  }
  var e = {
    bigint_sign : true,
    bigint_len : len,
    bigint_chiffres : chiffres
  };
  return e;
}

function print_bigint(a){
  if (!a.bigint_sign)
    util.print('-');
  for (var i = 0 ; i < a.bigint_len; i++)
    util.print(a.bigint_chiffres[a.bigint_len - 1 - i]);
}

function bigint_eq(a, b){
  /* Renvoie vrai si a = b */
  if (a.bigint_sign != b.bigint_sign)
    return false;
  else if (a.bigint_len != b.bigint_len)
    return false;
  else
  {
    for (var i = 0 ; i < a.bigint_len; i++)
      if (a.bigint_chiffres[i] != b.bigint_chiffres[i])
      return false;
    return true;
  }
}

function bigint_gt(a, b){
  /* Renvoie vrai si a > b */
  if (a.bigint_sign && !b.bigint_sign)
    return true;
  else if (!a.bigint_sign && b.bigint_sign)
    return false;
  else
  {
    if (a.bigint_len > b.bigint_len)
      return a.bigint_sign;
    else if (a.bigint_len < b.bigint_len)
      return !a.bigint_sign;
    else
      for (var i = 0 ; i < a.bigint_len; i++)
      {
        var j = a.bigint_len - 1 - i;
        if (a.bigint_chiffres[j] > b.bigint_chiffres[j])
          return a.bigint_sign;
        else if (a.bigint_chiffres[j] < b.bigint_chiffres[j])
          return !a.bigint_sign;
    }
    return true;
  }
}

function bigint_lt(a, b){
  return !bigint_gt(a, b);
}

function add_bigint_positif(a, b){
  /* Une addition ou on en a rien a faire des signes */
  var len = Math.max(a.bigint_len, b.bigint_len) + 1;
  var retenue = 0;
  var chiffres = new Array(len);
  for (var i = 0 ; i < len; i++)
  {
    var tmp = retenue;
    if (i < a.bigint_len)
      tmp += a.bigint_chiffres[i];
    if (i < b.bigint_len)
      tmp += b.bigint_chiffres[i];
    retenue = ~~(tmp / 10);
    chiffres[i] = ~~(tmp % 10);
  }
  while (len > 0 && chiffres[len - 1] == 0)
    len --;
  var f = {
    bigint_sign : true,
    bigint_len : len,
    bigint_chiffres : chiffres
  };
  return f;
}

function sub_bigint_positif(a, b){
  /* Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
*/
  var len = a.bigint_len;
  var retenue = 0;
  var chiffres = new Array(len);
  for (var i = 0 ; i < len; i++)
  {
    var tmp = retenue + a.bigint_chiffres[i];
    if (i < b.bigint_len)
      tmp -= b.bigint_chiffres[i];
    if (tmp < 0)
    {
      tmp += 10;
      retenue = -1;
    }
    else
      retenue = 0;
    chiffres[i] = tmp;
  }
  while (len > 0 && chiffres[len - 1] == 0)
    len --;
  var g = {
    bigint_sign : true,
    bigint_len : len,
    bigint_chiffres : chiffres
  };
  return g;
}

function neg_bigint(a){
  var h = {
    bigint_sign : !a.bigint_sign,
    bigint_len : a.bigint_len,
    bigint_chiffres : a.bigint_chiffres
  };
  return h;
}

function add_bigint(a, b){
  if (a.bigint_sign == b.bigint_sign)
  {
    if (a.bigint_sign)
      return add_bigint_positif(a, b);
    else
      return neg_bigint(add_bigint_positif(a, b));
  }
  else if (a.bigint_sign)
  {
    /* a positif, b negatif */
    if (bigint_gt(a, neg_bigint(b)))
      return sub_bigint_positif(a, b);
    else
      return neg_bigint(sub_bigint_positif(b, a));
  }
  else
  {
    /* a negatif, b positif */
    if (bigint_gt(neg_bigint(a), b))
      return neg_bigint(sub_bigint_positif(a, b));
    else
      return sub_bigint_positif(b, a);
  }
}

function sub_bigint(a, b){
  return add_bigint(a, neg_bigint(b));
}

function mul_bigint_cp(a, b){
  /* Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. */
  var len = a.bigint_len + b.bigint_len + 1;
  var chiffres = new Array(len);
  for (var k = 0 ; k < len; k++)
    chiffres[k] = 0;
  for (var i = 0 ; i < a.bigint_len; i++)
  {
    var retenue = 0;
    for (var j = 0 ; j < b.bigint_len; j++)
    {
      chiffres[i + j] =
      chiffres[i + j] + retenue + b.bigint_chiffres[j] * a.bigint_chiffres[i];
      retenue = ~~(chiffres[i + j] / 10);
      chiffres[i + j] = ~~(chiffres[i + j] % 10);
    }
    chiffres[i + b.bigint_len] = chiffres[i + b.bigint_len] + retenue;
  }
  chiffres[a.bigint_len + b.bigint_len] =
  ~~(chiffres[a.bigint_len + b.bigint_len - 1] / 10);
  chiffres[a.bigint_len + b.bigint_len - 1] =
  ~~(chiffres[a.bigint_len + b.bigint_len - 1] % 10);
  for (var l = 0 ; l <= 2; l++)
    if (len != 0 && chiffres[len - 1] == 0)
    len --;
  var m = {
    bigint_sign : a.bigint_sign == b.bigint_sign,
    bigint_len : len,
    bigint_chiffres : chiffres
  };
  return m;
}

function bigint_premiers_chiffres(a, i){
  var len = Math.min(i, a.bigint_len);
  while (len != 0 && a.bigint_chiffres[len - 1] == 0)
    len --;
  var o = {
    bigint_sign : a.bigint_sign,
    bigint_len : len,
    bigint_chiffres : a.bigint_chiffres
  };
  return o;
}

function bigint_shift(a, i){
  var chiffres = new Array(a.bigint_len + i);
  for (var k = 0 ; k < a.bigint_len + i; k++)
    if (k >= i)
    chiffres[k] = a.bigint_chiffres[k - i];
  else
    chiffres[k] = 0;
  var p = {
    bigint_sign : a.bigint_sign,
    bigint_len : a.bigint_len + i,
    bigint_chiffres : chiffres
  };
  return p;
}

function mul_bigint(aa, bb){
  if (aa.bigint_len == 0)
    return aa;
  else if (bb.bigint_len == 0)
    return bb;
  else if (aa.bigint_len < 3 || bb.bigint_len < 3)
    return mul_bigint_cp(aa, bb);
  /* Algorithme de Karatsuba */
  var split = ~~(Math.min(aa.bigint_len, bb.bigint_len) / 2);
  var a = bigint_shift(aa, -split);
  var b = bigint_premiers_chiffres(aa, split);
  var c = bigint_shift(bb, -split);
  var d = bigint_premiers_chiffres(bb, split);
  var amoinsb = sub_bigint(a, b);
  var cmoinsd = sub_bigint(c, d);
  var ac = mul_bigint(a, c);
  var bd = mul_bigint(b, d);
  var amoinsbcmoinsd = mul_bigint(amoinsb, cmoinsd);
  var acdec = bigint_shift(ac, 2 * split);
  return add_bigint(add_bigint(acdec, bd), bigint_shift(sub_bigint(add_bigint(ac, bd), amoinsbcmoinsd), split));
  /* ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd */
}

/*
Division,
Modulo
*/
function log10(a){
  var out0 = 1;
  while (a >= 10)
  {
    a = ~~(a / 10);
    out0 ++;
  }
  return out0;
}

function bigint_of_int(i){
  var size = log10(i);
  if (i == 0)
    size = 0;
  var t = new Array(size);
  for (var j = 0 ; j < size; j++)
    t[j] = 0;
  for (var k = 0 ; k < size; k++)
  {
    t[k] = ~~(i % 10);
    i = ~~(i / 10);
  }
  var q = {
    bigint_sign : true,
    bigint_len : size,
    bigint_chiffres : t
  };
  return q;
}

function fact_bigint(a){
  var one = bigint_of_int(1);
  var out0 = one;
  while (!bigint_eq(a, one))
  {
    out0 = mul_bigint(a, out0);
    a = sub_bigint(a, one);
  }
  return out0;
}

function sum_chiffres_bigint(a){
  var out0 = 0;
  for (var i = 0 ; i < a.bigint_len; i++)
    out0 += a.bigint_chiffres[i];
  return out0;
}

/* http://projecteuler.net/problem=20 */
function euler20(){
  var a = bigint_of_int(15);
  /* normalement c'est 100 */
  a = fact_bigint(a);
  return sum_chiffres_bigint(a);
}

function bigint_exp(a, b){
  if (b == 1)
    return a;
  else if (~~(b % 2) == 0)
    return bigint_exp(mul_bigint(a, a), ~~(b / 2));
  else
    return mul_bigint(a, bigint_exp(a, b - 1));
}

function bigint_exp_10chiffres(a, b){
  a = bigint_premiers_chiffres(a, 10);
  if (b == 1)
    return a;
  else if (~~(b % 2) == 0)
    return bigint_exp_10chiffres(mul_bigint(a, a), ~~(b / 2));
  else
    return mul_bigint(a, bigint_exp_10chiffres(a, b - 1));
}

function euler48(){
  var sum = bigint_of_int(0);
  for (var i = 1 ; i <= 100; i++)
  {
    /* 1000 normalement */
    var ib = bigint_of_int(i);
    var ibeib = bigint_exp_10chiffres(ib, i);
    sum = add_bigint(sum, ibeib);
    sum = bigint_premiers_chiffres(sum, 10);
  }
  util.print("euler 48 = ");
  print_bigint(sum);
  util.print("\n");
}

function euler16(){
  var a = bigint_of_int(2);
  a = bigint_exp(a, 100);
  /* 1000 normalement */
  return sum_chiffres_bigint(a);
}

function euler25(){
  var i = 2;
  var a = bigint_of_int(1);
  var b = bigint_of_int(1);
  while (b.bigint_len < 100)
  {
    /* 1000 normalement */
    var c = add_bigint(a, b);
    a = b;
    b = c;
    i ++;
  }
  return i;
}

function euler29(){
  var maxA = 5;
  var maxB = 5;
  var a_bigint = new Array(maxA + 1);
  for (var j = 0 ; j < maxA + 1; j++)
    a_bigint[j] = bigint_of_int(j * j);
  var a0_bigint = new Array(maxA + 1);
  for (var j2 = 0 ; j2 < maxA + 1; j2++)
    a0_bigint[j2] = bigint_of_int(j2);
  var b = new Array(maxA + 1);
  for (var k = 0 ; k < maxA + 1; k++)
    b[k] = 2;
  var n = 0;
  var found = true;
  while (found)
  {
    var min0 = a0_bigint[0];
    found = false;
    for (var i = 2 ; i <= maxA; i++)
      if (b[i] <= maxB)
    {
      if (found)
      {
        if (bigint_lt(a_bigint[i], min0))
          min0 = a_bigint[i];
      }
      else
      {
        min0 = a_bigint[i];
        found = true;
      }
    }
    if (found)
    {
      n ++;
      for (var l = 2 ; l <= maxA; l++)
        if (bigint_eq(a_bigint[l], min0) && b[l] <= maxB)
      {
        b[l] = b[l] + 1;
        a_bigint[l] = mul_bigint(a_bigint[l], a0_bigint[l]);
      }
    }
  }
  return n;
}

util.print(euler29(), "\n");
var sum = read_bigint(50);
for (var i = 2 ; i <= 100; i++)
{
  stdinsep();
  var tmp = read_bigint(50);
  sum = add_bigint(sum, tmp);
}
util.print("euler13 = ");
print_bigint(sum);
util.print("\neuler25 = ", euler25(), "\neuler16 = ", euler16(), "\n");
euler48();
util.print("euler20 = ", euler20(), "\n");
var a = bigint_of_int(999999);
var b = bigint_of_int(9951263);
print_bigint(a);
util.print(">>1=");
print_bigint(bigint_shift(a, -1));
util.print("\n");
print_bigint(a);
util.print("*");
print_bigint(b);
util.print("=");
print_bigint(mul_bigint(a, b));
util.print("\n");
print_bigint(a);
util.print("*");
print_bigint(b);
util.print("=");
print_bigint(mul_bigint_cp(a, b));
util.print("\n");
print_bigint(a);
util.print("+");
print_bigint(b);
util.print("=");
print_bigint(add_bigint(a, b));
util.print("\n");
print_bigint(b);
util.print("-");
print_bigint(a);
util.print("=");
print_bigint(sub_bigint(b, a));
util.print("\n");
print_bigint(a);
util.print("-");
print_bigint(b);
util.print("=");
print_bigint(sub_bigint(a, b));
util.print("\n");
print_bigint(a);
util.print(">");
print_bigint(b);
util.print("=");
if (bigint_gt(a, b))
  util.print("True");
else
  util.print("False");
util.print("\n");

