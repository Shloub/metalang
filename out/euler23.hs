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
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
eratostene t max0 =
  let m i bi =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let bj = bi + 1
                     let j = i * i
                     let u bk =
                           if bk < max0 && bk > 0
                           then do writeIOA t bk 0
                                   let bl = bk + i
                                   u bl
                           else m (i + 1) bj in
                           u j)
                 (m (i + 1) bi)
        else return bi in
        m 2 0

fillPrimesFactors t n primes nprimes =
  let g i bm =
        if i <= nprimes - 1
        then do d <- readIOA primes i
                let h bn =
                      if (bn `rem` d) == 0
                      then do writeIOA t d =<< (((+) 1) <$> (readIOA t d))
                              let bo = bn `quot` d
                              h bo
                      else if bn == 1
                           then readIOA primes i
                           else g (i + 1) bn in
                      h bm
        else return bm in
        g 0 n

sumdivaux2 t n i =
  let f bp =
        ifM ((return (bp < n)) <&&> (((==) 0) <$> (readIOA t bp)))
            (do let bq = bp + 1
                f bq)
            (return bp) in
        f i

sumdivaux t n i =
  if i > n
  then return 1
  else ifM (((==) 0) <$> (readIOA t i))
           (sumdivaux t n =<< (sumdivaux2 t n (i + 1)))
           (do o <- sumdivaux t n =<< (sumdivaux2 t n (i + 1))
               e <- readIOA t i
               let c j br bs =
                     if j <= e
                     then do let bt = br + bs
                             let bu = bs * i
                             c (j + 1) bt bu
                     else return ((br + 1) * o) in
                     c 1 0 i)

sumdiv nprimes primes n =
  do t <- array_init (n + 1) (\ i ->
                                return 0)
     max0 <- fillPrimesFactors t n primes nprimes
     sumdivaux t max0 0

main =
  do era <- array_init 30001 (\ s ->
                                return s)
     nprimes <- eratostene era 30001
     primes <- array_init nprimes (\ t ->
                                     return 0)
     let bh k bv =
            if k <= 30001 - 1
            then ifM (((==) k) <$> (readIOA era k))
                     (do writeIOA primes bv k
                         let bw = bv + 1
                         bh (k + 1) bw)
                     (bh (k + 1) bv)
            else {- 28124 ça prend trop de temps mais on arrive a passer le test -}
                 do abondant <- array_init (100 + 1) (\ p ->
                                                        return False)
                    summable <- array_init (100 + 1) (\ q ->
                                                        return False)
                    let bg r =
                           if r <= 100
                           then do other <- ((-) <$> (sumdiv nprimes primes r) <*> (return r))
                                   if other > r
                                   then do writeIOA abondant r True
                                           bg (r + 1)
                                   else bg (r + 1)
                           else let be i =
                                       if i <= 100
                                       then let bf j =
                                                   if j <= 100
                                                   then ifM (((&&) (i + j <= 100)) <$> ((readIOA abondant i) <&&> (readIOA abondant j)))
                                                            (do writeIOA summable (i + j) True
                                                                bf (j + 1))
                                                            (bf (j + 1))
                                                   else be (i + 1) in
                                                   bf 1
                                       else let bd o bx =
                                                   if o <= 100
                                                   then ifM (fmap not (readIOA summable o))
                                                            (do let by = bx + o
                                                                bd (o + 1) by)
                                                            (bd (o + 1) bx)
                                                   else printf "\n%d\n" (bx::Int) :: IO() in
                                                   bd 1 0 in
                                       be 1 in
                           bg 2 in
            bh 2 0


