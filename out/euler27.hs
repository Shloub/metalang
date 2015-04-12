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
             then let s = - n
                          in s
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
  let u n =
        if n <= 200
        then do let j = n * n + a * n + b
                ifM (fmap not (isPrime j primes len))
                    (return n)
                    (u (n + 1))
        else return 200 in
        u 0

main =
  do era <- array_init 1000 (\ j ->
                               return j)
     nprimes <- eratostene era 1000
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let v k w =
           if k <= 1000 - 1
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes w k
                        let x = w + 1
                        v (k + 1) x)
                    (v (k + 1) w)
           else do printf "%d == %d\n" (w::Int) (nprimes::Int) :: IO()
                   let y b z ba bb bc =
                         if b <= 999
                         then ifM (((==) b) <$> (readIOA era b))
                                  (let bd a be bf bg bh =
                                          if a <= 999
                                          then do n1 <- test a b primes nprimes
                                                  n2 <- test a (- b) primes nprimes
                                                  (\ (bi, bj, bk, bl) ->
                                                    if n2 > bj
                                                    then do let bm = - a * b
                                                            let bn = - b
                                                            bd (a + 1) a n2 bn bm
                                                    else bd (a + 1) bi bj bk bl) (if n1 > bf
                                                                                  then let bo = a * b
                                                                                                in (a, n1, b, bo)
                                                                                  else (be, bf, bg, bh))
                                          else y (b + 1) be bf bg bh in
                                          bd (- 999) z ba bb bc)
                                  (y (b + 1) z ba bb bc)
                         else printf "%d %d\n%d\n%d\n" (z::Int) (bb::Int) (ba::Int) (bc::Int) :: IO() in
                         y 3 0 0 0 0 in
           v 2 0


