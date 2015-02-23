import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False

(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b


main :: IO ()

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

skip_whitespaces :: IO ()
skip_whitespaces =
  ifM (hIsEOF stdin)
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do hGetChar stdin
              skip_whitespaces
           else return ())

read_int_a :: Int -> IO Int
read_int_a b =
  ifM (hIsEOF stdin)
      (return b)
      (do c <- hLookAhead stdin
          if c >= '0' && c <= '9' then
           do hGetChar stdin
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      num <- read_int_a 0
      return (num * sign)


array_init_withenv :: Int -> ( Int -> env -> IO(env, tabcontent)) -> env -> IO(env, IOArray Int tabcontent)
array_init_withenv len f env =
  do (env, li) <- g 0 env
     o <- newListArray (0, len - 1) li
     return (env, o)
  where g i env =
           if i == len
           then return (env, [])
           else do (env', item) <- f i env
                   (env'', li) <- g (i+1) env'
                   return (env'', item:li)



max2_ a b =
  let dr () = ()
              in return ((if (a > b)
                         then a
                         else b))
min2_ a b =
  let dq () = ()
              in return ((if (a < b)
                         then a
                         else b))
data Bigint = Bigint {
                        _bigint_sign :: IORef Bool,
                        _bigint_len :: IORef Int,
                        _bigint_chiffres :: IORef (IOArray Int Int)
                        }
  deriving Eq

read_bigint len =
  ((\ (dl, chiffres) ->
     do return (dl)
        let dn = 0
        let dp = ((len - 1) `quot` 2)
        let dm i =
               (if (i <= dp)
               then do tmp <- (readIOA chiffres i)
                       writeIOA chiffres i =<< (readIOA chiffres ((len - 1) - i))
                       writeIOA chiffres ((len - 1) - i) tmp
                       (dm (i + 1))
               else (Bigint <$> (newIORef True) <*> (newIORef len) <*> (newIORef chiffres))) in
               (dm dn)) =<< (array_init_withenv len (\ j () ->
                                                      hGetChar stdin >>= ((\ c ->
                                                                            do dk <- ((fmap ord (return (c))))
                                                                               return (((), dk))))) ()))
print_bigint a =
  do ifM ((fmap (not) (readIORef (_bigint_sign a))))
         (printf "%c" ('-' :: Char)::IO())
         (return (()))
     let di = 0
     dj <- ((-) <$> (readIORef (_bigint_len a)) <*> return (1))
     let dh i =
            (if (i <= dj)
            then do printf "%d" =<< (join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> return (1)) <*> return (i))) :: IO Int)
                    (dh (i + 1))
            else return (())) in
            (dh di)
bigint_eq a b =
  {- Renvoie vrai si a = b -}
  do let dc () = return (())
     ifM (((/=) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b))))
         (return (False))
         (do let dd () = (dc ())
             ifM (((/=) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))))
                 (return (False))
                 (do let df = 0
                     dg <- ((-) <$> (readIORef (_bigint_len a)) <*> return (1))
                     let de i =
                            (if (i <= dg)
                            then ifM (((/=) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (i)) <*> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (i))))
                                     (return (False))
                                     ((de (i + 1)))
                            else return (True)) in
                            (de df)))
bigint_gt a b =
  {- Renvoie vrai si a > b -}
  do let cu () = return (())
     ifM (((readIORef (_bigint_sign a)) <&&> (fmap (not) (readIORef (_bigint_sign b)))))
         (return (True))
         (do let cv () = (cu ())
             ifM (((fmap (not) (readIORef (_bigint_sign a))) <&&> (readIORef (_bigint_sign b))))
                 (return (False))
                 (do let cw () = return (True)
                     ifM (((>) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))))
                         ((readIORef (_bigint_sign a)))
                         (do let cx () = (cw ())
                             ifM (((<) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))))
                                 ((fmap (not) (readIORef (_bigint_sign a))))
                                 (do let da = 0
                                     db <- ((-) <$> (readIORef (_bigint_len a)) <*> return (1))
                                     let cy i =
                                            (if (i <= db)
                                            then do j <- ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> return (1)) <*> return (i))
                                                    let cz () = (cy (i + 1))
                                                    ifM (((>) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (j)) <*> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (j))))
                                                        ((readIORef (_bigint_sign a)))
                                                        (ifM (((<) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (j)) <*> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (j))))
                                                             ((fmap (not) (readIORef (_bigint_sign a))))
                                                             ((cz ())))
                                            else (cx ())) in
                                            (cy da)))))
bigint_lt a b =
  (fmap (not) (bigint_gt a b))
add_bigint_positif a b =
  {- Une addition ou on en a rien a faire des signes -}
  do len <- ((+) <$> (join (max2_ <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b)))) <*> return (1))
     let retenue = 0
     ((\ (cs, chiffres) ->
        do let dv = cs
           let ct dw =
                  ifM ((return ((dw > 0)) <&&> ((==) <$> (readIOA chiffres (dw - 1)) <*> return (0))))
                      (do let dx = (dw - 1)
                          (ct dx))
                      ((Bigint <$> (newIORef True) <*> (newIORef dw) <*> (newIORef chiffres))) in
                  (ct len)) =<< (array_init_withenv len (\ i dy ->
                                                          do let tmp = dy
                                                             dz <- ifM ((((<) i) <$> (readIORef (_bigint_len a))))
                                                                       (do ea <- (((+) tmp) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (i)))
                                                                           return (ea))
                                                                       (return (tmp))
                                                             eb <- ifM ((((<) i) <$> (readIORef (_bigint_len b))))
                                                                       (do ec <- (((+) dz) <$> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (i)))
                                                                           return (ec))
                                                                       (return (dz))
                                                             let ed = (eb `quot` 10)
                                                             let cr = (eb `rem` 10)
                                                             return ((ed, cr))) retenue))
sub_bigint_positif a b =
  {- Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
-}
  do len <- (readIORef (_bigint_len a))
     let retenue = 0
     ((\ (cp, chiffres) ->
        do let ee = cp
           let cq ef =
                  ifM ((return ((ef > 0)) <&&> ((==) <$> (readIOA chiffres (ef - 1)) <*> return (0))))
                      (do let eg = (ef - 1)
                          (cq eg))
                      ((Bigint <$> (newIORef True) <*> (newIORef ef) <*> (newIORef chiffres))) in
                  (cq len)) =<< (array_init_withenv len (\ i eh ->
                                                          do tmp <- (((+) eh) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (i)))
                                                             ei <- ifM ((((<) i) <$> (readIORef (_bigint_len b))))
                                                                       (do ej <- (((-) tmp) <$> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (i)))
                                                                           return (ej))
                                                                       (return (tmp))
                                                             ((\ (ek, el) ->
                                                                let co = el
                                                                         in return ((ek, co))) (if (ei < 0)
                                                                                               then let em = (ei + 10)
                                                                                                             in let en = (- 1)
                                                                                                                         in (en, em)
                                                                                               else let eo = 0
                                                                                                             in (eo, ei)))) retenue))
neg_bigint a =
  (Bigint <$> (join (newIORef <$> (fmap (not) (readIORef (_bigint_sign a))))) <*> (join (newIORef <$> (readIORef (_bigint_len a)))) <*> (join (newIORef <$> (readIORef (_bigint_chiffres a)))))
add_bigint a b =
  do let cj () = return (())
     ifM (((==) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b))))
         (do let ck () = (cj ())
             ifM ((readIORef (_bigint_sign a)))
                 ((add_bigint_positif a b))
                 ((neg_bigint =<< (add_bigint_positif a b))))
         (do let cl () = (cj ())
             ifM ((readIORef (_bigint_sign a)))
                 ({- a positif, b negatif -}
                  do let cm () = (cl ())
                     ifM ((bigint_gt a =<< (neg_bigint b)))
                         ((sub_bigint_positif a b))
                         ((neg_bigint =<< (sub_bigint_positif b a))))
                 ({- a negatif, b positif -}
                  do let cn () = (cl ())
                     ifM ((join (bigint_gt <$> (neg_bigint a) <*> (return b))))
                         ((neg_bigint =<< (sub_bigint_positif a b)))
                         ((sub_bigint_positif b a))))
sub_bigint a b =
  (add_bigint a =<< (neg_bigint b))
mul_bigint_cp a b =
  {- Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. -}
  do len <- ((+) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> return (1))
     ((\ (bz, chiffres) ->
        do return (bz)
           let ch = 0
           ci <- ((-) <$> (readIORef (_bigint_len a)) <*> return (1))
           let cd i =
                  (if (i <= ci)
                  then do let retenue = 0
                          let cf = 0
                          cg <- ((-) <$> (readIORef (_bigint_len b)) <*> return (1))
                          let ce j ep =
                                 (if (j <= cg)
                                 then do writeIOA chiffres (i + j) =<< ((+) <$> (readIOA chiffres (i + j)) <*> (((+) ep) <$> ((*) <$> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (j)) <*> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (i)))))
                                         eq <- (quot <$> (readIOA chiffres (i + j)) <*> return (10))
                                         writeIOA chiffres (i + j) =<< (rem <$> (readIOA chiffres (i + j)) <*> return (10))
                                         (ce (j + 1) eq)
                                 else do join (writeIOA chiffres <$> (((+) i) <$> (readIORef (_bigint_len b))) <*> ((+) <$> join (readIOA chiffres <$> (((+) i) <$> (readIORef (_bigint_len b)))) <*> return (ep)))
                                         (cd (i + 1))) in
                                 (ce cf retenue)
                  else do join (writeIOA chiffres <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (quot <$> join (readIOA chiffres <$> ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> return (1))) <*> return (10)))
                          join (writeIOA chiffres <$> ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> return (1)) <*> (rem <$> join (readIOA chiffres <$> ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> return (1))) <*> return (10)))
                          let cb = 0
                          let cc = 2
                          let ca l er =
                                 (if (l <= cc)
                                 then do es <- ifM ((return ((er /= 0)) <&&> ((==) <$> (readIOA chiffres (er - 1)) <*> return (0))))
                                                   (let et = (er - 1)
                                                             in return (et))
                                                   (return (er))
                                         (ca (l + 1) es)
                                 else (Bigint <$> (join (newIORef <$> ((==) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b))))) <*> (newIORef er) <*> (newIORef chiffres))) in
                                 (ca cb len)) in
                  (cd ch)) =<< (array_init_withenv len (\ k () ->
                                                         let by = 0
                                                                  in return (((), by))) ()))
bigint_premiers_chiffres a i =
  do len <- (min2_ i =<< (readIORef (_bigint_len a)))
     let bx eu =
            ifM ((return ((eu /= 0)) <&&> ((==) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return ((eu - 1))) <*> return (0))))
                (do let ev = (eu - 1)
                    (bx ev))
                ((Bigint <$> (join (newIORef <$> (readIORef (_bigint_sign a)))) <*> (newIORef eu) <*> (join (newIORef <$> (readIORef (_bigint_chiffres a)))))) in
            (bx len)
bigint_shift a i =
  ((\ (bv, chiffres) ->
     do return (bv)
        (Bigint <$> (join (newIORef <$> (readIORef (_bigint_sign a)))) <*> (join (newIORef <$> ((+) <$> (readIORef (_bigint_len a)) <*> return (i)))) <*> (newIORef chiffres))) =<< (join (array_init_withenv <$> ((+) <$> (readIORef (_bigint_len a)) <*> return (i)) <*> (return (\ k () ->
                                                                                                                                                                                                                                                                                     do let bw () bu = return (((), bu))
                                                                                                                                                                                                                                                                                        (if (k >= i)
                                                                                                                                                                                                                                                                                        then do bu <- join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return ((k - i)))
                                                                                                                                                                                                                                                                                                return (((), bu))
                                                                                                                                                                                                                                                                                        else let bu = 0
                                                                                                                                                                                                                                                                                                      in return (((), bu))))) <*> (return ()))))
mul_bigint aa bb =
  do let bs () = {- Algorithme de Karatsuba -}
                 do split <- (quot <$> (join (min2_ <$> (readIORef (_bigint_len aa)) <*> (readIORef (_bigint_len bb)))) <*> return (2))
                    a <- (bigint_shift aa (- split))
                    b <- (bigint_premiers_chiffres aa split)
                    c <- (bigint_shift bb (- split))
                    d <- (bigint_premiers_chiffres bb split)
                    amoinsb <- (sub_bigint a b)
                    cmoinsd <- (sub_bigint c d)
                    ac <- (mul_bigint a c)
                    bd <- (mul_bigint b d)
                    amoinsbcmoinsd <- (mul_bigint amoinsb cmoinsd)
                    acdec <- (bigint_shift ac (2 * split))
                    (join (add_bigint <$> (add_bigint acdec bd) <*> (join (bigint_shift <$> (join (sub_bigint <$> (add_bigint ac bd) <*> (return amoinsbcmoinsd))) <*> (return split)))))
     ifM (((==) <$> (readIORef (_bigint_len aa)) <*> return (0)))
         (return (aa))
         (do let bt () = (bs ())
             ifM (((==) <$> (readIORef (_bigint_len bb)) <*> return (0)))
                 (return (bb))
                 (ifM ((((<) <$> (readIORef (_bigint_len aa)) <*> return (3)) <||> ((<) <$> (readIORef (_bigint_len bb)) <*> return (3))))
                      ((mul_bigint_cp aa bb))
                      ((bt ()))))
log10 a =
  do let out0 = 1
     let br ew ex =
            (if (ew >= 10)
            then do let ey = (ew `quot` 10)
                    let ez = (ex + 1)
                    (br ey ez)
            else return (ex)) in
            (br a out0)
bigint_of_int i =
  do size <- (log10 i)
     let fa = (if (i == 0)
              then let fb = 0
                            in fb
              else size)
     ((\ (bn, t) ->
        do return (bn)
           let bp = 0
           let bq = (fa - 1)
           let bo k fc =
                  (if (k <= bq)
                  then do writeIOA t k (fc `rem` 10)
                          let fd = (fc `quot` 10)
                          (bo (k + 1) fd)
                  else (Bigint <$> (newIORef True) <*> (newIORef fa) <*> (newIORef t))) in
                  (bo bp i)) =<< (array_init_withenv fa (\ j () ->
                                                          let bm = 0
                                                                   in return (((), bm))) ()))
fact_bigint a =
  do one <- (bigint_of_int 1)
     let out0 = one
     let bl fe ff =
            ifM ((fmap (not) (bigint_eq fe one)))
                (do fg <- (mul_bigint fe ff)
                    fh <- (sub_bigint fe one)
                    (bl fh fg))
                (return (ff)) in
            (bl a out0)
sum_chiffres_bigint a =
  do let out0 = 0
     let bj = 0
     bk <- ((-) <$> (readIORef (_bigint_len a)) <*> return (1))
     let bi i fi =
            (if (i <= bk)
            then do fj <- (((+) fi) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (i)))
                    (bi (i + 1) fj)
            else return (fi)) in
            (bi bj out0)
euler20 () =
  do a <- (bigint_of_int 15)
     {- normalement c'est 100 -}
     do fk <- (fact_bigint a)
        (sum_chiffres_bigint fk)
bigint_exp a b =
  do let bg () = return (())
     (if (b == 1)
     then return (a)
     else do let bh () = (bg ())
             (if ((b `rem` 2) == 0)
             then (join (bigint_exp <$> (mul_bigint a a) <*> (return (b `quot` 2))))
             else (mul_bigint a =<< (bigint_exp a (b - 1)))))
bigint_exp_10chiffres a b =
  do fl <- (bigint_premiers_chiffres a 10)
     let be () = return (())
     (if (b == 1)
     then return (fl)
     else do let bf () = (be ())
             (if ((b `rem` 2) == 0)
             then (join (bigint_exp_10chiffres <$> (mul_bigint fl fl) <*> (return (b `quot` 2))))
             else (mul_bigint fl =<< (bigint_exp_10chiffres fl (b - 1)))))
euler48 () =
  do sum <- (bigint_of_int 0)
     let ba = 1
     let bc = 100
     let z i fm =
           (if (i <= bc)
           then {- 1000 normalement -}
                do ib <- (bigint_of_int i)
                   ibeib <- (bigint_exp_10chiffres ib i)
                   fn <- (add_bigint fm ibeib)
                   fo <- (bigint_premiers_chiffres fn 10)
                   (z (i + 1) fo)
           else do printf "euler 48 = " ::IO()
                   (print_bigint fm)
                   printf "\n" ::IO()) in
           (z ba sum)
euler16 () =
  do a <- (bigint_of_int 2)
     fp <- (bigint_exp a 100)
     {- 1000 normalement -}
     (sum_chiffres_bigint fp)
euler25 () =
  do let i = 2
     a <- (bigint_of_int 1)
     b <- (bigint_of_int 1)
     let y fq fr fs =
           ifM (((<) <$> (readIORef (_bigint_len fr)) <*> return (100)))
               ({- 1000 normalement -}
                do c <- (add_bigint fq fr)
                   let ft = fr
                   let fu = c
                   let fv = (fs + 1)
                   (y ft fu fv))
               (return (fs)) in
           (y a b i)
euler29 () =
  do let maxA = 5
     let maxB = 5
     ((\ (g, a_bigint) ->
        do return (g)
           ((\ (m, a0_bigint) ->
              do return (m)
                 ((\ (p, b) ->
                    do return (p)
                       let n = 0
                       let found = True
                       let q fw fx =
                             (if fw
                             then do min0 <- (readIOA a0_bigint 0)
                                     let fy = False
                                     let w = 2
                                     let x = maxA
                                     let v i fz ga =
                                           (if (i <= x)
                                           then ((\ (gb, gc) ->
                                                   (v (i + 1) gb gc)) =<< ifM (((<=) <$> (readIOA b i) <*> return (maxB)))
                                                                              (((\ (gd, ge) ->
                                                                                  return ((gd, ge))) =<< (if fz
                                                                                                         then do gf <- ifM ((join (bigint_lt <$> (readIOA a_bigint i) <*> (return ga))))
                                                                                                                           (do gg <- (readIOA a_bigint i)
                                                                                                                               return (gg))
                                                                                                                           (return (ga))
                                                                                                                 return ((fz, gf))
                                                                                                         else do gh <- (readIOA a_bigint i)
                                                                                                                 let gi = True
                                                                                                                 return ((gi, gh)))))
                                                                              (return ((fz, ga))))
                                           else do gj <- (if fz
                                                         then do let gk = (fx + 1)
                                                                 let s = 2
                                                                 let u = maxA
                                                                 let r l =
                                                                       (if (l <= u)
                                                                       then do ifM (((join (bigint_eq <$> (readIOA a_bigint l) <*> (return ga))) <&&> ((<=) <$> (readIOA b l) <*> return (maxB))))
                                                                                   (do writeIOA b l =<< ((+) <$> (readIOA b l) <*> return (1))
                                                                                       writeIOA a_bigint l =<< (join (mul_bigint <$> (readIOA a_bigint l) <*> (readIOA a0_bigint l))))
                                                                                   (return (()))
                                                                               (r (l + 1))
                                                                       else return (gk)) in
                                                                       (r s)
                                                         else return (fx))
                                                   (q fz gj)) in
                                           (v w fy min0)
                             else return (fx)) in
                             (q found n)) =<< (array_init_withenv (maxA + 1) (\ k () ->
                                                                               let o = 2
                                                                                       in return (((), o))) ()))) =<< (array_init_withenv (maxA + 1) (\ j2 () ->
                                                                                                                                                       do h <- (bigint_of_int j2)
                                                                                                                                                          return (((), h))) ()))) =<< (array_init_withenv (maxA + 1) (\ j () ->
                                                                                                                                                                                                                       do f <- (bigint_of_int (j * j))
                                                                                                                                                                                                                          return (((), f))) ()))
main =
  do printf "%d" =<< ((euler29 ()) :: IO Int)
     printf "\n" ::IO()
     sum <- (read_bigint 50)
     let dt = 2
     let du = 100
     let ds i gl =
            (if (i <= du)
            then do skip_whitespaces
                    tmp <- (read_bigint 50)
                    gm <- (add_bigint gl tmp)
                    (ds (i + 1) gm)
            else do printf "euler13 = " ::IO()
                    (print_bigint gl)
                    printf "\n" ::IO()
                    printf "euler25 = " ::IO()
                    printf "%d" =<< ((euler25 ()) :: IO Int)
                    printf "\n" ::IO()
                    printf "euler16 = " ::IO()
                    printf "%d" =<< ((euler16 ()) :: IO Int)
                    printf "\n" ::IO()
                    (euler48 ())
                    printf "euler20 = " ::IO()
                    printf "%d" =<< ((euler20 ()) :: IO Int)
                    printf "\n" ::IO()
                    a <- (bigint_of_int 999999)
                    b <- (bigint_of_int 9951263)
                    (print_bigint a)
                    printf ">>1=" ::IO()
                    (print_bigint =<< (bigint_shift a (- 1)))
                    printf "\n" ::IO()
                    (print_bigint a)
                    printf "*" ::IO()
                    (print_bigint b)
                    printf "=" ::IO()
                    (print_bigint =<< (mul_bigint a b))
                    printf "\n" ::IO()
                    (print_bigint a)
                    printf "*" ::IO()
                    (print_bigint b)
                    printf "=" ::IO()
                    (print_bigint =<< (mul_bigint_cp a b))
                    printf "\n" ::IO()
                    (print_bigint a)
                    printf "+" ::IO()
                    (print_bigint b)
                    printf "=" ::IO()
                    (print_bigint =<< (add_bigint a b))
                    printf "\n" ::IO()
                    (print_bigint b)
                    printf "-" ::IO()
                    (print_bigint a)
                    printf "=" ::IO()
                    (print_bigint =<< (sub_bigint b a))
                    printf "\n" ::IO()
                    (print_bigint a)
                    printf "-" ::IO()
                    (print_bigint b)
                    printf "=" ::IO()
                    (print_bigint =<< (sub_bigint a b))
                    printf "\n" ::IO()
                    (print_bigint a)
                    printf ">" ::IO()
                    (print_bigint b)
                    printf "=" ::IO()
                    e <- (bigint_gt a b)
                    (if e
                    then printf "True" ::IO()
                    else printf "False" ::IO())
                    printf "\n" ::IO()) in
            (ds dt sum)

