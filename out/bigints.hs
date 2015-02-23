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
  return ((if (a > b)
          then a
          else b))
min2_ a b =
  return ((if (a < b)
          then a
          else b))
data Bigint = Bigint {
                        _bigint_sign :: IORef Bool,
                        _bigint_len :: IORef Int,
                        _bigint_chiffres :: IORef (IOArray Int Int)
                        }
  deriving Eq

read_bigint len =
  ((\ (cd, chiffres) ->
     do let cf = ((len - 1) `quot` 2)
        let ce i =
               (if (i <= cf)
               then do tmp <- (readIOA chiffres i)
                       writeIOA chiffres i =<< (readIOA chiffres ((len - 1) - i))
                       writeIOA chiffres ((len - 1) - i) tmp
                       (ce (i + 1))
               else (Bigint <$> (newIORef True) <*> (newIORef len) <*> (newIORef chiffres))) in
               (ce 0)) =<< (array_init_withenv len (\ j cd ->
                                                     hGetChar stdin >>= ((\ c ->
                                                                           do cc <- ((fmap ord (return (c))))
                                                                              return (((), cc))))) ()))
print_bigint a =
  do ifM ((fmap (not) (readIORef (_bigint_sign a))))
         (printf "%c" ('-' :: Char)::IO())
         (return (()))
     cb <- ((-) <$> (readIORef (_bigint_len a)) <*> return (1))
     let ca i =
            (if (i <= cb)
            then do printf "%d" =<< (join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> return (1)) <*> return (i))) :: IO Int)
                    (ca (i + 1))
            else return (())) in
            (ca 0)
bigint_eq a b =
  {- Renvoie vrai si a = b -}
  ifM (((/=) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b))))
      (return (False))
      (ifM (((/=) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))))
           (return (False))
           (do bz <- ((-) <$> (readIORef (_bigint_len a)) <*> return (1))
               let by i =
                      (if (i <= bz)
                      then ifM (((/=) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (i)) <*> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (i))))
                               (return (False))
                               ((by (i + 1)))
                      else return (True)) in
                      (by 0)))
bigint_gt a b =
  {- Renvoie vrai si a > b -}
  ifM (((readIORef (_bigint_sign a)) <&&> (fmap (not) (readIORef (_bigint_sign b)))))
      (return (True))
      (ifM (((fmap (not) (readIORef (_bigint_sign a))) <&&> (readIORef (_bigint_sign b))))
           (return (False))
           (ifM (((>) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))))
                ((readIORef (_bigint_sign a)))
                (ifM (((<) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))))
                     ((fmap (not) (readIORef (_bigint_sign a))))
                     (do bx <- ((-) <$> (readIORef (_bigint_len a)) <*> return (1))
                         let bw i =
                                (if (i <= bx)
                                then do j <- ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> return (1)) <*> return (i))
                                        ifM (((>) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (j)) <*> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (j))))
                                            ((readIORef (_bigint_sign a)))
                                            (ifM (((<) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (j)) <*> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (j))))
                                                 ((fmap (not) (readIORef (_bigint_sign a))))
                                                 ((bw (i + 1))))
                                else return (True)) in
                                (bw 0)))))
bigint_lt a b =
  (fmap (not) (bigint_gt a b))
add_bigint_positif a b =
  {- Une addition ou on en a rien a faire des signes -}
  do len <- ((+) <$> (join (max2_ <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b)))) <*> return (1))
     let retenue = 0
     ((\ (ch, chiffres) ->
        let bv ci =
               ifM ((return ((ci > 0)) <&&> ((==) <$> (readIOA chiffres (ci - 1)) <*> return (0))))
                   (do let cj = (ci - 1)
                       (bv cj))
                   ((Bigint <$> (newIORef True) <*> (newIORef ci) <*> (newIORef chiffres))) in
               (bv len)) =<< (array_init_withenv len (\ i ck ->
                                                       do let tmp = ck
                                                          cl <- ifM ((((<) i) <$> (readIORef (_bigint_len a))))
                                                                    (do cm <- (((+) tmp) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (i)))
                                                                        return (cm))
                                                                    (return (tmp))
                                                          cn <- ifM ((((<) i) <$> (readIORef (_bigint_len b))))
                                                                    (do co <- (((+) cl) <$> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (i)))
                                                                        return (co))
                                                                    (return (cl))
                                                          let cp = (cn `quot` 10)
                                                          let bt = (cn `rem` 10)
                                                          return ((cp, bt))) retenue))
sub_bigint_positif a b =
  {- Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
-}
  do len <- (readIORef (_bigint_len a))
     let retenue = 0
     ((\ (cq, chiffres) ->
        let bs cr =
               ifM ((return ((cr > 0)) <&&> ((==) <$> (readIOA chiffres (cr - 1)) <*> return (0))))
                   (do let cs = (cr - 1)
                       (bs cs))
                   ((Bigint <$> (newIORef True) <*> (newIORef cr) <*> (newIORef chiffres))) in
               (bs len)) =<< (array_init_withenv len (\ i ct ->
                                                       do tmp <- (((+) ct) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (i)))
                                                          cu <- ifM ((((<) i) <$> (readIORef (_bigint_len b))))
                                                                    (do cv <- (((-) tmp) <$> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (i)))
                                                                        return (cv))
                                                                    (return (tmp))
                                                          ((\ (cw, cx) ->
                                                             let bq = cx
                                                                      in return ((cw, bq))) (if (cu < 0)
                                                                                            then let cy = (cu + 10)
                                                                                                          in let cz = (- 1)
                                                                                                                      in (cz, cy)
                                                                                            else let da = 0
                                                                                                          in (da, cu)))) retenue))
neg_bigint a =
  (Bigint <$> (join (newIORef <$> (fmap (not) (readIORef (_bigint_sign a))))) <*> (join (newIORef <$> (readIORef (_bigint_len a)))) <*> (join (newIORef <$> (readIORef (_bigint_chiffres a)))))
add_bigint a b =
  ifM (((==) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b))))
      (ifM ((readIORef (_bigint_sign a)))
           ((add_bigint_positif a b))
           ((neg_bigint =<< (add_bigint_positif a b))))
      (ifM ((readIORef (_bigint_sign a)))
           ({- a positif, b negatif -}
            ifM ((bigint_gt a =<< (neg_bigint b)))
                ((sub_bigint_positif a b))
                ((neg_bigint =<< (sub_bigint_positif b a))))
           ({- a negatif, b positif -}
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
     ((\ (bk, chiffres) ->
        do bp <- ((-) <$> (readIORef (_bigint_len a)) <*> return (1))
           let bm i =
                  (if (i <= bp)
                  then do let retenue = 0
                          bo <- ((-) <$> (readIORef (_bigint_len b)) <*> return (1))
                          let bn j db =
                                 (if (j <= bo)
                                 then do writeIOA chiffres (i + j) =<< ((+) <$> (readIOA chiffres (i + j)) <*> (((+) db) <$> ((*) <$> join (readIOA <$> (readIORef (_bigint_chiffres b)) <*> return (j)) <*> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (i)))))
                                         dc <- (quot <$> (readIOA chiffres (i + j)) <*> return (10))
                                         writeIOA chiffres (i + j) =<< (rem <$> (readIOA chiffres (i + j)) <*> return (10))
                                         (bn (j + 1) dc)
                                 else do join (writeIOA chiffres <$> (((+) i) <$> (readIORef (_bigint_len b))) <*> ((+) <$> join (readIOA chiffres <$> (((+) i) <$> (readIORef (_bigint_len b)))) <*> return (db)))
                                         (bm (i + 1))) in
                                 (bn 0 retenue)
                  else do join (writeIOA chiffres <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (quot <$> join (readIOA chiffres <$> ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> return (1))) <*> return (10)))
                          join (writeIOA chiffres <$> ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> return (1)) <*> (rem <$> join (readIOA chiffres <$> ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> return (1))) <*> return (10)))
                          let bl l dd =
                                 (if (l <= 2)
                                 then ifM ((return ((dd /= 0)) <&&> ((==) <$> (readIOA chiffres (dd - 1)) <*> return (0))))
                                          (do let de = (dd - 1)
                                              (bl (l + 1) de))
                                          ((bl (l + 1) dd))
                                 else (Bigint <$> (join (newIORef <$> ((==) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b))))) <*> (newIORef dd) <*> (newIORef chiffres))) in
                                 (bl 0 len)) in
                  (bm 0)) =<< (array_init_withenv len (\ k bk ->
                                                        let bj = 0
                                                                 in return (((), bj))) ()))
bigint_premiers_chiffres a i =
  do len <- (min2_ i =<< (readIORef (_bigint_len a)))
     let bi df =
            ifM ((return ((df /= 0)) <&&> ((==) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return ((df - 1))) <*> return (0))))
                (do let dg = (df - 1)
                    (bi dg))
                ((Bigint <$> (join (newIORef <$> (readIORef (_bigint_sign a)))) <*> (newIORef df) <*> (join (newIORef <$> (readIORef (_bigint_chiffres a)))))) in
            (bi len)
bigint_shift a i =
  ((\ (bh, chiffres) ->
     (Bigint <$> (join (newIORef <$> (readIORef (_bigint_sign a)))) <*> (join (newIORef <$> ((+) <$> (readIORef (_bigint_len a)) <*> return (i)))) <*> (newIORef chiffres))) =<< (join (array_init_withenv <$> ((+) <$> (readIORef (_bigint_len a)) <*> return (i)) <*> (return (\ k bh ->
                                                                                                                                                                                                                                                                                  (if (k >= i)
                                                                                                                                                                                                                                                                                  then do bg <- join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return ((k - i)))
                                                                                                                                                                                                                                                                                          return (((), bg))
                                                                                                                                                                                                                                                                                  else let bg = 0
                                                                                                                                                                                                                                                                                                in return (((), bg))))) <*> (return ()))))
mul_bigint aa bb =
  ifM (((==) <$> (readIORef (_bigint_len aa)) <*> return (0)))
      (return (aa))
      (ifM (((==) <$> (readIORef (_bigint_len bb)) <*> return (0)))
           (return (bb))
           (ifM ((((<) <$> (readIORef (_bigint_len aa)) <*> return (3)) <||> ((<) <$> (readIORef (_bigint_len bb)) <*> return (3))))
                ((mul_bigint_cp aa bb))
                ({- Algorithme de Karatsuba -}
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
                    (join (add_bigint <$> (add_bigint acdec bd) <*> (join (bigint_shift <$> (join (sub_bigint <$> (add_bigint ac bd) <*> (return amoinsbcmoinsd))) <*> (return split))))))))
log10 a =
  do let out0 = 1
     let bf dh di =
            (if (dh >= 10)
            then do let dj = (dh `quot` 10)
                    let dk = (di + 1)
                    (bf dj dk)
            else return (di)) in
            (bf a out0)
bigint_of_int i =
  do size <- (log10 i)
     let dl = (if (i == 0)
              then let dm = 0
                            in dm
              else size)
     ((\ (ba, t) ->
        do let be = (dl - 1)
           let bc k dn =
                  (if (k <= be)
                  then do writeIOA t k (dn `rem` 10)
                          let dp = (dn `quot` 10)
                          (bc (k + 1) dp)
                  else (Bigint <$> (newIORef True) <*> (newIORef dl) <*> (newIORef t))) in
                  (bc 0 i)) =<< (array_init_withenv dl (\ j ba ->
                                                         let z = 0
                                                                 in return (((), z))) ()))
fact_bigint a =
  do one <- (bigint_of_int 1)
     let out0 = one
     let y dq dr =
           ifM ((fmap (not) (bigint_eq dq one)))
               (do ds <- (mul_bigint dq dr)
                   dt <- (sub_bigint dq one)
                   (y dt ds))
               (return (dr)) in
           (y a out0)
sum_chiffres_bigint a =
  do let out0 = 0
     x <- ((-) <$> (readIORef (_bigint_len a)) <*> return (1))
     let w i du =
           (if (i <= x)
           then do dv <- (((+) du) <$> join (readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (i)))
                   (w (i + 1) dv)
           else return (du)) in
           (w 0 out0)
euler20 () =
  do a <- (bigint_of_int 15)
     {- normalement c'est 100 -}
     do dw <- (fact_bigint a)
        (sum_chiffres_bigint dw)
bigint_exp a b =
  (if (b == 1)
  then return (a)
  else (if ((b `rem` 2) == 0)
       then (join (bigint_exp <$> (mul_bigint a a) <*> (return (b `quot` 2))))
       else (mul_bigint a =<< (bigint_exp a (b - 1)))))
bigint_exp_10chiffres a b =
  do dx <- (bigint_premiers_chiffres a 10)
     (if (b == 1)
     then return (dx)
     else (if ((b `rem` 2) == 0)
          then (join (bigint_exp_10chiffres <$> (mul_bigint dx dx) <*> (return (b `quot` 2))))
          else (mul_bigint dx =<< (bigint_exp_10chiffres dx (b - 1)))))
euler48 () =
  do sum <- (bigint_of_int 0)
     let v i dy =
           (if (i <= 100)
           then {- 1000 normalement -}
                do ib <- (bigint_of_int i)
                   ibeib <- (bigint_exp_10chiffres ib i)
                   dz <- (add_bigint dy ibeib)
                   ea <- (bigint_premiers_chiffres dz 10)
                   (v (i + 1) ea)
           else do printf "euler 48 = " ::IO()
                   (print_bigint dy)
                   printf "\n" ::IO()) in
           (v 1 sum)
euler16 () =
  do a <- (bigint_of_int 2)
     eb <- (bigint_exp a 100)
     {- 1000 normalement -}
     (sum_chiffres_bigint eb)
euler25 () =
  do let i = 2
     a <- (bigint_of_int 1)
     b <- (bigint_of_int 1)
     let u ec ed ee =
           ifM (((<) <$> (readIORef (_bigint_len ed)) <*> return (100)))
               ({- 1000 normalement -}
                do c <- (add_bigint ec ed)
                   let ef = ed
                   let eg = c
                   let eh = (ee + 1)
                   (u ef eg eh))
               (return (ee)) in
           (u a b i)
euler29 () =
  do let maxA = 5
     let maxB = 5
     ((\ (g, a_bigint) ->
        ((\ (m, a0_bigint) ->
           ((\ (p, b) ->
              do let n = 0
                 let found = True
                 let q ei ej =
                       (if ei
                       then do min0 <- (readIOA a0_bigint 0)
                               let ek = False
                               let s i el em =
                                     (if (i <= maxA)
                                     then ifM (((<=) <$> (readIOA b i) <*> return (maxB)))
                                              ((if el
                                               then ifM ((join (bigint_lt <$> (readIOA a_bigint i) <*> (return em))))
                                                        (do en <- (readIOA a_bigint i)
                                                            (s (i + 1) el en))
                                                        ((s (i + 1) el em))
                                               else do eo <- (readIOA a_bigint i)
                                                       let ep = True
                                                       (s (i + 1) ep eo)))
                                              ((s (i + 1) el em))
                                     else (if el
                                          then do let eq = (ej + 1)
                                                  let r l =
                                                        (if (l <= maxA)
                                                        then ifM (((join (bigint_eq <$> (readIOA a_bigint l) <*> (return em))) <&&> ((<=) <$> (readIOA b l) <*> return (maxB))))
                                                                 (do writeIOA b l =<< ((+) <$> (readIOA b l) <*> return (1))
                                                                     writeIOA a_bigint l =<< (join (mul_bigint <$> (readIOA a_bigint l) <*> (readIOA a0_bigint l)))
                                                                     (r (l + 1)))
                                                                 ((r (l + 1)))
                                                        else (q el eq)) in
                                                        (r 2)
                                          else (q el ej))) in
                                     (s 2 ek min0)
                       else return (ej)) in
                       (q found n)) =<< (array_init_withenv (maxA + 1) (\ k p ->
                                                                         let o = 2
                                                                                 in return (((), o))) ()))) =<< (array_init_withenv (maxA + 1) (\ j2 m ->
                                                                                                                                                 do h <- (bigint_of_int j2)
                                                                                                                                                    return (((), h))) ()))) =<< (array_init_withenv (maxA + 1) (\ j g ->
                                                                                                                                                                                                                 do f <- (bigint_of_int (j * j))
                                                                                                                                                                                                                    return (((), f))) ()))
main =
  do printf "%d" =<< ((euler29 ()) :: IO Int)
     printf "\n" ::IO()
     sum <- (read_bigint 50)
     let cg i er =
            (if (i <= 100)
            then do skip_whitespaces
                    tmp <- (read_bigint 50)
                    es <- (add_bigint er tmp)
                    (cg (i + 1) es)
            else do printf "euler13 = " ::IO()
                    (print_bigint er)
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
            (cg 2 sum)

