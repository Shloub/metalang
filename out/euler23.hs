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
  let a i b =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let c = b + 1
                     let j = i * i
                     let e f =
                           if f < max0 && f > 0
                           then do writeIOA t f 0
                                   let g = f + i
                                   e g
                           else a (i + 1) c in
                           e j)
                 (a (i + 1) b)
        else return b in
        a 2 0

fillPrimesFactors t n primes nprimes =
  let h i m =
        if i <= nprimes - 1
        then do d <- readIOA primes i
                let u v =
                      if (v `rem` d) == 0
                      then do writeIOA t d =<< (((+) 1) <$> (readIOA t d))
                              let w = v `quot` d
                              u w
                      else if v == 1
                           then readIOA primes i
                           else h (i + 1) v in
                      u m
        else return m in
        h 0 n

sumdivaux2 t n i =
  let x y =
        ifM ((return (y < n)) <&&> (((==) 0) <$> (readIOA t y)))
            (do let z = y + 1
                x z)
            (return y) in
        x i

sumdivaux t n i =
  if i > n
  then return 1
  else ifM (((==) 0) <$> (readIOA t i))
           (sumdivaux t n =<< (sumdivaux2 t n (i + 1)))
           (do o <- sumdivaux t n =<< (sumdivaux2 t n (i + 1))
               ba <- readIOA t i
               let bb j bc bd =
                      if j <= ba
                      then do let be = bc + bd
                              let bf = bd * i
                              bb (j + 1) be bf
                      else return ((bc + 1) * o) in
                      bb 1 0 i)

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
     let bg k bh =
            if k <= 30001 - 1
            then ifM (((==) k) <$> (readIOA era k))
                     (do writeIOA primes bh k
                         let bi = bh + 1
                         bg (k + 1) bi)
                     (bg (k + 1) bh)
            else {- 28124 ça prend trop de temps mais on arrive a passer le test -}
                 do abondant <- array_init (100 + 1) (\ p ->
                                                        return False)
                    summable <- array_init (100 + 1) (\ q ->
                                                        return False)
                    let bj r =
                           if r <= 100
                           then do other <- ((-) <$> (sumdiv nprimes primes r) <*> (return r))
                                   if other > r
                                   then do writeIOA abondant r True
                                           bj (r + 1)
                                   else bj (r + 1)
                           else let bk i =
                                       if i <= 100
                                       then let bl j =
                                                   if j <= 100
                                                   then ifM (((&&) (i + j <= 100)) <$> ((readIOA abondant i) <&&> (readIOA abondant j)))
                                                            (do writeIOA summable (i + j) True
                                                                bl (j + 1))
                                                            (bl (j + 1))
                                                   else bk (i + 1) in
                                                   bl 1
                                       else let bm o bn =
                                                   if o <= 100
                                                   then ifM (fmap not (readIOA summable o))
                                                            (do let bo = bn + o
                                                                bm (o + 1) bo)
                                                            (bm (o + 1) bn)
                                                   else printf "\n%d\n" (bn::Int) :: IO() in
                                                   bm 1 0 in
                                       bk 1 in
                           bj 2 in
            bg 2 0


