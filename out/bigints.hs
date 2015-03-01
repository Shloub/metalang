import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

(<&&>) a b =
	do c <- a
	   if c then b
		 else return False
(<||>) a b =
	do c <- a
	   if c then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e
skip_whitespaces :: IO ()
skip_whitespaces =
  ifM isEOF
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do getChar
              skip_whitespaces
           else return ())
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init_withenv :: Int -> ( Int -> env -> IO(env, tabcontent)) -> env -> IO(env, IOArray Int tabcontent)
array_init_withenv len f env =
  do (env, li) <- g 0 env
     (,) env <$> newListArray (0, len - 1) li
  where g i env =
           if i == len
           then return (env, [])
           else do (env', item) <- f i env
                   (env'', li) <- g (i+1) env'
                   return (env'', item:li)
array_init len f = fmap snd (array_init_withenv len (\x () -> fmap ((,) ()) (f x)) ())

main :: IO ()

max2_ a b =
  return (if a > b
          then a
          else b)

min2_ a b =
  return (if a < b
          then a
          else b)

data Bigint = Bigint {
                        _bigint_sign :: IORef Bool,
                        _bigint_len :: IORef Int,
                        _bigint_chiffres :: IORef (IOArray Int Int)
                        }
  deriving Eq


read_bigint len =
  do chiffres <- array_init len (\ j ->
                                   do c <- getChar
                                      return (ord c))
     let cf = (len - 1) `quot` 2
     let ce i =
            if i <= cf
            then do tmp <- readIOA chiffres i
                    writeIOA chiffres i =<< (readIOA chiffres (len - 1 - i))
                    writeIOA chiffres (len - 1 - i) tmp
                    ce (i + 1)
            else (Bigint <$> (newIORef True) <*> (newIORef len) <*> (newIORef chiffres)) in
            ce 0

print_bigint a =
  do ifM (fmap not (readIORef (_bigint_sign a)))
         (printf "%c" ('-' :: Char) :: IO ())
         (return ())
     cb <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let ca i =
            if i <= cb
            then do printf "%d" =<< (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> (return 1)) <*> (return i)) :: IO Int)
                    ca (i + 1)
            else return () in
            ca 0

bigint_eq a b =
  {- Renvoie vrai si a = b -}
  ifM ((/=) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b)))
      (return False)
      (ifM ((/=) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b)))
           (return False)
           (do bz <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
               let by i =
                      if i <= bz
                      then ifM ((/=) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                               (return False)
                               (by (i + 1))
                      else return True in
                      by 0))

bigint_gt a b =
  {- Renvoie vrai si a > b -}
  ifM ((readIORef (_bigint_sign a)) <&&> (fmap not (readIORef (_bigint_sign b))))
      (return True)
      (ifM ((fmap not (readIORef (_bigint_sign a))) <&&> (readIORef (_bigint_sign b)))
           (return False)
           (ifM ((>) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b)))
                (readIORef (_bigint_sign a))
                (ifM ((<) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b)))
                     (fmap not (readIORef (_bigint_sign a)))
                     (do bx <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
                         let bw i =
                                if i <= bx
                                then do j <- ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> (return 1)) <*> (return i))
                                        ifM ((>) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j))
                                            (readIORef (_bigint_sign a))
                                            (ifM ((<) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j))
                                                 (fmap not (readIORef (_bigint_sign a)))
                                                 (bw (i + 1)))
                                else return True in
                                bw 0))))

bigint_lt a b =
  fmap not (bigint_gt a b)

add_bigint_positif a b =
  {- Une addition ou on en a rien a faire des signes -}
  do len <- (((+) 1) <$> (join $ max2_ <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))))
     (array_init_withenv len (\ i ck ->
                                do cl <- ifM (((<) i) <$> (readIORef (_bigint_len a)))
                                             (do cm <- (((+) ck) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                                                 return cm)
                                             (return ck)
                                   cn <- ifM (((<) i) <$> (readIORef (_bigint_len b)))
                                             (do co <- (((+) cl) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                                                 return co)
                                             (return cl)
                                   let cp = cn `quot` 10
                                   let bt = cn `rem` 10
                                   return (cp, bt)) 0) >>= (\ (ch, chiffres) ->
                                                             let bv ci =
                                                                    ifM ((return (ci > 0)) <&&> (((==) 0) <$> (readIOA chiffres (ci - 1))))
                                                                        (do let cj = ci - 1
                                                                            bv cj)
                                                                        (Bigint <$> (newIORef True) <*> (newIORef ci) <*> (newIORef chiffres)) in
                                                                    bv len)

sub_bigint_positif a b =
  {- Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
-}
  do len <- readIORef (_bigint_len a)
     (array_init_withenv len (\ i ct ->
                                do tmp <- (((+) ct) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                                   cu <- ifM (((<) i) <$> (readIORef (_bigint_len b)))
                                             (do cv <- (((-) tmp) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                                                 return cv)
                                             (return tmp)
                                   (\ (cw, cx) ->
                                     return (cw, cx)) (if cu < 0
                                                       then let cy = cu + 10
                                                                     in let cz = - 1
                                                                                 in (cz, cy)
                                                       else (0, cu))) 0) >>= (\ (cq, chiffres) ->
                                                                               let bs cr =
                                                                                      ifM ((return (cr > 0)) <&&> (((==) 0) <$> (readIOA chiffres (cr - 1))))
                                                                                          (do let cs = cr - 1
                                                                                              bs cs)
                                                                                          (Bigint <$> (newIORef True) <*> (newIORef cr) <*> (newIORef chiffres)) in
                                                                                      bs len)

neg_bigint a =
  (Bigint <$> ((fmap not (readIORef (_bigint_sign a))) >>= newIORef) <*> ((readIORef (_bigint_len a)) >>= newIORef) <*> ((readIORef (_bigint_chiffres a)) >>= newIORef))

add_bigint a b =
  ifM ((==) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b)))
      (ifM (readIORef (_bigint_sign a))
           (add_bigint_positif a b)
           ((add_bigint_positif a b) >>= neg_bigint))
      (ifM (readIORef (_bigint_sign a))
           {- a positif, b negatif -}
           (ifM (bigint_gt a =<< (neg_bigint b))
                (sub_bigint_positif a b)
                ((sub_bigint_positif b a) >>= neg_bigint))
           {- a negatif, b positif -}
           (ifM (join $ bigint_gt <$> (neg_bigint a) <*> return b)
                ((sub_bigint_positif a b) >>= neg_bigint)
                (sub_bigint_positif b a)))

sub_bigint a b =
  add_bigint a =<< (neg_bigint b)

mul_bigint_cp a b =
  {- Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. -}
  do len <- (((+) 1) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))))
     chiffres <- array_init len (\ k ->
                                   return 0)
     bp <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let bm i =
            if i <= bp
            then do bo <- ((-) <$> (readIORef (_bigint_len b)) <*> (return 1))
                    let bn j db =
                           if j <= bo
                           then do writeIOA chiffres (i + j) =<< ((+) <$> (readIOA chiffres (i + j)) <*> (((+) db) <$> ((*) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))))
                                   dc <- (quot <$> (readIOA chiffres (i + j)) <*> (return 10))
                                   writeIOA chiffres (i + j) =<< (rem <$> (readIOA chiffres (i + j)) <*> (return 10))
                                   bn (j + 1) dc
                           else do join $ writeIOA chiffres <$> (((+) i) <$> (readIORef (_bigint_len b))) <*> (((+) db) <$> (readIOA chiffres =<< (((+) i) <$> (readIORef (_bigint_len b)))))
                                   bm (i + 1) in
                           bn 0 0
            else do join $ writeIOA chiffres <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (quot <$> (readIOA chiffres =<< ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1))) <*> (return 10))
                    join $ writeIOA chiffres <$> ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1)) <*> (rem <$> (readIOA chiffres =<< ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1))) <*> (return 10))
                    let bl l dd =
                           if l <= 2
                           then ifM ((return (dd /= 0)) <&&> (((==) 0) <$> (readIOA chiffres (dd - 1))))
                                    (do let de = dd - 1
                                        bl (l + 1) de)
                                    (bl (l + 1) dd)
                           else (Bigint <$> (((==) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b))) >>= newIORef) <*> (newIORef dd) <*> (newIORef chiffres)) in
                           bl 0 len in
            bm 0

bigint_premiers_chiffres a i =
  do len <- min2_ i =<< (readIORef (_bigint_len a))
     let bi df =
            ifM ((return (df /= 0)) <&&> (((==) 0) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (df - 1))))
                (do let dg = df - 1
                    bi dg)
                (Bigint <$> ((readIORef (_bigint_sign a)) >>= newIORef) <*> (newIORef df) <*> ((readIORef (_bigint_chiffres a)) >>= newIORef)) in
            bi len

bigint_shift a i =
  do chiffres <- join $ array_init <$> (((+) i) <$> (readIORef (_bigint_len a))) <*> return (\ k ->
                                                                                               if k >= i
                                                                                               then join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (k - i)
                                                                                               else return 0)
     (Bigint <$> ((readIORef (_bigint_sign a)) >>= newIORef) <*> ((((+) i) <$> (readIORef (_bigint_len a))) >>= newIORef) <*> (newIORef chiffres))

mul_bigint aa bb =
  ifM (((==) 0) <$> (readIORef (_bigint_len aa)))
      (return aa)
      (ifM (((==) 0) <$> (readIORef (_bigint_len bb)))
           (return bb)
           (ifM ((((>) 3) <$> (readIORef (_bigint_len aa))) <||> (((>) 3) <$> (readIORef (_bigint_len bb))))
                (mul_bigint_cp aa bb)
                {- Algorithme de Karatsuba -}
                (do split <- (quot <$> (join $ min2_ <$> (readIORef (_bigint_len aa)) <*> (readIORef (_bigint_len bb))) <*> (return 2))
                    a <- bigint_shift aa (- split)
                    b <- bigint_premiers_chiffres aa split
                    c <- bigint_shift bb (- split)
                    d <- bigint_premiers_chiffres bb split
                    amoinsb <- sub_bigint a b
                    cmoinsd <- sub_bigint c d
                    ac <- mul_bigint a c
                    bd <- mul_bigint b d
                    amoinsbcmoinsd <- mul_bigint amoinsb cmoinsd
                    acdec <- bigint_shift ac (2 * split)
                    join $ add_bigint <$> (add_bigint acdec bd) <*> (join $ bigint_shift <$> (join $ sub_bigint <$> (add_bigint ac bd) <*> return amoinsbcmoinsd) <*> return split))))

log10 a =
  let bf dh di =
         if dh >= 10
         then do let dj = dh `quot` 10
                 let dk = di + 1
                 bf dj dk
         else return di in
         bf a 1

bigint_of_int i =
  do size <- log10 i
     let dl = if i == 0
              then 0
              else size
     t <- array_init dl (\ j ->
                           return 0)
     let be = dl - 1
     let bc k dn =
            if k <= be
            then do writeIOA t k (dn `rem` 10)
                    let dp = dn `quot` 10
                    bc (k + 1) dp
            else (Bigint <$> (newIORef True) <*> (newIORef dl) <*> (newIORef t)) in
            bc 0 i

fact_bigint a =
  do one <- bigint_of_int 1
     let y dq dr =
           ifM (fmap not (bigint_eq dq one))
               (do ds <- mul_bigint dq dr
                   dt <- sub_bigint dq one
                   y dt ds)
               (return dr) in
           y a one

sum_chiffres_bigint a =
  do x <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let w i du =
           if i <= x
           then do dv <- (((+) du) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                   w (i + 1) dv
           else return du in
           w 0 0

euler20 () =
  do a <- bigint_of_int 15
     {- normalement c'est 100 -}
     do dw <- fact_bigint a
        sum_chiffres_bigint dw

bigint_exp a b =
  if b == 1
  then return a
  else if (b `rem` 2) == 0
       then join $ bigint_exp <$> (mul_bigint a a) <*> return (b `quot` 2)
       else mul_bigint a =<< (bigint_exp a (b - 1))

bigint_exp_10chiffres a b =
  do dx <- bigint_premiers_chiffres a 10
     if b == 1
     then return dx
     else if (b `rem` 2) == 0
          then join $ bigint_exp_10chiffres <$> (mul_bigint dx dx) <*> return (b `quot` 2)
          else mul_bigint dx =<< (bigint_exp_10chiffres dx (b - 1))

euler48 () =
  do sum <- bigint_of_int 0
     let v i dy =
           if i <= 100
           then {- 1000 normalement -}
                do ib <- bigint_of_int i
                   ibeib <- bigint_exp_10chiffres ib i
                   dz <- add_bigint dy ibeib
                   ea <- bigint_premiers_chiffres dz 10
                   v (i + 1) ea
           else do printf "euler 48 = " :: IO ()
                   print_bigint dy
                   printf "\n" :: IO () in
           v 1 sum

euler16 () =
  do a <- bigint_of_int 2
     eb <- bigint_exp a 100
     {- 1000 normalement -}
     sum_chiffres_bigint eb

euler25 () =
  do a <- bigint_of_int 1
     b <- bigint_of_int 1
     let u ec ed ee =
           ifM (((>) 100) <$> (readIORef (_bigint_len ed)))
               {- 1000 normalement -}
               (do c <- add_bigint ec ed
                   let eh = ee + 1
                   u ed c eh)
               (return ee) in
           u a b 2

euler29 () =
  do a_bigint <- array_init (5 + 1) (\ j ->
                                       bigint_of_int (j * j))
     a0_bigint <- array_init (5 + 1) (\ j2 ->
                                        bigint_of_int j2)
     b <- array_init (5 + 1) (\ k ->
                                return 2)
     let q ei ej =
           if ei
           then do min0 <- readIOA a0_bigint 0
                   let s i el em =
                         if i <= 5
                         then ifM (((>=) 5) <$> (readIOA b i))
                                  (if el
                                   then ifM (join $ bigint_lt <$> (readIOA a_bigint i) <*> return em)
                                            (do en <- readIOA a_bigint i
                                                s (i + 1) el en)
                                            (s (i + 1) el em)
                                   else do eo <- readIOA a_bigint i
                                           s (i + 1) True eo)
                                  (s (i + 1) el em)
                         else if el
                              then do let eq = ej + 1
                                      let r l =
                                            if l <= 5
                                            then ifM ((join $ bigint_eq <$> (readIOA a_bigint l) <*> return em) <&&> (((>=) 5) <$> (readIOA b l)))
                                                     (do writeIOA b l =<< (((+) 1) <$> (readIOA b l))
                                                         writeIOA a_bigint l =<< (join $ mul_bigint <$> (readIOA a_bigint l) <*> (readIOA a0_bigint l))
                                                         r (l + 1))
                                                     (r (l + 1))
                                            else q el eq in
                                            r 2
                              else q el ej in
                         s 2 False min0
           else return ej in
           q True 0

main =
  do printf "%d\n" =<< ((euler29 ())::IO Int)
     sum <- read_bigint 50
     let cg i er =
            if i <= 100
            then do skip_whitespaces
                    tmp <- read_bigint 50
                    es <- add_bigint er tmp
                    cg (i + 1) es
            else do printf "euler13 = " :: IO ()
                    print_bigint er
                    join $ printf "\neuler25 = %d\neuler16 = %d\n" <$> ((euler25 ())::IO Int) <*> ((euler16 ())::IO Int)
                    euler48 ()
                    printf "euler20 = %d\n" =<< ((euler20 ())::IO Int)
                    a <- bigint_of_int 999999
                    b <- bigint_of_int 9951263
                    print_bigint a
                    printf ">>1=" :: IO ()
                    (bigint_shift a (- 1)) >>= print_bigint
                    printf "\n" :: IO ()
                    print_bigint a
                    printf "*" :: IO ()
                    print_bigint b
                    printf "=" :: IO ()
                    (mul_bigint a b) >>= print_bigint
                    printf "\n" :: IO ()
                    print_bigint a
                    printf "*" :: IO ()
                    print_bigint b
                    printf "=" :: IO ()
                    (mul_bigint_cp a b) >>= print_bigint
                    printf "\n" :: IO ()
                    print_bigint a
                    printf "+" :: IO ()
                    print_bigint b
                    printf "=" :: IO ()
                    (add_bigint a b) >>= print_bigint
                    printf "\n" :: IO ()
                    print_bigint b
                    printf "-" :: IO ()
                    print_bigint a
                    printf "=" :: IO ()
                    (sub_bigint b a) >>= print_bigint
                    printf "\n" :: IO ()
                    print_bigint a
                    printf "-" :: IO ()
                    print_bigint b
                    printf "=" :: IO ()
                    (sub_bigint a b) >>= print_bigint
                    printf "\n" :: IO ()
                    print_bigint a
                    printf ">" :: IO ()
                    print_bigint b
                    printf "=" :: IO ()
                    e <- bigint_gt a b
                    if e
                    then printf "True" :: IO ()
                    else printf "False" :: IO ()
                    printf "\n" :: IO () in
            cg 2 sum


