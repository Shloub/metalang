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
  let e i u =
        if i <= max0 - 1
        then ifM (((==) i) <$> (readIOA t i))
                 (do let v = u + 1
                     let j = i * i
                     let f w =
                           if w < max0 && w > 0
                           then do writeIOA t w 0
                                   let x = w + i
                                   f x
                           else e (i + 1) v in
                           f j)
                 (e (i + 1) u)
        else return u in
        e 2 0

isPrime n primes len =
  do let y = if n < 0
             then let z = - n
                          in z
             else n
     let d ba =
           ifM (((>) y) <$> ((*) <$> (readIOA primes ba) <*> (readIOA primes ba)))
               (ifM (((==) 0) <$> ((rem y) <$> (readIOA primes ba)))
                    (return False)
                    (do let bb = ba + 1
                        d bb))
               (return True) in
           d 0

test a b primes len =
  let c n =
        if n <= 200
        then do let j = n * n + a * n + b
                ifM (fmap not (isPrime j primes len))
                    (return n)
                    (c (n + 1))
        else return 200 in
        c 0

main =
  do era <- array_init 1000 (\ j ->
                               return j)
     nprimes <- eratostene era 1000
     primes <- array_init nprimes (\ o ->
                                     return 0)
     let s k bc =
           if k <= 1000 - 1
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes bc k
                        let bd = bc + 1
                        s (k + 1) bd)
                    (s (k + 1) bc)
           else do printf "%d == %d\n" (bc::Int) (nprimes::Int) :: IO()
                   let q b be bf bg bh =
                         if b <= 999
                         then ifM (((==) b) <$> (readIOA era b))
                                  (let r a bi bj bk bl =
                                         if a <= 999
                                         then do n1 <- test a b primes nprimes
                                                 n2 <- test a (- b) primes nprimes
                                                 (\ (bm, bn, bo, bp) ->
                                                   if n2 > bn
                                                   then do let br = - a * b
                                                           let bt = - b
                                                           r (a + 1) a n2 bt br
                                                   else r (a + 1) bm bn bo bp) (if n1 > bj
                                                                                then let bv = a * b
                                                                                              in (a, n1, b, bv)
                                                                                else (bi, bj, bk, bl))
                                         else q (b + 1) bi bj bk bl in
                                         r (- 999) be bf bg bh)
                                  (q (b + 1) be bf bg bh)
                         else printf "%d %d\n%d\n%d\n" (be::Int) (bg::Int) (bf::Int) (bh::Int) :: IO() in
                         q 3 0 0 0 0 in
           s 2 0


