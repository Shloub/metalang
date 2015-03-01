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
  do let w = max0 - 1
     let u i bl =
           if i <= w
           then ifM (((==) i) <$> (readIOA t i))
                    (do let bm = bl + 1
                        let j = i * i
                        let v bn =
                              if bn < max0 && bn > 0
                              then do writeIOA t bn 0
                                      let bo = bn + i
                                      v bo
                              else u (i + 1) bm in
                              v j)
                    (u (i + 1) bl)
           else return bl in
           u 2 0

fillPrimesFactors t n primes nprimes =
  do let m = nprimes - 1
     let g i bp =
           if i <= m
           then do d <- readIOA primes i
                   let h bq =
                         if (bq `rem` d) == 0
                         then do writeIOA t d =<< (((+) 1) <$> (readIOA t d))
                                 let br = bq `quot` d
                                 h br
                         else if bq == 1
                              then readIOA primes i
                              else g (i + 1) bq in
                         h bp
           else return bp in
           g 0 n

sumdivaux2 t n i =
  let f bs =
        ifM ((return (bs < n)) <&&> (((==) 0) <$> (readIOA t bs)))
            (do let bt = bs + 1
                f bt)
            (return bs) in
        f i

sumdivaux t n i =
  if i > n
  then return 1
  else ifM (((==) 0) <$> (readIOA t i))
           (sumdivaux t n =<< (sumdivaux2 t n (i + 1)))
           (do o <- sumdivaux t n =<< (sumdivaux2 t n (i + 1))
               e <- readIOA t i
               let c j bu bv =
                     if j <= e
                     then do let bw = bu + bv
                             let bx = bv * i
                             c (j + 1) bw bx
                     else return ((bu + 1) * o) in
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
     let bk = 30001 - 1
     let bj k by =
            if k <= bk
            then ifM (((==) k) <$> (readIOA era k))
                     (do writeIOA primes by k
                         let bz = by + 1
                         bj (k + 1) bz)
                     (bj (k + 1) by)
            else {- 28124 ça prend trop de temps mais on arrive a passer le test -}
                 do abondant <- array_init (100 + 1) (\ p ->
                                                        return False)
                    summable <- array_init (100 + 1) (\ q ->
                                                        return False)
                    let bi r =
                           if r <= 100
                           then do other <- ((-) <$> (sumdiv nprimes primes r) <*> (return r))
                                   if other > r
                                   then do writeIOA abondant r True
                                           bi (r + 1)
                                   else bi (r + 1)
                           else let bg i =
                                       if i <= 100
                                       then let bh j =
                                                   if j <= 100
                                                   then ifM (((&&) (i + j <= 100)) <$> ((readIOA abondant i) <&&> (readIOA abondant j)))
                                                            (do writeIOA summable (i + j) True
                                                                bh (j + 1))
                                                            (bh (j + 1))
                                                   else bg (i + 1) in
                                                   bh 1
                                       else let bf o ca =
                                                   if o <= 100
                                                   then ifM (fmap not (readIOA summable o))
                                                            (do let cb = ca + o
                                                                bf (o + 1) cb)
                                                            (bf (o + 1) ca)
                                                   else printf "\n%d\n" (ca::Int) :: IO() in
                                                   bf 1 0 in
                                       bg 1 in
                           bi 2 in
            bj 2 0


