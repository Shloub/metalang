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
     let ce = (len - 1) `quot` 2
     let cd i =
            if i <= ce
            then do tmp <- readIOA chiffres i
                    writeIOA chiffres i =<< (readIOA chiffres (len - 1 - i))
                    writeIOA chiffres (len - 1 - i) tmp
                    cd (i + 1)
            else (Bigint <$> (newIORef True) <*> (newIORef len) <*> (newIORef chiffres)) in
            cd 0

print_bigint a =
  do ifM (fmap not (readIORef (_bigint_sign a)))
         (printf "%c" ('-' :: Char) :: IO ())
         (return ())
     ca <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let bz i =
            if i <= ca
            then do printf "%d" =<< (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> (return 1)) <*> (return i)) :: IO Int)
                    bz (i + 1)
            else return () in
            bz 0

bigint_eq a b =
  {- Renvoie vrai si a = b -}
  ifM ((/=) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b)))
      (return False)
      (ifM ((/=) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b)))
           (return False)
           (do by <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
               let bx i =
                      if i <= by
                      then ifM ((/=) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                               (return False)
                               (bx (i + 1))
                      else return True in
                      bx 0))

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
                     (do bw <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
                         let bv i =
                                if i <= bw
                                then do j <- ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> (return 1)) <*> (return i))
                                        ifM ((>) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j))
                                            (readIORef (_bigint_sign a))
                                            (ifM ((<) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j))
                                                 (fmap not (readIORef (_bigint_sign a)))
                                                 (bv (i + 1)))
                                else return True in
                                bv 0))))

bigint_lt a b =
  fmap not (bigint_gt a b)

add_bigint_positif a b =
  {- Une addition ou on en a rien a faire des signes -}
  do len <- (((+) 1) <$> ((max <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b)))))
     (array_init_withenv len (\ i cj ->
                                do ck <- ifM (((<) i) <$> (readIORef (_bigint_len a)))
                                             (do cl <- (((+) cj) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                                                 return cl)
                                             (return cj)
                                   cm <- ifM (((<) i) <$> (readIORef (_bigint_len b)))
                                             (do cn <- (((+) ck) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                                                 return cn)
                                             (return ck)
                                   let co = cm `quot` 10
                                   let bs = cm `rem` 10
                                   return (co, bs)) 0) >>= (\ (cg, chiffres) ->
                                                             let bu ch =
                                                                    ifM ((return (ch > 0)) <&&> (((==) 0) <$> (readIOA chiffres (ch - 1))))
                                                                        (do let ci = ch - 1
                                                                            bu ci)
                                                                        (Bigint <$> (newIORef True) <*> (newIORef ch) <*> (newIORef chiffres)) in
                                                                    bu len)

sub_bigint_positif a b =
  {- Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
-}
  do len <- readIORef (_bigint_len a)
     (array_init_withenv len (\ i cs ->
                                do tmp <- (((+) cs) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                                   ct <- ifM (((<) i) <$> (readIORef (_bigint_len b)))
                                             (do cu <- (((-) tmp) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                                                 return cu)
                                             (return tmp)
                                   (\ (cv, cw) ->
                                     return (cv, cw)) (if ct < 0
                                                       then let cx = ct + 10
                                                                     in let cy = - 1
                                                                                 in (cy, cx)
                                                       else (0, ct))) 0) >>= (\ (cp, chiffres) ->
                                                                               let br cq =
                                                                                      ifM ((return (cq > 0)) <&&> (((==) 0) <$> (readIOA chiffres (cq - 1))))
                                                                                          (do let cr = cq - 1
                                                                                              br cr)
                                                                                          (Bigint <$> (newIORef True) <*> (newIORef cq) <*> (newIORef chiffres)) in
                                                                                      br len)

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
     bo <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let bl i =
            if i <= bo
            then do bn <- ((-) <$> (readIORef (_bigint_len b)) <*> (return 1))
                    let bm j da =
                           if j <= bn
                           then do writeIOA chiffres (i + j) =<< ((+) <$> (readIOA chiffres (i + j)) <*> (((+) da) <$> ((*) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))))
                                   db <- (quot <$> (readIOA chiffres (i + j)) <*> (return 10))
                                   writeIOA chiffres (i + j) =<< (rem <$> (readIOA chiffres (i + j)) <*> (return 10))
                                   bm (j + 1) db
                           else do join $ writeIOA chiffres <$> (((+) i) <$> (readIORef (_bigint_len b))) <*> (((+) da) <$> (readIOA chiffres =<< (((+) i) <$> (readIORef (_bigint_len b)))))
                                   bl (i + 1) in
                           bm 0 0
            else do join $ writeIOA chiffres <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (quot <$> (readIOA chiffres =<< ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1))) <*> (return 10))
                    join $ writeIOA chiffres <$> ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1)) <*> (rem <$> (readIOA chiffres =<< ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1))) <*> (return 10))
                    let bk l dc =
                           if l <= 2
                           then ifM ((return (dc /= 0)) <&&> (((==) 0) <$> (readIOA chiffres (dc - 1))))
                                    (do let dd = dc - 1
                                        bk (l + 1) dd)
                                    (bk (l + 1) dc)
                           else (Bigint <$> (((==) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b))) >>= newIORef) <*> (newIORef dc) <*> (newIORef chiffres)) in
                           bk 0 len in
            bl 0

bigint_premiers_chiffres a i =
  do len <- ((min <$> (return i) <*> (readIORef (_bigint_len a))))
     let bh de =
            ifM ((return (de /= 0)) <&&> (((==) 0) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (de - 1))))
                (do let df = de - 1
                    bh df)
                (Bigint <$> ((readIORef (_bigint_sign a)) >>= newIORef) <*> (newIORef de) <*> ((readIORef (_bigint_chiffres a)) >>= newIORef)) in
            bh len

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
                (do split <- (quot <$> ((min <$> (readIORef (_bigint_len aa)) <*> (readIORef (_bigint_len bb)))) <*> (return 2))
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
  let be dg dh =
         if dg >= 10
         then do let di = dg `quot` 10
                 let dj = dh + 1
                 be di dj
         else return dh in
         be a 1

bigint_of_int i =
  do size <- log10 i
     let dk = if i == 0
              then 0
              else size
     t <- array_init dk (\ j ->
                           return 0)
     let bc k dm =
            if k <= dk - 1
            then do writeIOA t k (dm `rem` 10)
                    let dn = dm `quot` 10
                    bc (k + 1) dn
            else (Bigint <$> (newIORef True) <*> (newIORef dk) <*> (newIORef t)) in
            bc 0 i

fact_bigint a =
  do one <- bigint_of_int 1
     let y dp dq =
           ifM (fmap not (bigint_eq dp one))
               (do dr <- mul_bigint dp dq
                   ds <- sub_bigint dp one
                   y ds dr)
               (return dq) in
           y a one

sum_chiffres_bigint a =
  do x <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let w i dt =
           if i <= x
           then do du <- (((+) dt) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                   w (i + 1) du
           else return dt in
           w 0 0

euler20 () =
  do a <- bigint_of_int 15
     {- normalement c'est 100 -}
     do dv <- fact_bigint a
        sum_chiffres_bigint dv

bigint_exp a b =
  if b == 1
  then return a
  else if (b `rem` 2) == 0
       then join $ bigint_exp <$> (mul_bigint a a) <*> return (b `quot` 2)
       else mul_bigint a =<< (bigint_exp a (b - 1))

bigint_exp_10chiffres a b =
  do dw <- bigint_premiers_chiffres a 10
     if b == 1
     then return dw
     else if (b `rem` 2) == 0
          then join $ bigint_exp_10chiffres <$> (mul_bigint dw dw) <*> return (b `quot` 2)
          else mul_bigint dw =<< (bigint_exp_10chiffres dw (b - 1))

euler48 () =
  do sum <- bigint_of_int 0
     let v i dx =
           if i <= 100
           then {- 1000 normalement -}
                do ib <- bigint_of_int i
                   ibeib <- bigint_exp_10chiffres ib i
                   dy <- add_bigint dx ibeib
                   dz <- bigint_premiers_chiffres dy 10
                   v (i + 1) dz
           else do printf "euler 48 = " :: IO ()
                   print_bigint dx
                   printf "\n" :: IO () in
           v 1 sum

euler16 () =
  do a <- bigint_of_int 2
     ea <- bigint_exp a 100
     {- 1000 normalement -}
     sum_chiffres_bigint ea

euler25 () =
  do a <- bigint_of_int 1
     b <- bigint_of_int 1
     let u eb ec ed =
           ifM (((>) 100) <$> (readIORef (_bigint_len ec)))
               {- 1000 normalement -}
               (do c <- add_bigint eb ec
                   let eg = ed + 1
                   u ec c eg)
               (return ed) in
           u a b 2

euler29 () =
  do a_bigint <- array_init (5 + 1) (\ j ->
                                       bigint_of_int (j * j))
     a0_bigint <- array_init (5 + 1) (\ j2 ->
                                        bigint_of_int j2)
     b <- array_init (5 + 1) (\ k ->
                                return 2)
     let q eh ei =
           if eh
           then do min0 <- readIOA a0_bigint 0
                   let s i ek el =
                         if i <= 5
                         then ifM (((>=) 5) <$> (readIOA b i))
                                  (if ek
                                   then ifM (join $ bigint_lt <$> (readIOA a_bigint i) <*> return el)
                                            (do em <- readIOA a_bigint i
                                                s (i + 1) ek em)
                                            (s (i + 1) ek el)
                                   else do en <- readIOA a_bigint i
                                           s (i + 1) True en)
                                  (s (i + 1) ek el)
                         else if ek
                              then do let ep = ei + 1
                                      let r l =
                                            if l <= 5
                                            then ifM ((join $ bigint_eq <$> (readIOA a_bigint l) <*> return el) <&&> (((>=) 5) <$> (readIOA b l)))
                                                     (do writeIOA b l =<< (((+) 1) <$> (readIOA b l))
                                                         writeIOA a_bigint l =<< (join $ mul_bigint <$> (readIOA a_bigint l) <*> (readIOA a0_bigint l))
                                                         r (l + 1))
                                                     (r (l + 1))
                                            else q ek ep in
                                            r 2
                              else q ek ei in
                         s 2 False min0
           else return ei in
           q True 0

main =
  do printf "%d\n" =<< ((euler29 ())::IO Int)
     sum <- read_bigint 50
     let cf i eq =
            if i <= 100
            then do skip_whitespaces
                    tmp <- read_bigint 50
                    er <- add_bigint eq tmp
                    cf (i + 1) er
            else do printf "euler13 = " :: IO ()
                    print_bigint eq
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
            cf 2 sum


