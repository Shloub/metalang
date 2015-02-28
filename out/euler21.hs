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
  do let n = 0
     let s = max0 - 1
     let q i bb =
           if i <= s
           then ifM (((==) i) <$> (readIOA t i))
                    (do let bc = bb + 1
                        let j = i * i
                        let r bd =
                              if bd < max0 && bd > 0
                              then do writeIOA t bd 0
                                      let be = bd + i
                                      r be
                              else q (i + 1) bc in
                              r j)
                    (q (i + 1) bb)
           else return bb in
           q 2 n

fillPrimesFactors t n primes nprimes =
  do let m = nprimes - 1
     let g i bf =
           if i <= m
           then do d <- readIOA primes i
                   let h bg =
                         if (bg `rem` d) == 0
                         then do writeIOA t d =<< (((+) 1) <$> (readIOA t d))
                                 let bh = bg `quot` d
                                 h bh
                         else if bg == 1
                              then readIOA primes i
                              else g (i + 1) bg in
                         h bf
           else return bf in
           g 0 n

sumdivaux2 t n i =
  let f bi =
        ifM ((return (bi < n)) <&&> (((==) 0) <$> (readIOA t bi)))
            (do let bj = bi + 1
                f bj)
            (return bi) in
        f i

sumdivaux t n i =
  if i > n
  then return 1
  else ifM (((==) 0) <$> (readIOA t i))
           (sumdivaux t n =<< (sumdivaux2 t n (i + 1)))
           (do o <- sumdivaux t n =<< (sumdivaux2 t n (i + 1))
               let out0 = 0
               let p = i
               e <- readIOA t i
               let c j bk bl =
                     if j <= e
                     then do let bm = bk + bl
                             let bn = bl * i
                             c (j + 1) bm bn
                     else return ((bk + 1) * o) in
                     c 1 out0 p)

sumdiv nprimes primes n =
  do t <- array_init (n + 1) (\ i ->
                               return 0)
     max0 <- fillPrimesFactors t n primes nprimes
     sumdivaux t max0 0

main =
  do let maximumprimes = 1001
     era <- array_init maximumprimes (\ j ->
                                       return j)
     nprimes <- eratostene era maximumprimes
     primes <- array_init nprimes (\ o ->
                                    return 0)
     let l = 0
     let ba = maximumprimes - 1
     let z k bo =
           if k <= ba
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes bo k
                        let bp = bo + 1
                        z (k + 1) bp)
                    (z (k + 1) bo)
           else do printf "%d" (bo :: Int) :: IO ()
                   printf " == " :: IO ()
                   printf "%d" (nprimes :: Int) :: IO ()
                   printf "\n" :: IO ()
                   let sum = 0
                   let y n bq =
                         if n <= 1000
                         then do other <- ((-) <$> (sumdiv nprimes primes n) <*> (return n))
                                 if other > n
                                 then do othersum <- ((-) <$> (sumdiv nprimes primes other) <*> (return other))
                                         if othersum == n
                                         then do printf "%d" (other :: Int) :: IO ()
                                                 printf " & " :: IO ()
                                                 printf "%d" (n :: Int) :: IO ()
                                                 printf "\n" :: IO ()
                                                 let br = bq + other + n
                                                 y (n + 1) br
                                         else y (n + 1) bq
                                 else y (n + 1) bq
                         else do printf "\n" :: IO ()
                                 printf "%d" (bq :: Int) :: IO ()
                                 printf "\n" :: IO () in
                         y 2 sum in
           z 2 l


