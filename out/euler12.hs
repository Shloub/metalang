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
max2_ a b =
  return (if a > b
          then a
          else b)

eratostene t max0 =
  let w i y =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let j = i * i
                     let z = y + 1
                     let x ba =
                           if ba < max0 && ba > 0
                           then do writeIOA t ba 0
                                   let bb = ba + i
                                   x bb
                           else w (i + 1) z in
                           x j)
                 (w (i + 1) y)
        else return y in
        w 2 0

fillPrimesFactors t n primes nprimes =
  let u i bc =
        if i <= nprimes - 1
        then do d <- readIOA primes i
                let v bd =
                      if (bd `rem` d) == 0
                      then do writeIOA t d =<< (((+) 1) <$> (readIOA t d))
                              let be = bd `quot` d
                              v be
                      else if bd == 1
                           then readIOA primes i
                           else u (i + 1) bd in
                      v bc
        else return bc in
        u 0 n

find ndiv2 =
  do era <- array_init 110 (\ j ->
                              return j)
     nprimes <- eratostene era 110
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let s k bf =
           if k <= 110 - 1
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes bf k
                        let bg = bf + 1
                        s (k + 1) bg)
                    (s (k + 1) bf)
           else let h n =
                      if n <= 10000
                      then do primesFactors <- array_init (n + 2) (\ m ->
                                                                     return 0)
                              max0 <- join $ max2_ <$> (fillPrimesFactors primesFactors n primes nprimes) <*> (fillPrimesFactors primesFactors (n + 1) primes nprimes)
                              writeIOA primesFactors 2 =<< ((-) <$> (readIOA primesFactors 2) <*> (return 1))
                              let r i bh =
                                    if i <= max0
                                    then ifM (((/=) 0) <$> (readIOA primesFactors i))
                                             (do bi <- (((*) bh) <$> (((+) 1) <$> (readIOA primesFactors i)))
                                                 r (i + 1) bi)
                                             (r (i + 1) bh)
                                    else if bh > ndiv2
                                         then return ((n * (n + 1)) `quot` 2)
                                         else {- print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" -}
                                              h (n + 1) in
                                    r 0 1
                      else return 0 in
                      h 1 in
           s 2 0

main =
  do printf "%d\n" =<< ((find 500)::IO Int)
     return ()


