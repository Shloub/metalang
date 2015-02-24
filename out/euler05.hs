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
  return ((if (a > b)
          then a
          else b))

primesfactors n =
  ((\ (e, tab) ->
     do let d = 2
        let f v w =
              (if ((w /= 1) && ((v * v) <= w))
              then (if ((w `rem` v) == 0)
                   then do writeIOA tab v =<< ((+) <$> (readIOA tab v) <*> return (1))
                           let x = (w `quot` v)
                           (f v x)
                   else do let y = (v + 1)
                           (f y w))
              else do writeIOA tab w =<< ((+) <$> (readIOA tab w) <*> return (1))
                      return (tab)) in
              (f d n)) =<< (array_init_withenv (n + 1) (\ i e ->
                                                         let c = 0
                                                                 in return (((), c))) ()))

main =
  do let lim = 20
     ((\ (h, o) ->
        let s i =
              (if (i <= lim)
              then do t <- (primesfactors i)
                      let u j =
                            (if (j <= i)
                            then do writeIOA o j =<< (join (max2_ <$> (readIOA o j) <*> (readIOA t j)))
                                    (u (j + 1))
                            else (s (i + 1))) in
                            (u 1)
              else do let product = 1
                      let p k z =
                            (if (k <= lim)
                            then do r <- (readIOA o k)
                                    let q l ba =
                                          (if (l <= r)
                                          then do let bb = (ba * k)
                                                  (q (l + 1) bb)
                                          else (p (k + 1) ba)) in
                                          (q 1 z)
                            else do printf "%d" (z :: Int)::IO()
                                    printf "\n" ::IO()) in
                            (p 1 product)) in
              (s 1)) =<< (array_init_withenv (lim + 1) (\ m h ->
                                                         let g = 0
                                                                 in return (((), g))) ()))


