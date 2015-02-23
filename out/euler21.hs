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
     let s = (max0 - 1)
     let q i bb =
           (if (i <= s)
           then ifM (((==) <$> (readIOA t i) <*> return (i)))
                    (do let bc = (bb + 1)
                        let j = (i * i)
                        let r bd =
                              (if ((bd < max0) && (bd > 0))
                              then do writeIOA t bd 0
                                      let be = (bd + i)
                                      (r be)
                              else (q (i + 1) bc)) in
                              (r j))
                    ((q (i + 1) bb))
           else return (bb)) in
           (q 2 n)
fillPrimesFactors t n primes nprimes =
  do let m = (nprimes - 1)
     let g i bf =
           (if (i <= m)
           then do d <- (readIOA primes i)
                   let h bg =
                         (if ((bg `rem` d) == 0)
                         then do writeIOA t d =<< ((+) <$> (readIOA t d) <*> return (1))
                                 let bh = (bg `quot` d)
                                 (h bh)
                         else (if (bg == 1)
                              then (readIOA primes i)
                              else (g (i + 1) bg))) in
                         (h bf)
           else return (bf)) in
           (g 0 n)
sumdivaux2 t n i =
  let f bi =
        ifM ((return ((bi < n)) <&&> ((==) <$> (readIOA t bi) <*> return (0))))
            (do let bj = (bi + 1)
                (f bj))
            (return (bi)) in
        (f i)
sumdivaux t n i =
  (if (i > n)
  then return (1)
  else ifM (((==) <$> (readIOA t i) <*> return (0)))
           ((sumdivaux t n =<< (sumdivaux2 t n (i + 1))))
           (do o <- (sumdivaux t n =<< (sumdivaux2 t n (i + 1)))
               let out0 = 0
               let p = i
               e <- (readIOA t i)
               let c j bk bl =
                     (if (j <= e)
                     then do let bm = (bk + bl)
                             let bn = (bl * i)
                             (c (j + 1) bm bn)
                     else return (((bk + 1) * o))) in
                     (c 1 out0 p)))
sumdiv nprimes primes n =
  ((\ (b, t) ->
     do return (b)
        max0 <- (fillPrimesFactors t n primes nprimes)
        (sumdivaux t max0 0)) =<< (array_init_withenv (n + 1) (\ i () ->
                                                                let a = 0
                                                                        in return (((), a))) ()))
main =
  do let maximumprimes = 1001
     ((\ (v, era) ->
        do return (v)
           nprimes <- (eratostene era maximumprimes)
           ((\ (x, primes) ->
              do return (x)
                 let l = 0
                 let ba = (maximumprimes - 1)
                 let z k bo =
                       (if (k <= ba)
                       then ifM (((==) <$> (readIOA era k) <*> return (k)))
                                (do writeIOA primes bo k
                                    let bp = (bo + 1)
                                    (z (k + 1) bp))
                                ((z (k + 1) bo))
                       else do printf "%d" (bo :: Int)::IO()
                               printf " == " ::IO()
                               printf "%d" (nprimes :: Int)::IO()
                               printf "\n" ::IO()
                               let sum = 0
                               let y n bq =
                                     (if (n <= 1000)
                                     then do other <- ((-) <$> (sumdiv nprimes primes n) <*> return (n))
                                             (if (other > n)
                                             then do othersum <- ((-) <$> (sumdiv nprimes primes other) <*> return (other))
                                                     (if (othersum == n)
                                                     then do printf "%d" (other :: Int)::IO()
                                                             printf " & " ::IO()
                                                             printf "%d" (n :: Int)::IO()
                                                             printf "\n" ::IO()
                                                             let br = (bq + (other + n))
                                                             (y (n + 1) br)
                                                     else (y (n + 1) bq))
                                             else (y (n + 1) bq))
                                     else do printf "\n" ::IO()
                                             printf "%d" (bq :: Int)::IO()
                                             printf "\n" ::IO()) in
                                     (y 2 sum)) in
                       (z 2 l)) =<< (array_init_withenv nprimes (\ o () ->
                                                                  let w = 0
                                                                          in return (((), w))) ()))) =<< (array_init_withenv maximumprimes (\ j () ->
                                                                                                                                             let u = j
                                                                                                                                                     in return (((), u))) ()))

