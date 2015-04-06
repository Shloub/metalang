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
     (array_init_withenv len (\ i x ->
                                do y <- ifM (((<) i) <$> (readIORef (_bigint_len a)))
                                            (do z <- (((+) x) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                                                return z)
                                            (return x)
                                   ba <- ifM (((<) i) <$> (readIORef (_bigint_len b)))
                                             (do bc <- (((+) y) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                                                 return bc)
                                             (return y)
                                   let be = ba `quot` 10
                                   let bf = ba `rem` 10
                                   return (be, bf)) 0) >>= (\ (s, chiffres) ->
                                                             let u v =
                                                                   ifM ((return (v > 0)) <&&> (((==) 0) <$> (readIOA chiffres (v - 1))))
                                                                       (do let w = v - 1
                                                                           u w)
                                                                       (Bigint <$> (newIORef True) <*> (newIORef v) <*> (newIORef chiffres)) in
                                                                   u len)

sub_bigint_positif a b =
  {- Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
-}
  do len <- readIORef (_bigint_len a)
     (array_init_withenv len (\ i bk ->
                                do tmp <- (((+) bk) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                                   bl <- ifM (((<) i) <$> (readIORef (_bigint_len b)))
                                             (do bm <- (((-) tmp) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                                                 return bm)
                                             (return tmp)
                                   (\ (bn, bo) ->
                                     return (bn, bo)) (if bl < 0
                                                       then let bp = bl + 10
                                                                     in let bq = - 1
                                                                                 in (bq, bp)
                                                       else (0, bl))) 0) >>= (\ (bg, chiffres) ->
                                                                               let bh bi =
                                                                                      ifM ((return (bi > 0)) <&&> (((==) 0) <$> (readIOA chiffres (bi - 1))))
                                                                                          (do let bj = bi - 1
                                                                                              bh bj)
                                                                                          (Bigint <$> (newIORef True) <*> (newIORef bi) <*> (newIORef chiffres)) in
                                                                                      bh len)

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
     br <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let bs i =
            if i <= br
            then do bt <- ((-) <$> (readIORef (_bigint_len b)) <*> (return 1))
                    let bu j bv =
                           if j <= bt
                           then do writeIOA chiffres (i + j) =<< ((+) <$> (readIOA chiffres (i + j)) <*> (((+) bv) <$> ((*) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))))
                                   bw <- (quot <$> (readIOA chiffres (i + j)) <*> (return 10))
                                   writeIOA chiffres (i + j) =<< (rem <$> (readIOA chiffres (i + j)) <*> (return 10))
                                   bu (j + 1) bw
                           else do join $ writeIOA chiffres <$> (((+) i) <$> (readIORef (_bigint_len b))) <*> (((+) bv) <$> (readIOA chiffres =<< (((+) i) <$> (readIORef (_bigint_len b)))))
                                   bs (i + 1) in
                           bu 0 0
            else do join $ writeIOA chiffres <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (quot <$> (readIOA chiffres =<< ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1))) <*> (return 10))
                    join $ writeIOA chiffres <$> ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1)) <*> (rem <$> (readIOA chiffres =<< ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1))) <*> (return 10))
                    let bx l by =
                           if l <= 2
                           then ifM ((return (by /= 0)) <&&> (((==) 0) <$> (readIOA chiffres (by - 1))))
                                    (do let bz = by - 1
                                        bx (l + 1) bz)
                                    (bx (l + 1) by)
                           else (Bigint <$> (((==) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b))) >>= newIORef) <*> (newIORef by) <*> (newIORef chiffres)) in
                           bx 0 len in
            bs 0

bigint_premiers_chiffres a i =
  do len <- ((min <$> (return i) <*> (readIORef (_bigint_len a))))
     let ca cb =
            ifM ((return (cb /= 0)) <&&> (((==) 0) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (cb - 1))))
                (do let cc = cb - 1
                    ca cc)
                (Bigint <$> ((readIORef (_bigint_sign a)) >>= newIORef) <*> (newIORef cb) <*> ((readIORef (_bigint_chiffres a)) >>= newIORef)) in
            ca len

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
  let cd ce cf =
         if ce >= 10
         then do let cg = ce `quot` 10
                 let ch = cf + 1
                 cd cg ch
         else return cf in
         cd a 1

bigint_of_int i =
  do size <- log10 i
     let ci = if i == 0
              then 0
              else size
     t <- array_init ci (\ j ->
                           return 0)
     let cj k ck =
            if k <= ci - 1
            then do writeIOA t k (ck `rem` 10)
                    let cl = ck `quot` 10
                    cj (k + 1) cl
            else (Bigint <$> (newIORef True) <*> (newIORef ci) <*> (newIORef t)) in
            cj 0 i

fact_bigint a =
  do one <- bigint_of_int 1
     let cm cn co =
            ifM (fmap not (bigint_eq cn one))
                (do cp <- mul_bigint cn co
                    cq <- sub_bigint cn one
                    cm cq cp)
                (return co) in
            cm a one

sum_chiffres_bigint a =
  do cr <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let cs i ct =
            if i <= cr
            then do cu <- (((+) ct) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                    cs (i + 1) cu
            else return ct in
            cs 0 0

euler20 () =
  do a <- bigint_of_int 15
     {- normalement c'est 100 -}
     do cv <- fact_bigint a
        sum_chiffres_bigint cv

bigint_exp a b =
  if b == 1
  then return a
  else if (b `rem` 2) == 0
       then join $ bigint_exp <$> (mul_bigint a a) <*> return (b `quot` 2)
       else mul_bigint a =<< (bigint_exp a (b - 1))

bigint_exp_10chiffres a b =
  do cw <- bigint_premiers_chiffres a 10
     if b == 1
     then return cw
     else if (b `rem` 2) == 0
          then join $ bigint_exp_10chiffres <$> (mul_bigint cw cw) <*> return (b `quot` 2)
          else mul_bigint cw =<< (bigint_exp_10chiffres cw (b - 1))

euler48 () =
  do sum <- bigint_of_int 0
     let cx i cy =
            if i <= 100
            then {- 1000 normalement -}
                 do ib <- bigint_of_int i
                    ibeib <- bigint_exp_10chiffres ib i
                    cz <- add_bigint cy ibeib
                    da <- bigint_premiers_chiffres cz 10
                    cx (i + 1) da
            else do printf "euler 48 = " :: IO ()
                    print_bigint cy
                    printf "\n" :: IO () in
            cx 1 sum

euler16 () =
  do a <- bigint_of_int 2
     db <- bigint_exp a 100
     {- 1000 normalement -}
     sum_chiffres_bigint db

euler25 () =
  do a <- bigint_of_int 1
     b <- bigint_of_int 1
     let dc dd de df =
            ifM (((>) 100) <$> (readIORef (_bigint_len de)))
                {- 1000 normalement -}
                (do c <- add_bigint dd de
                    let dg = df + 1
                    dc de c dg)
                (return df) in
            dc a b 2

euler29 () =
  do a_bigint <- array_init (5 + 1) (\ j ->
                                       bigint_of_int (j * j))
     a0_bigint <- array_init (5 + 1) (\ j2 ->
                                        bigint_of_int j2)
     b <- array_init (5 + 1) (\ k ->
                                return 2)
     let dh di dj =
            if di
            then do min0 <- readIOA a0_bigint 0
                    let dk i dl dm =
                           if i <= 5
                           then ifM (((>=) 5) <$> (readIOA b i))
                                    (if dl
                                     then ifM (join $ bigint_lt <$> (readIOA a_bigint i) <*> return dm)
                                              (do dn <- readIOA a_bigint i
                                                  dk (i + 1) dl dn)
                                              (dk (i + 1) dl dm)
                                     else do dp <- readIOA a_bigint i
                                             dk (i + 1) True dp)
                                    (dk (i + 1) dl dm)
                           else if dl
                                then do let dq = dj + 1
                                        let dr l =
                                               if l <= 5
                                               then ifM ((join $ bigint_eq <$> (readIOA a_bigint l) <*> return dm) <&&> (((>=) 5) <$> (readIOA b l)))
                                                        (do writeIOA b l =<< (((+) 1) <$> (readIOA b l))
                                                            writeIOA a_bigint l =<< (join $ mul_bigint <$> (readIOA a_bigint l) <*> (readIOA a0_bigint l))
                                                            dr (l + 1))
                                                        (dr (l + 1))
                                               else dh dl dq in
                                               dr 2
                                else dh dl dj in
                           dk 2 False min0
            else return dj in
            dh True 0

main =
  do printf "%d\n" =<< ((euler29 ())::IO Int)
     sum <- read_bigint 50
     let ds i dt =
            if i <= 100
            then do skip_whitespaces
                    tmp <- read_bigint 50
                    du <- add_bigint dt tmp
                    ds (i + 1) du
            else do printf "euler13 = " :: IO ()
                    print_bigint dt
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
            ds 2 sum


