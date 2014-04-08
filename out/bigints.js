
var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
var read_char_ = function(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}
var stdinsep = function(){
    if (current_char == null) current_char = read_char0();
    while (current_char == '\n' || current_char == ' ' || current_char == '\t')
        current_char = read_char0();
}
var read_int_ = function(){
    if (current_char == null) current_char = read_char0();
    var sign = 1;
    if (current_char == '-'){
        current_char = read_char0();
        sign = -1;
    }
    var out = 0;
    while (true){
        if (current_char.charCodeAt(0) >= '0'.charCodeAt(0) && current_char.charCodeAt(0) <= '9'.charCodeAt(0)){
            out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
            current_char = read_char0();
        }else{
            return out * sign;
        }
    }
}



function max2(a, b){
  if (a > b)
    return a;
  return b;
}


function read_bigint(){
  var len = 0;
  len=read_int_();
  stdinsep();
  var sign = '_';
  sign=read_char_();
  stdinsep();
  var chiffres = new Array(len);
  for (var d = 0 ; d <= len - 1; d++)
  {
    var c = '_';
    c=read_char_();
    chiffres[d] = c.charCodeAt(0) - '0'.charCodeAt(0);
  }
  for (var i = 0 ; i <= ~~((len - 1) / 2); i++)
  {
    var tmp = chiffres[i];
    chiffres[i] = chiffres[len - 1 - i];
    chiffres[len - 1 - i] = tmp;
  }
  stdinsep();
  var m = {
             bigint_sign : sign == '+',
             bigint_len : len,
             bigint_chiffres : chiffres
  };
  return m;
}

function print_bigint(a){
  if (!a.bigint_sign)
    util.print('-');
  for (var i = 0 ; i <= a.bigint_len - 1; i++)
  {
    var e = a.bigint_chiffres[a.bigint_len - 1 - i];
    util.print(e);
  }
}

function bigint_eq(a, b){
  /* Renvoie vrai si a = b */
  if (a.bigint_sign != b.bigint_sign)
    return 0;
  else if (a.bigint_len != b.bigint_len)
    return 0;
  else
  {
    for (var i = 0 ; i <= a.bigint_len - 1; i++)
      if (a.bigint_chiffres[i] != b.bigint_chiffres[i])
      return 0;
    return 1;
  }
}

function bigint_gt(a, b){
  /* Renvoie vrai si a > b */
  if (a.bigint_sign && !b.bigint_sign)
    return 1;
  else if (!a.bigint_sign && b.bigint_sign)
    return 0;
  else
  {
    if (a.bigint_len > b.bigint_len)
      return a.bigint_sign;
    else if (a.bigint_len < b.bigint_len)
      return !a.bigint_sign;
    else
      for (var i = 0 ; i <= a.bigint_len - 1; i++)
      {
        var j = a.bigint_len - 1 - i;
        if (a.bigint_chiffres[j] > b.bigint_chiffres[j])
          return a.bigint_sign;
        else if (a.bigint_chiffres[j] < b.bigint_chiffres[j])
          return a.bigint_sign;
    }
    return 1;
  }
}

function bigint_lt(a, b){
  return !bigint_gt(a, b);
}

function add_bigint_positif(a, b){
  /* Une addition ou on en a rien a faire des signes */
  var len = max2(a.bigint_len, b.bigint_len) + 1;
  var retenue = 0;
  var chiffres = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
  {
    var tmp = retenue;
    if (i < a.bigint_len)
      tmp += a.bigint_chiffres[i];
    if (i < b.bigint_len)
      tmp += b.bigint_chiffres[i];
    retenue = ~~(tmp / 10);
    chiffres[i] = ~~(tmp % 10);
  }
  if (chiffres[len - 1] == 0)
    len --;
  var n = {
             bigint_sign : 1,
             bigint_len : len,
             bigint_chiffres : chiffres
  };
  return n;
}

function sub_bigint_positif(a, b){
  /* Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
*/
  var len = a.bigint_len;
  var retenue = 0;
  var chiffres = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
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
  var o = {
             bigint_sign : 1,
             bigint_len : len,
             bigint_chiffres : chiffres
  };
  return o;
}

function neg_bigint(a){
  var p = {
             bigint_sign : !a.bigint_sign,
             bigint_len : a.bigint_len,
             bigint_chiffres : a.bigint_chiffres
  };
  return p;
}

function add_bigint(a, b){
  if (a.bigint_sign == b.bigint_sign)
    if (a.bigint_sign)
    return add_bigint_positif(a, b);
  else
    return neg_bigint(add_bigint_positif(a, b));
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
  for (var k = 0 ; k <= len - 1; k++)
    chiffres[k] = 0;
  for (var i = 0 ; i <= a.bigint_len - 1; i++)
  {
    var retenue = 0;
    for (var j = 0 ; j <= b.bigint_len - 1; j++)
    {
      chiffres[i + j] = chiffres[i + j] + retenue + b.bigint_chiffres[j] * a.bigint_chiffres[i];
      retenue = ~~(chiffres[i + j] / 10);
      chiffres[i + j] = ~~(chiffres[i + j] % 10);
    }
    chiffres[i + b.bigint_len] = chiffres[i + b.bigint_len] + retenue;
  }
  chiffres[a.bigint_len + b.bigint_len] = ~~(chiffres[a.bigint_len + b.bigint_len - 1] / 10);
  chiffres[a.bigint_len + b.bigint_len - 1] = ~~(chiffres[a.bigint_len + b.bigint_len - 1] % 10);
  for (var l = 0 ; l <= 2; l++)
    if (len != 0 && chiffres[len - 1] == 0)
    len --;
  var q = {
             bigint_sign : a.bigint_sign == b.bigint_sign,
             bigint_len : len,
             bigint_chiffres : chiffres
  };
  return q;
}

function bigint_premiers_chiffres(a, i){
  var r = {
             bigint_sign : a.bigint_sign,
             bigint_len : i,
             bigint_chiffres : a.bigint_chiffres
  };
  return r;
}

function bigint_shift(a, i){
  var f = a.bigint_len + i;
  var chiffres = new Array(f);
  for (var k = 0 ; k <= f - 1; k++)
    if (k >= i)
    chiffres[k] = a.bigint_chiffres[k - i];
  else
    chiffres[k] = 0;
  var s = {
             bigint_sign : a.bigint_sign,
             bigint_len : a.bigint_len + i,
             bigint_chiffres : chiffres
  };
  return s;
}

function mul_bigint(aa, bb){
  if (aa.bigint_len < 3 || bb.bigint_len < 3)
    return mul_bigint_cp(aa, bb);
  /* Algorithme de Karatsuba */
  var split = ~~(max2(aa.bigint_len, bb.bigint_len) / 2);
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
Exp
*/
function log10(a){
  var out_ = 1;
  while (a >= 10)
  {
    a = ~~(a / 10);
    out_ ++;
  }
  return out_;
}

function bigint_of_int(i){
  var size = log10(i);
  var t = new Array(size);
  for (var j = 0 ; j <= size - 1; j++)
    t[j] = 0;
  for (var k = 0 ; k <= size - 1; k++)
  {
    t[k] = ~~(i % 10);
    i = ~~(i / 10);
  }
  var u = {
             bigint_sign : 1,
             bigint_len : size,
             bigint_chiffres : t
  };
  return u;
}

function fact_bigint(a){
  var one = bigint_of_int(1);
  var out_ = one;
  while (!bigint_eq(a, one))
  {
    out_ = mul_bigint(a, out_);
    a = sub_bigint(a, one);
  }
  return out_;
}

function sum_chiffres_bigint(a){
  var out_ = 0;
  for (var i = 0 ; i <= a.bigint_len - 1; i++)
    out_ += a.bigint_chiffres[i];
  return out_;
}

/* http://projecteuler.net/problem=20 */
function euler20(){
  var a = bigint_of_int(100);
  a = fact_bigint(a);
  return sum_chiffres_bigint(a);
}

util.print("euler20 = ");
var g = euler20();
util.print(g, "\n");
var a = read_bigint();
var b = read_bigint();
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
var h = bigint_gt(a, b);
if (h)
  util.print("True");
else
  util.print("False");
util.print("\n");


