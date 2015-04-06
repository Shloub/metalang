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
                let q r =
                      if (r `rem` d) == 0
                      then do writeIOA t d =<< (((+) 1) <$> (readIOA t d))
                              let s = r `quot` d
                              q s
                      else if r == 1
                           then readIOA primes i
                           else h (i + 1) r in
                      q m
        else return m in
        h 0 n

sumdivaux2 t n i =
  let u v =
        ifM ((return (v < n)) <&&> (((==) 0) <$> (readIOA t v)))
            (do let w = v + 1
                u w)
            (return v) in
        u i

sumdivaux t n i =
  if i > n
  then return 1
  else ifM (((==) 0) <$> (readIOA t i))
           (sumdivaux t n =<< (sumdivaux2 t n (i + 1)))
           (do o <- sumdivaux t n =<< (sumdivaux2 t n (i + 1))
               x <- readIOA t i
               let y j z ba =
                     if j <= x
                     then do let bb = z + ba
                             let bc = ba * i
                             y (j + 1) bb bc
                     else return ((z + 1) * o) in
                     y 1 0 i)

sumdiv nprimes primes n =
  do t <- array_init (n + 1) (\ i ->
                                return 0)
     max0 <- fillPrimesFactors t n primes nprimes
     sumdivaux t max0 0

main =
  do era <- array_init 1001 (\ j ->
                               return j)
     nprimes <- eratostene era 1001
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let bd k be =
            if k <= 1001 - 1
            then ifM (((==) k) <$> (readIOA era k))
                     (do writeIOA primes be k
                         let bf = be + 1
                         bd (k + 1) bf)
                     (bd (k + 1) be)
            else do printf "%d == %d\n" (be::Int) (nprimes::Int) :: IO()
                    let bg n bh =
                           if n <= 1000
                           then do other <- ((-) <$> (sumdiv nprimes primes n) <*> (return n))
                                   if other > n
                                   then do othersum <- ((-) <$> (sumdiv nprimes primes other) <*> (return other))
                                           if othersum == n
                                           then do printf "%d & %d\n" (other::Int) (n::Int) :: IO()
                                                   let bi = bh + other + n
                                                   bg (n + 1) bi
                                           else bg (n + 1) bh
                                   else bg (n + 1) bh
                           else printf "\n%d\n" (bh::Int) :: IO() in
                           bg 2 0 in
            bd 2 0


