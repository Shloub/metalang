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
  let c i d =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let e = d + 1
                     let j = i * i
                     let f g =
                           if g < max0 && g > 0
                           then do writeIOA t g 0
                                   let h = g + i
                                   f h
                           else c (i + 1) e in
                           f j)
                 (c (i + 1) d)
        else return d in
        c 2 0

isPrime n primes len =
  do let m = if n < 0
             then - n
             else n
     let p q =
           ifM (((>) m) <$> ((*) <$> (readIOA primes q) <*> (readIOA primes q)))
               (ifM (((==) 0) <$> ((rem m) <$> (readIOA primes q)))
                    (return False)
                    (do let r = q + 1
                        p r))
               (return True) in
           p 0

test a b primes len =
  let s n =
        if n <= 200
        then do let j = n * n + a * n + b
                ifM (fmap not (isPrime j primes len))
                    (return n)
                    (s (n + 1))
        else return 200 in
        s 0

main =
  do era <- array_init 1000 (\ j ->
                               return j)
     nprimes <- eratostene era 1000
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let u k v =
           if k <= 1000 - 1
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes v k
                        let w = v + 1
                        u (k + 1) w)
                    (u (k + 1) v)
           else do printf "%d == %d\n" (v::Int) (nprimes::Int) :: IO()
                   let x b y z ba bb =
                         if b <= 999
                         then ifM (((==) b) <$> (readIOA era b))
                                  (let bc a bd be bf bg =
                                          if a <= 999
                                          then do n1 <- test a b primes nprimes
                                                  n2 <- test a (- b) primes nprimes
                                                  (\ (bh, bi, bj, bk) ->
                                                    if n2 > bi
                                                    then do let bl = - a * b
                                                            let bm = - b
                                                            bc (a + 1) a n2 bm bl
                                                    else bc (a + 1) bh bi bj bk) (if n1 > be
                                                                                  then let bn = a * b
                                                                                                in (a, n1, b, bn)
                                                                                  else (bd, be, bf, bg))
                                          else x (b + 1) bd be bf bg in
                                          bc (- 999) y z ba bb)
                                  (x (b + 1) y z ba bb)
                         else printf "%d %d\n%d\n%d\n" (y::Int) (ba::Int) (z::Int) (bb::Int) :: IO() in
                         x 3 0 0 0 0 in
           u 2 0


