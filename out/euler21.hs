import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False

(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b


main :: IO ()

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

skip_whitespaces :: IO ()
skip_whitespaces =
  ifM (hIsEOF stdin)
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do hGetChar stdin
              skip_whitespaces
           else return ())

read_int_a :: Int -> IO Int
read_int_a b =
  ifM (hIsEOF stdin)
      (return b)
      (do c <- hLookAhead stdin
          if c >= '0' && c <= '9' then
           do hGetChar stdin
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      num <- read_int_a 0
      return (num * sign)


array_init_withenv :: Int -> ( Int -> env -> IO(env, tabcontent)) -> env -> IO(env, IOArray Int tabcontent)
array_init_withenv len f env =
  do (env, li) <- g 0 env
     o <- newListArray (0, len - 1) li
     return (env, o)
  where g i env =
           if i == len
           then return (env, [])
           else do (env', item) <- f i env
                   (env'', li) <- g (i+1) env'
                   return (env'', item:li)



eratostene t max0 =
  do let n = 0
     let x = 2
     let y = (max0 - 1)
     let v i bj =
           (if (i <= y)
           then do bk <- ifM (((==) <$> (readIOA t i) <*> return (i)))
                             (do let bl = (bj + 1)
                                 let j = (i * i)
                                 let w bm =
                                       (if ((bm < max0) && (bm > 0))
                                       then do writeIOA t bm 0
                                               let bn = (bm + i)
                                               (w bn)
                                       else return (bl)) in
                                       (w j))
                             (return (bj))
                   (v (i + 1) bk)
           else return (bj)) in
           (v x n)
fillPrimesFactors t n primes nprimes =
  do let s = 0
     let u = (nprimes - 1)
     let q i bo =
           (if (i <= u)
           then do d <- (readIOA primes i)
                   let r bp =
                         (if ((bp `rem` d) == 0)
                         then do writeIOA t d =<< ((+) <$> (readIOA t d) <*> return (1))
                                 let bq = (bp `quot` d)
                                 (r bq)
                         else (if (bp == 1)
                              then (readIOA primes i)
                              else (q (i + 1) bp))) in
                         (r bo)
           else return (bo)) in
           (q s n)
sumdivaux2 t n i =
  let m br =
        ifM ((return ((br < n)) <&&> ((==) <$> (readIOA t br) <*> return (0))))
            (do let bs = (br + 1)
                (m bs))
            (return (br)) in
        (m i)
sumdivaux t n i =
  do let c () = return (())
     (if (i > n)
     then return (1)
     else do let e () = (c ())
             ifM (((==) <$> (readIOA t i) <*> return (0)))
                 ((sumdivaux t n =<< (sumdivaux2 t n (i + 1))))
                 (do o <- (sumdivaux t n =<< (sumdivaux2 t n (i + 1)))
                     let out0 = 0
                     let p = i
                     let g = 1
                     h <- (readIOA t i)
                     let f j bt bu =
                           (if (j <= h)
                           then do let bv = (bt + bu)
                                   let bw = (bu * i)
                                   (f (j + 1) bv bw)
                           else return (((bt + 1) * o))) in
                           (f g out0 p)))
sumdiv nprimes primes n =
  ((\ (b, t) ->
     do return (b)
        max0 <- (fillPrimesFactors t n primes nprimes)
        (sumdivaux t max0 0)) =<< (array_init_withenv (n + 1) (\ i () ->
                                                                let a = 0
                                                                        in return (((), a))) ()))
main =
  do let maximumprimes = 1001
     ((\ (ba, era) ->
        do return (ba)
           nprimes <- (eratostene era maximumprimes)
           ((\ (bc, primes) ->
              do return (bc)
                 let l = 0
                 let bh = 2
                 let bi = (maximumprimes - 1)
                 let bg k bx =
                        (if (k <= bi)
                        then do by <- ifM (((==) <$> (readIOA era k) <*> return (k)))
                                          (do writeIOA primes bx k
                                              let bz = (bx + 1)
                                              return (bz))
                                          (return (bx))
                                (bg (k + 1) by)
                        else do printf "%d" (bx :: Int)::IO()
                                printf " == " ::IO()
                                printf "%d" (nprimes :: Int)::IO()
                                printf "\n" ::IO()
                                let sum = 0
                                let be = 2
                                let bf = 1000
                                let bd n ca =
                                       (if (n <= bf)
                                       then do other <- ((-) <$> (sumdiv nprimes primes n) <*> return (n))
                                               cb <- (if (other > n)
                                                     then do othersum <- ((-) <$> (sumdiv nprimes primes other) <*> return (other))
                                                             cc <- (if (othersum == n)
                                                                   then do printf "%d" (other :: Int)::IO()
                                                                           printf " & " ::IO()
                                                                           printf "%d" (n :: Int)::IO()
                                                                           printf "\n" ::IO()
                                                                           let cd = (ca + (other + n))
                                                                           return (cd)
                                                                   else return (ca))
                                                             return (cc)
                                                     else return (ca))
                                               (bd (n + 1) cb)
                                       else do printf "\n" ::IO()
                                               printf "%d" (ca :: Int)::IO()
                                               printf "\n" ::IO()) in
                                       (bd be sum)) in
                        (bg bh l)) =<< (array_init_withenv nprimes (\ o () ->
                                                                     let bb = 0
                                                                              in return (((), bb))) ()))) =<< (array_init_withenv maximumprimes (\ j () ->
                                                                                                                                                  let z = j
                                                                                                                                                          in return (((), z))) ()))

