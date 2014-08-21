require "scanf.rb"
def min2( a, b )
    if a < b then
      return (a);
    else
      return (b);
    end
end

h = 1
i = 2
j = 3
k = 4
l = min2(h, i)
m = min2(min2(l, j), k)
g = m
printf "%d ", g
o = 1
p = 2
q = 4
r = 3
s = min2(o, p)
t = min2(min2(s, q), r)
n = t
printf "%d ", n
v = 1
w = 3
x = 2
y = 4
z = min2(v, w)
ba = min2(min2(z, x), y)
u = ba
printf "%d ", u
bc = 1
bd = 3
be = 4
bf = 2
bg = min2(bc, bd)
bh = min2(min2(bg, be), bf)
bb = bh
printf "%d ", bb
bj = 1
bk = 4
bl = 2
bm = 3
bn = min2(bj, bk)
bo = min2(min2(bn, bl), bm)
bi = bo
printf "%d ", bi
bq = 1
br = 4
bs = 3
bt = 2
bu = min2(bq, br)
bv = min2(min2(bu, bs), bt)
bp = bv
printf "%d\n", bp
bx = 2
by = 1
bz = 3
ca = 4
cb = min2(bx, by)
cc = min2(min2(cb, bz), ca)
bw = cc
printf "%d ", bw
ce = 2
cf = 1
cg = 4
ch = 3
ci = min2(ce, cf)
cj = min2(min2(ci, cg), ch)
cd = cj
printf "%d ", cd
cl = 2
cm = 3
cn = 1
co = 4
cp = min2(cl, cm)
cq = min2(min2(cp, cn), co)
ck = cq
printf "%d ", ck
cs = 2
ct = 3
cu = 4
cv = 1
cw = min2(cs, ct)
cx = min2(min2(cw, cu), cv)
cr = cx
printf "%d ", cr
cz = 2
da = 4
db = 1
dc = 3
dd = min2(cz, da)
de = min2(min2(dd, db), dc)
cy = de
printf "%d ", cy
dg = 2
dh = 4
di = 3
dj = 1
dk = min2(dg, dh)
dl = min2(min2(dk, di), dj)
df = dl
printf "%d\n", df
dn = 3
dp = 1
dq = 2
dr = 4
ds = min2(dn, dp)
dt = min2(min2(ds, dq), dr)
dm = dt
printf "%d ", dm
dv = 3
dw = 1
dx = 4
dy = 2
dz = min2(dv, dw)
ea = min2(min2(dz, dx), dy)
du = ea
printf "%d ", du
ec = 3
ed = 2
ee = 1
ef = 4
eg = min2(ec, ed)
eh = min2(min2(eg, ee), ef)
eb = eh
printf "%d ", eb
ej = 3
ek = 2
el = 4
em = 1
en = min2(ej, ek)
eo = min2(min2(en, el), em)
ei = eo
printf "%d ", ei
eq = 3
er = 4
es = 1
et = 2
eu = min2(eq, er)
ev = min2(min2(eu, es), et)
ep = ev
printf "%d ", ep
ex = 3
ey = 4
ez = 2
fa = 1
fb = min2(ex, ey)
fc = min2(min2(fb, ez), fa)
ew = fc
printf "%d\n", ew
fe = 4
ff = 1
fg = 2
fh = 3
fi = min2(fe, ff)
fj = min2(min2(fi, fg), fh)
fd = fj
printf "%d ", fd
fl = 4
fm = 1
fn = 3
fo = 2
fp = min2(fl, fm)
fq = min2(min2(fp, fn), fo)
fk = fq
printf "%d ", fk
fs = 4
ft = 2
fu = 1
fv = 3
fw = min2(fs, ft)
fx = min2(min2(fw, fu), fv)
fr = fx
printf "%d ", fr
fz = 4
ga = 2
gb = 3
gc = 1
gd = min2(fz, ga)
ge = min2(min2(gd, gb), gc)
fy = ge
printf "%d ", fy
gg = 4
gh = 3
gi = 1
gj = 2
gk = min2(gg, gh)
gl = min2(min2(gk, gi), gj)
gf = gl
printf "%d ", gf
gn = 4
gp = 3
gq = 2
gr = 1
gs = min2(gn, gp)
gt = min2(min2(gs, gq), gr)
gm = gt
printf "%d\n", gm

