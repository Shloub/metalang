import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False
(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

main :: IO ()
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f =
  do li <- g 0
     newListArray (0, len - 1) li
  where g i =
           if i == len
           then return []
           else do item <- f i
                   li <- g (i+1)
                   return (item:li)
                                                                                                                                 

eratostene t max0 =
  do let n = 0
     let g = max0 - 1
     let e i w =
           if i <= g
           then ifM (((==) i) <$> (readIOA t i))
                    (do let x = w + 1
                        let j = i * i
                        let f y =
                              if y < max0 && y > 0
                              then do writeIOA t y 0
                                      let z = y + i
                                      f z
                              else e (i + 1) x in
                              f j)
                    (e (i + 1) w)
           else return w in
           e 2 n

isPrime n primes len =
  do let i = 0
     let ba = if n < 0
              then let bb = - n
                            in bb
              else n
     let d bc =
           ifM (((>) ba) <$> ((*) <$> (readIOA primes bc) <*> (readIOA primes bc)))
               (ifM (((==) 0) <$> ((rem ba) <$> (readIOA primes bc)))
                    (return False)
                    (do let bd = bc + 1
                        d bd))
               (return True) in
           d i

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
  do let maximumprimes = 1000
     era <- array_init maximumprimes (\ j ->
                                       return j)
     let result = 0
     let max0 = 0
     nprimes <- eratostene era maximumprimes
     primes <- array_init nprimes (\ o ->
                                    return 0)
     let l = 0
     let v = maximumprimes - 1
     let u k be =
           if k <= v
           then ifM (((==) k) <$> (readIOA era k))
                    (do writeIOA primes be k
                        let bf = be + 1
                        u (k + 1) bf)
                    (u (k + 1) be)
           else do printf "%d" (be :: Int) :: IO ()
                   printf " == " :: IO ()
                   printf "%d" (nprimes :: Int) :: IO ()
                   printf "\n" :: IO ()
                   let ma = 0
                   let mb = 0
                   let r b bg bh bi bj =
                         if b <= 999
                         then ifM (((==) b) <$> (readIOA era b))
                                  (let s a bk bl bm bn =
                                         if a <= 999
                                         then do n1 <- test a b primes nprimes
                                                 n2 <- test a (- b) primes nprimes
                                                 (\ (bo, bp, bq, br) ->
                                                   if n2 > bp
                                                   then do let bs = n2
                                                           let bt = - a * b
                                                           let bu = a
                                                           let bv = - b
                                                           s (a + 1) bu bs bv bt
                                                   else s (a + 1) bo bp bq br) (if n1 > bl
                                                                                then let bw = n1
                                                                                              in let bx = a * b
                                                                                                          in let by = a
                                                                                                                      in let bz = b
                                                                                                                                  in (by, bw, bz, bx)
                                                                                else (bk, bl, bm, bn))
                                         else r (b + 1) bk bl bm bn in
                                         s (- 999) bg bh bi bj)
                                  (r (b + 1) bg bh bi bj)
                         else do printf "%d" (bg :: Int) :: IO ()
                                 printf " " :: IO ()
                                 printf "%d" (bi :: Int) :: IO ()
                                 printf "\n" :: IO ()
                                 printf "%d" (bh :: Int) :: IO ()
                                 printf "\n" :: IO ()
                                 printf "%d" (bj :: Int) :: IO ()
                                 printf "\n" :: IO () in
                         r 3 ma max0 mb result in
           u 2 l


