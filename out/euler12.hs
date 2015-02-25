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
                                                                                                                                                                                                                                                                         

max2_ a b =
  return (if a > b
          then a
          else b)

eratostene t max0 =
  do let n = 0
     let ba = max0 - 1
     let y i bb =
           if i <= ba
           then ifM (((==) i) <$> (readIOA t i))
                    (do let j = i * i
                        let bc = bb + 1
                        let z bd =
                              if bd < max0 && bd > 0
                              then do (writeIOA t bd 0)
                                      let be = bd + i
                                      (z be)
                              else (y (i + 1) bc) in
                              (z j))
                    (y (i + 1) bb)
           else return bb in
           (y 2 n)

fillPrimesFactors t n primes nprimes =
  do let x = nprimes - 1
     let v i bf =
           if i <= x
           then do d <- (readIOA primes i)
                   let w bg =
                         if (bg `rem` d) == 0
                         then do (writeIOA t d =<< (((+) 1) <$> (readIOA t d)))
                                 let bh = bg `quot` d
                                 (w bh)
                         else if bg == 1
                              then (readIOA primes i)
                              else (v (i + 1) bg) in
                         (w bf)
           else return bf in
           (v 0 n)

find ndiv2 =
  do let maximumprimes = 110
     ((array_init_withenv maximumprimes (\ j e ->
                                          let c = j
                                                  in return ((), c)) ()) >>= (\ (e, era) ->
                                                                               do nprimes <- (eratostene era maximumprimes)
                                                                                  ((array_init_withenv nprimes (\ o g ->
                                                                                                                 let f = 0
                                                                                                                         in return ((), f)) ()) >>= (\ (g, primes) ->
                                                                                                                                                      do let l = 0
                                                                                                                                                         let u = maximumprimes - 1
                                                                                                                                                         let s k bi =
                                                                                                                                                               if k <= u
                                                                                                                                                               then ifM (((==) k) <$> (readIOA era k))
                                                                                                                                                                        (do (writeIOA primes bi k)
                                                                                                                                                                            let bj = bi + 1
                                                                                                                                                                            (s (k + 1) bj))
                                                                                                                                                                        (s (k + 1) bi)
                                                                                                                                                               else let h n =
                                                                                                                                                                          if n <= 10000
                                                                                                                                                                          then ((array_init_withenv (n + 2) (\ m q ->
                                                                                                                                                                                                              let p = 0
                                                                                                                                                                                                                      in return ((), p)) ()) >>= (\ (q, primesFactors) ->
                                                                                                                                                                                                                                                   do max0 <- (join $ max2_ <$> (fillPrimesFactors primesFactors n primes nprimes) <*> (fillPrimesFactors primesFactors (n + 1) primes nprimes))
                                                                                                                                                                                                                                                      (writeIOA primesFactors 2 =<< ((-) <$> (readIOA primesFactors 2) <*> return 1))
                                                                                                                                                                                                                                                      let ndivs = 1
                                                                                                                                                                                                                                                      let r i bk =
                                                                                                                                                                                                                                                            if i <= max0
                                                                                                                                                                                                                                                            then ifM (((/=) 0) <$> (readIOA primesFactors i))
                                                                                                                                                                                                                                                                     (do bl <- (((*) bk) <$> (((+) 1) <$> (readIOA primesFactors i)))
                                                                                                                                                                                                                                                                         (r (i + 1) bl))
                                                                                                                                                                                                                                                                     (r (i + 1) bk)
                                                                                                                                                                                                                                                            else if bk > ndiv2
                                                                                                                                                                                                                                                                 then return ((n * (n + 1)) `quot` 2)
                                                                                                                                                                                                                                                                 else {- print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" -}
                                                                                                                                                                                                                                                                      (h (n + 1)) in
                                                                                                                                                                                                                                                            (r 0 ndivs)))
                                                                                                                                                                          else return 0 in
                                                                                                                                                                          (h 1) in
                                                                                                                                                               (s 2 l)))))

main =
  do printf "%d" =<< ((find 500) :: IO Int)
     printf "\n" :: IO ()
     return ()


