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
  let c i e =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let j = i * i
                     let f = e + 1
                     let g h =
                           if h < max0 && h > 0
                           then do writeIOA t h 0
                                   let p = h + i
                                   g p
                           else c (i + 1) f in
                           g j)
                 (c (i + 1) e)
        else return e in
        c 2 0

fillPrimesFactors t n primes nprimes =
  let q i r =
        if i <= nprimes - 1
        then do d <- readIOA primes i
                let s u =
                      if (u `rem` d) == 0
                      then do writeIOA t d =<< (((+) 1) <$> (readIOA t d))
                              let v = u `quot` d
                              s v
                      else if u == 1
                           then readIOA primes i
                           else q (i + 1) u in
                      s r
        else return r in
        q 0 n

find ndiv2 =
  do era <- array_init 110 (\ j ->
                              return j)
     nprimes <- eratostene era 110
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let w k x =
           if k <= 110 - 1
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes x k
                        let bc = x + 1
                        w (k + 1) bc)
                    (w (k + 1) x)
           else let y n =
                      if n <= 10000
                      then do primesFactors <- array_init (n + 2) (\ m ->
                                                                     return 0)
                              max0 <- ((max <$> (fillPrimesFactors primesFactors n primes nprimes) <*> (fillPrimesFactors primesFactors (n + 1) primes nprimes)))
                              writeIOA primesFactors 2 =<< ((-) <$> (readIOA primesFactors 2) <*> (return 1))
                              let z i ba =
                                    if i <= max0
                                    then ifM (((/=) 0) <$> (readIOA primesFactors i))
                                             (do bb <- (((*) ba) <$> (((+) 1) <$> (readIOA primesFactors i)))
                                                 z (i + 1) bb)
                                             (z (i + 1) ba)
                                    else if ba > ndiv2
                                         then return ((n * (n + 1)) `quot` 2)
                                         else {- print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" -}
                                              y (n + 1) in
                                    z 0 1
                      else return 0 in
                      y 1 in
           w 2 0

main =
  printf "%d\n" =<< ((find 500)::IO Int)


