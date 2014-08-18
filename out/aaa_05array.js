function id(b){
  return b;
}

function g(t, index){
  t[index] = 0;
}

var c = 5;
var a = new Array(c);
for (var i = 0 ; i <= c - 1; i++)
{
  util.print(i);
  a[i] = (~~(i % 2)) == 0;
}
var d = a[0];
if (d)
  util.print("True");
else
  util.print("False");
util.print("\n");
g(id(a), 0);
var e = a[0];
if (e)
  util.print("True");
else
  util.print("False");
util.print("\n");

