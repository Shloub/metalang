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



min2_ a b =
  return ((if (a < b)
          then a
          else b))
eratostene t max0 =
  do let n = 0
     let e = (max0 - 1)
     let c i w =
           (if (i <= e)
           then ifM (((==) <$> (readIOA t i) <*> return (i)))
                    (do let x = (w + 1)
                        (if ((max0 `quot` i) > i)
                        then do let j = (i * i)
                                let d y =
                                      (if ((y < max0) && (y > 0))
                                      then do writeIOA t y 0
                                              let z = (y + i)
                                              (d z)
                                      else (c (i + 1) x)) in
                                      (d j)
                        else (c (i + 1) x)))
                    ((c (i + 1) w))
           else return (w)) in
           (c 2 n)
main =
  do let maximumprimes = 1000001
     ((\ (g, era) ->
        do return (g)
           nprimes <- (eratostene era maximumprimes)
           ((\ (m, primes) ->
              do return (m)
                 let l = 0
                 let v = (maximumprimes - 1)
                 let u k ba =
                       (if (k <= v)
                       then ifM (((==) <$> (readIOA era k) <*> return (k)))
                                (do writeIOA primes ba k
                                    let bb = (ba + 1)
                                    (u (k + 1) bb))
                                ((u (k + 1) ba))
                       else do printf "%d" (ba :: Int)::IO()
                               printf " == " ::IO()
                               printf "%d" (nprimes :: Int)::IO()
                               printf "\n" ::IO()
                               ((\ (q, sum) ->
                                  do return (q)
                                     let maxl = 0
                                     let process = True
                                     let stop = (maximumprimes - 1)
                                     let len = 1
                                     let resp = 1
                                     let r bc bd be bf bg =
                                           (if be
                                           then do let bh = False
                                                   let s i bi bj bk bl =
                                                         (if (i <= bl)
                                                         then (if ((i + bc) < nprimes)
                                                              then do writeIOA sum i =<< ((+) <$> (readIOA sum i) <*> (readIOA primes (i + bc)))
                                                                      ifM ((((>) maximumprimes) <$> (readIOA sum i)))
                                                                          (do let bm = True
                                                                              ifM (((==) <$> join (readIOA era <$> (readIOA sum i)) <*> (readIOA sum i)))
                                                                                  (do let bn = bc
                                                                                      bo <- (readIOA sum i)
                                                                                      (s (i + 1) bn bm bo bl))
                                                                                  ((s (i + 1) bi bm bk bl)))
                                                                          (do bp <- (min2_ bl i)
                                                                              (s (i + 1) bi bj bk bp))
                                                              else (s (i + 1) bi bj bk bl))
                                                         else do let bq = (bc + 1)
                                                                 (r bq bi bj bk bl)) in
                                                         (s 0 bd bh bf bg)
                                           else do printf "%d" (bf :: Int)::IO()
                                                   printf "\n" ::IO()
                                                   printf "%d" (bd :: Int)::IO()
                                                   printf "\n" ::IO()) in
                                           (r len maxl process resp stop)) =<< (array_init_withenv nprimes (\ i_ () ->
                                                                                                             do p <- (readIOA primes i_)
                                                                                                                return (((), p))) ()))) in
                       (u 2 l)) =<< (array_init_withenv nprimes (\ o () ->
                                                                  let h = 0
                                                                          in return (((), h))) ()))) =<< (array_init_withenv maximumprimes (\ j () ->
                                                                                                                                             let f = j
                                                                                                                                                     in return (((), f))) ()))

