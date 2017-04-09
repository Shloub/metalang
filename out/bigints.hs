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
     let e = (len - 1) `quot` 2
     let f i =
           if i <= e
           then do tmp <- readIOA chiffres i
                   writeIOA chiffres i =<< (readIOA chiffres (len - 1 - i))
                   writeIOA chiffres (len - 1 - i) tmp
                   f (i + 1)
           else (Bigint <$> (newIORef True) <*> (newIORef len) <*> (newIORef chiffres)) in
           f 0

print_bigint a =
  do ifM (fmap not (readIORef (_bigint_sign a)))
         (printf "%c" ('-' :: Char) :: IO ())
         (return ())
     g <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let h i =
           if i <= g
           then do printf "%d" =<< (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> (return 1)) <*> (return i)) :: IO Int)
                   h (i + 1)
           else return () in
           h 0

bigint_eq a b =
  {- Renvoie vrai si a = b -}
  ifM ((/=) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b)))
      (return False)
      (ifM ((/=) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b)))
           (return False)
           (do m <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
               let o i =
                     if i <= m
                     then ifM ((/=) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                              (return False)
                              (o (i + 1))
                     else return True in
                     o 0))

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
                     (do p <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
                         let q i =
                               if i <= p
                               then do j <- ((-) <$> ((-) <$> (readIORef (_bigint_len a)) <*> (return 1)) <*> (return i))
                                       ifM ((>) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j))
                                           (readIORef (_bigint_sign a))
                                           (ifM ((<) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j))
                                                (fmap not (readIORef (_bigint_sign a)))
                                                (q (i + 1)))
                               else return True in
                               q 0))))

bigint_lt a b =
  fmap not (bigint_gt a b)

add_bigint_positif a b =
  {- Une addition ou on en a rien a faire des signes -}
  do len <- (((+) 1) <$> ((max <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b)))))
     (array_init_withenv len (\ i r ->
                                do s <- ifM (((<) i) <$> (readIORef (_bigint_len a)))
                                            (((+) r) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                                            (return r)
                                   u <- ifM (((<) i) <$> (readIORef (_bigint_len b)))
                                            (((+) s) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                                            (return s)
                                   let v = u `quot` 10
                                   let w = u `rem` 10
                                   return (v, w)) 0) >>= (\ (x, chiffres) ->
                                                           let y z =
                                                                 ifM ((return (z > 0)) <&&> (((==) 0) <$> (readIOA chiffres (z - 1))))
                                                                     (do let ba = z - 1
                                                                         y ba)
                                                                     (Bigint <$> (newIORef True) <*> (newIORef z) <*> (newIORef chiffres)) in
                                                                 y len)

sub_bigint_positif a b =
  {- Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
-}
  do len <- readIORef (_bigint_len a)
     (array_init_withenv len (\ i bc ->
                                do tmp <- (((+) bc) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                                   be <- ifM (((<) i) <$> (readIORef (_bigint_len b)))
                                             (((-) tmp) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return i))
                                             (return tmp)
                                   (\ (bh, bi) ->
                                     return (bh, bi)) (if be < 0
                                                       then let bf = be + 10
                                                                     in let bg = - 1
                                                                                 in (bg, bf)
                                                       else (0, be))) 0) >>= (\ (bj, chiffres) ->
                                                                               let bk bl =
                                                                                      ifM ((return (bl > 0)) <&&> (((==) 0) <$> (readIOA chiffres (bl - 1))))
                                                                                          (do let bm = bl - 1
                                                                                              bk bm)
                                                                                          (Bigint <$> (newIORef True) <*> (newIORef bl) <*> (newIORef chiffres)) in
                                                                                      bk len)

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
     bn <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let bo i =
            if i <= bn
            then do bs <- ((-) <$> (readIORef (_bigint_len b)) <*> (return 1))
                    let bt j bu =
                           if j <= bs
                           then do writeIOA chiffres (i + j) =<< ((+) <$> (readIOA chiffres (i + j)) <*> (((+) bu) <$> ((*) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres b)) <*> return j) <*> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))))
                                   bv <- (quot <$> (readIOA chiffres (i + j)) <*> (return 10))
                                   writeIOA chiffres (i + j) =<< (rem <$> (readIOA chiffres (i + j)) <*> (return 10))
                                   bt (j + 1) bv
                           else do join $ writeIOA chiffres <$> (((+) i) <$> (readIORef (_bigint_len b))) <*> (((+) bu) <$> (readIOA chiffres =<< (((+) i) <$> (readIORef (_bigint_len b)))))
                                   bo (i + 1) in
                           bt 0 0
            else do join $ writeIOA chiffres <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (quot <$> (readIOA chiffres =<< ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1))) <*> (return 10))
                    join $ writeIOA chiffres <$> ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1)) <*> (rem <$> (readIOA chiffres =<< ((-) <$> ((+) <$> (readIORef (_bigint_len a)) <*> (readIORef (_bigint_len b))) <*> (return 1))) <*> (return 10))
                    let bp l bq =
                           if l <= 2
                           then ifM ((return (bq /= 0)) <&&> (((==) 0) <$> (readIOA chiffres (bq - 1))))
                                    (do let br = bq - 1
                                        bp (l + 1) br)
                                    (bp (l + 1) bq)
                           else (Bigint <$> (((==) <$> (readIORef (_bigint_sign a)) <*> (readIORef (_bigint_sign b))) >>= newIORef) <*> (newIORef bq) <*> (newIORef chiffres)) in
                           bp 0 len in
            bo 0

bigint_premiers_chiffres a i =
  do len <- ((min <$> (return i) <*> (readIORef (_bigint_len a))))
     let bw bx =
            ifM ((return (bx /= 0)) <&&> (((==) 0) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return (bx - 1))))
                (do let by = bx - 1
                    bw by)
                (Bigint <$> ((readIORef (_bigint_sign a)) >>= newIORef) <*> (newIORef bx) <*> ((readIORef (_bigint_chiffres a)) >>= newIORef)) in
            bw len

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
  let bz ca cb =
         if ca >= 10
         then do let cc = ca `quot` 10
                 let cd = cb + 1
                 bz cc cd
         else return cb in
         bz a 1

bigint_of_int i =
  do size <- log10 i
     let ce = if i == 0
              then 0
              else size
     t <- array_init ce (\ j ->
                           return 0)
     let cf k cg =
            if k <= ce - 1
            then do writeIOA t k (cg `rem` 10)
                    let ch = cg `quot` 10
                    cf (k + 1) ch
            else (Bigint <$> (newIORef True) <*> (newIORef ce) <*> (newIORef t)) in
            cf 0 i

fact_bigint a =
  do one <- bigint_of_int 1
     let ci cj ck =
            ifM (fmap not (bigint_eq cj one))
                (do cl <- mul_bigint cj ck
                    cm <- sub_bigint cj one
                    ci cm cl)
                (return ck) in
            ci a one

sum_chiffres_bigint a =
  do cn <- ((-) <$> (readIORef (_bigint_len a)) <*> (return 1))
     let co i cp =
            if i <= cn
            then do cq <- (((+) cp) <$> (join $ readIOA <$> (readIORef (_bigint_chiffres a)) <*> return i))
                    co (i + 1) cq
            else return cp in
            co 0 0

euler20 () =
  do a <- bigint_of_int 15
     {- normalement c'est 100 -}
     do cr <- fact_bigint a
        sum_chiffres_bigint cr

bigint_exp a b =
  if b == 1
  then return a
  else if (b `rem` 2) == 0
       then join $ bigint_exp <$> (mul_bigint a a) <*> return (b `quot` 2)
       else mul_bigint a =<< (bigint_exp a (b - 1))

bigint_exp_10chiffres a b =
  do cs <- bigint_premiers_chiffres a 10
     if b == 1
     then return cs
     else if (b `rem` 2) == 0
          then join $ bigint_exp_10chiffres <$> (mul_bigint cs cs) <*> return (b `quot` 2)
          else mul_bigint cs =<< (bigint_exp_10chiffres cs (b - 1))

euler48 () =
  do sum <- bigint_of_int 0
     let ct i cu =
            if i <= 100
            then {- 1000 normalement -}
                 do ib <- bigint_of_int i
                    ibeib <- bigint_exp_10chiffres ib i
                    cv <- add_bigint cu ibeib
                    cw <- bigint_premiers_chiffres cv 10
                    ct (i + 1) cw
            else do printf "euler 48 = " :: IO ()
                    print_bigint cu
                    printf "\n" :: IO () in
            ct 1 sum

euler16 () =
  do a <- bigint_of_int 2
     cx <- bigint_exp a 100
     {- 1000 normalement -}
     sum_chiffres_bigint cx

euler25 () =
  do a <- bigint_of_int 1
     b <- bigint_of_int 1
     let cy cz da db =
            ifM (((>) 100) <$> (readIORef (_bigint_len da)))
                {- 1000 normalement -}
                (do c <- add_bigint cz da
                    let dc = db + 1
                    cy da c dc)
                (return db) in
            cy a b 2

euler29 () =
  do a_bigint <- array_init (5 + 1) (\ j ->
                                       bigint_of_int (j * j))
     a0_bigint <- array_init (5 + 1) (\ j2 ->
                                        bigint_of_int j2)
     b <- array_init (5 + 1) (\ k ->
                                return 2)
     let dd de df =
            if de
            then do min0 <- readIOA a0_bigint 0
                    let dg i dh di =
                           if i <= 5
                           then ifM (((>=) 5) <$> (readIOA b i))
                                    (if dh
                                     then ifM (join $ bigint_lt <$> (readIOA a_bigint i) <*> return di)
                                              (do dm <- readIOA a_bigint i
                                                  dg (i + 1) dh dm)
                                              (dg (i + 1) dh di)
                                     else do dl <- readIOA a_bigint i
                                             dg (i + 1) True dl)
                                    (dg (i + 1) dh di)
                           else if dh
                                then do let dj = df + 1
                                        let dk l =
                                               if l <= 5
                                               then ifM ((join $ bigint_eq <$> (readIOA a_bigint l) <*> return di) <&&> (((>=) 5) <$> (readIOA b l)))
                                                        (do writeIOA b l =<< (((+) 1) <$> (readIOA b l))
                                                            writeIOA a_bigint l =<< (join $ mul_bigint <$> (readIOA a_bigint l) <*> (readIOA a0_bigint l))
                                                            dk (l + 1))
                                                        (dk (l + 1))
                                               else dd dh dj in
                                               dk 2
                                else dd dh df in
                           dg 2 False min0
            else return df in
            dd True 0

main =
  do printf "%d\n" =<< ((euler29 ())::IO Int)
     sum <- read_bigint 50
     let dn i dp =
            if i <= 100
            then do skip_whitespaces
                    tmp <- read_bigint 50
                    dq <- add_bigint dp tmp
                    dn (i + 1) dq
            else do printf "euler13 = " :: IO ()
                    print_bigint dp
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
                    ifM (bigint_gt a b)
                        (printf "True" :: IO ())
                        (printf "False" :: IO ())
                    printf "\n" :: IO () in
            dn 2 sum


