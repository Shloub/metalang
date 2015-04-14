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
     let f = (len - 1) `quot` 2
     let g i =
           if i <= f
           then do tmp <- readIOA chiffres i
                   writeIOA chiffres i =<< (readIOA chiffres (len - 1 - i))
                   writeIOA chiffres (len - 1 - i) tmp
                   g (i + 1)
           else (Bigint <$> (newIORef True) <*> (newIORef len) <*> (newIORef chiffres)) in
           g 0

print_bigint a =
  do ifM (fmap not (readIORef (_bigint_sign a)))
         (printf "%c" ('-' :: Char) :: IO ())
         (return ())
     h <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let m i =
           if i <= h
           then do printf "%d" =<< (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> (return 1)) <*> (return i)) :: IO Int)
                   m (i + 1)
           else return () in
           m 0

bigint_eq a b =
  {- Renvoie vrai si a = b -}
  ifM ((/=) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b)))
      (return False)
      (ifM ((/=) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b)))
           (return False)
           (do o <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
               let p i =
                     if i <= o
                     then ifM ((/=) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                              (return False)
                              (p (i + 1))
                     else return True in
                     p 0))

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
                     (do q <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
                         let r i =
                               if i <= q
                               then do j <- ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> (return 1)) <*> (return i))
                                       ifM ((>) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j))
                                           (readIORef (_bigint_sign a))
                                           (ifM ((<) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j))
                                                (fmap not (readIORef (_bigint_sign a)))
                                                (r (i + 1)))
                               else return True in
                               r 0))))

bigint_lt a b =
  fmap not (bigint_gt a b)

add_bigint_positif a b =
  {- Une addition ou on en a rien a faire des signes -}
  do len <- (((+) 1) <$> ((max <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b)))))
     (array_init_withenv len (\ i s ->
                                do u <- ifM (((<) i) <$> (readIORef (_bigint_len a)))
                                            (((+) s) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                                            (return s)
                                   v <- ifM (((<) i) <$> (readIORef (_bigint_len b)))
                                            (((+) u) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                                            (return u)
                                   let w = v `quot` 10
                                   let x = v `rem` 10
                                   return (w, x)) 0) >>= (\ (y, chiffres) ->
                                                           let z ba =
                                                                 ifM ((return (ba > 0)) <&&> (((==) 0) <$> (readIOA chiffres (ba - 1))))
                                                                     (do let bc = ba - 1
                                                                         z bc)
                                                                     (Bigint <$> (newIORef True) <*> (newIORef ba) <*> (newIORef chiffres)) in
                                                                 z len)

sub_bigint_positif a b =
  {- Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
-}
  do len <- readIORef (_bigint_len a)
     (array_init_withenv len (\ i be ->
                                do tmp <- (((+) be) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                                   bf <- ifM (((<) i) <$> (readIORef (_bigint_len b)))
                                             (((-) tmp) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                                             (return tmp)
                                   (\ (bi, bj) ->
                                     return (bi, bj)) (if bf < 0
                                                       then let bg = bf + 10
                                                                     in let bh = - 1
                                                                                 in (bh, bg)
                                                       else (0, bf))) 0) >>= (\ (bk, chiffres) ->
                                                                               let bl bm =
                                                                                      ifM ((return (bm > 0)) <&&> (((==) 0) <$> (readIOA chiffres (bm - 1))))
                                                                                          (do let bn = bm - 1
                                                                                              bl bn)
                                                                                          (Bigint <$> (newIORef True) <*> (newIORef bm) <*> (newIORef chiffres)) in
                                                                                      bl len)

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
     let bp i =
            if i <= bo
            then do bt <- ((-) <$> (readIORef (_bigint_len b)) <*> (return 1))
                    let bu j bv =
                           if j <= bt
                           then do writeIOA chiffres (i + j) =<< ((+) <$> (readIOA chiffres (i + j)) <*> (((+) bv) <$> ((*) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))))
                                   bw <- (quot <$> (readIOA chiffres (i + j)) <*> (return 10))
                                   writeIOA chiffres (i + j) =<< (rem <$> (readIOA chiffres (i + j)) <*> (return 10))
                                   bu (j + 1) bw
                           else do join $ writeIOA chiffres <$> (((+) i) <$> (readIORef (_bigint_len b))) <*> (((+) bv) <$> (readIOA chiffres =<< (((+) i) <$> (readIORef (_bigint_len b)))))
                                   bp (i + 1) in
                           bu 0 0
            else do join $ writeIOA chiffres <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (quot <$> (readIOA chiffres =<< ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1))) <*> (return 10))
                    join $ writeIOA chiffres <$> ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1)) <*> (rem <$> (readIOA chiffres =<< ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1))) <*> (return 10))
                    let bq l br =
                           if l <= 2
                           then ifM ((return (br /= 0)) <&&> (((==) 0) <$> (readIOA chiffres (br - 1))))
                                    (do let bs = br - 1
                                        bq (l + 1) bs)
                                    (bq (l + 1) br)
                           else (Bigint <$> (((==) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b))) >>= newIORef) <*> (newIORef br) <*> (newIORef chiffres)) in
                           bq 0 len in
            bp 0

bigint_premiers_chiffres a i =
  do len <- ((min <$> (return i) <*> (readIORef (_bigint_len a))))
     let bx by =
            ifM ((return (by /= 0)) <&&> (((==) 0) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (by - 1))))
                (do let bz = by - 1
                    bx bz)
                (Bigint <$> ((readIORef (_bigint_sign a)) >>= newIORef) <*> (newIORef by) <*> ((readIORef (_bigint_chiffres a)) >>= newIORef)) in
            bx len

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
  let ca cb cc =
         if cb >= 10
         then do let cd = cb `quot` 10
                 let ce = cc + 1
                 ca cd ce
         else return cc in
         ca a 1

bigint_of_int i =
  do size <- log10 i
     let cf = if i == 0
              then 0
              else size
     t <- array_init cf (\ j ->
                           return 0)
     let cg k ch =
            if k <= cf - 1
            then do writeIOA t k (ch `rem` 10)
                    let ci = ch `quot` 10
                    cg (k + 1) ci
            else (Bigint <$> (newIORef True) <*> (newIORef cf) <*> (newIORef t)) in
            cg 0 i

fact_bigint a =
  do one <- bigint_of_int 1
     let cj ck cl =
            ifM (fmap not (bigint_eq ck one))
                (do cm <- mul_bigint ck cl
                    cn <- sub_bigint ck one
                    cj cn cm)
                (return cl) in
            cj a one

sum_chiffres_bigint a =
  do co <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let cp i cq =
            if i <= co
            then do cr <- (((+) cq) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                    cp (i + 1) cr
            else return cq in
            cp 0 0

euler20 () =
  do a <- bigint_of_int 15
     {- normalement c'est 100 -}
     do cs <- fact_bigint a
        sum_chiffres_bigint cs

bigint_exp a b =
  if b == 1
  then return a
  else if (b `rem` 2) == 0
       then join $ bigint_exp <$> (mul_bigint a a) <*> return (b `quot` 2)
       else mul_bigint a =<< (bigint_exp a (b - 1))

bigint_exp_10chiffres a b =
  do ct <- bigint_premiers_chiffres a 10
     if b == 1
     then return ct
     else if (b `rem` 2) == 0
          then join $ bigint_exp_10chiffres <$> (mul_bigint ct ct) <*> return (b `quot` 2)
          else mul_bigint ct =<< (bigint_exp_10chiffres ct (b - 1))

euler48 () =
  do sum <- bigint_of_int 0
     let cu i cv =
            if i <= 100
            then {- 1000 normalement -}
                 do ib <- bigint_of_int i
                    ibeib <- bigint_exp_10chiffres ib i
                    cw <- add_bigint cv ibeib
                    cx <- bigint_premiers_chiffres cw 10
                    cu (i + 1) cx
            else do printf "euler 48 = " :: IO ()
                    print_bigint cv
                    printf "\n" :: IO () in
            cu 1 sum

euler16 () =
  do a <- bigint_of_int 2
     cy <- bigint_exp a 100
     {- 1000 normalement -}
     sum_chiffres_bigint cy

euler25 () =
  do a <- bigint_of_int 1
     b <- bigint_of_int 1
     let cz da db dc =
            ifM (((>) 100) <$> (readIORef (_bigint_len db)))
                {- 1000 normalement -}
                (do c <- add_bigint da db
                    let dd = dc + 1
                    cz db c dd)
                (return dc) in
            cz a b 2

euler29 () =
  do a_bigint <- array_init (5 + 1) (\ j ->
                                       bigint_of_int (j * j))
     a0_bigint <- array_init (5 + 1) (\ j2 ->
                                        bigint_of_int j2)
     b <- array_init (5 + 1) (\ k ->
                                return 2)
     let de df dg =
            if df
            then do min0 <- readIOA a0_bigint 0
                    let dh i di dj =
                           if i <= 5
                           then ifM (((>=) 5) <$> (readIOA b i))
                                    (if di
                                     then ifM (join $ bigint_lt <$> (readIOA a_bigint i) <*> return dj)
                                              (do dn <- readIOA a_bigint i
                                                  dh (i + 1) di dn)
                                              (dh (i + 1) di dj)
                                     else do dm <- readIOA a_bigint i
                                             dh (i + 1) True dm)
                                    (dh (i + 1) di dj)
                           else if di
                                then do let dk = dg + 1
                                        let dl l =
                                               if l <= 5
                                               then ifM ((join $ bigint_eq <$> (readIOA a_bigint l) <*> return dj) <&&> (((>=) 5) <$> (readIOA b l)))
                                                        (do writeIOA b l =<< (((+) 1) <$> (readIOA b l))
                                                            writeIOA a_bigint l =<< (join $ mul_bigint <$> (readIOA a_bigint l) <*> (readIOA a0_bigint l))
                                                            dl (l + 1))
                                                        (dl (l + 1))
                                               else de di dk in
                                               dl 2
                                else de di dg in
                           dh 2 False min0
            else return dg in
            de True 0

main =
  do printf "%d\n" =<< ((euler29 ())::IO Int)
     sum <- read_bigint 50
     let dp i dq =
            if i <= 100
            then do skip_whitespaces
                    tmp <- read_bigint 50
                    dr <- add_bigint dq tmp
                    dp (i + 1) dr
            else do printf "euler13 = " :: IO ()
                    print_bigint dq
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
            dp 2 sum


