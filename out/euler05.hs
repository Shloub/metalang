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



max2_ a b =
  let g () = ()
             in return ((if (a > b)
                        then a
                        else b))
primesfactors n =
  ((\ (e, tab) ->
     do return (e)
        let d = 2
        let f bd be =
              (if ((be /= 1) && ((bd * bd) <= be))
              then ((\ (bf, bg) ->
                      (f bf bg)) =<< (if ((be `rem` bd) == 0)
                                     then do writeIOA tab bd =<< ((+) <$> (readIOA tab bd) <*> return (1))
                                             let bh = (be `quot` bd)
                                             return ((bd, bh))
                                     else let bi = (bd + 1)
                                                   in return ((bi, be))))
              else do writeIOA tab be =<< ((+) <$> (readIOA tab be) <*> return (1))
                      return (tab)) in
              (f d n)) =<< (array_init_withenv (n + 1) (\ i () ->
                                                         let c = 0
                                                                 in return (((), c))) ()))
main =
  do let lim = 20
     ((\ (p, o) ->
        do return (p)
           let bb = 1
           let bc = lim
           let x i =
                 (if (i <= bc)
                 then do t <- (primesfactors i)
                         let z = 1
                         let ba = i
                         let y j =
                               (if (j <= ba)
                               then do writeIOA o j =<< (join (max2_ <$> (readIOA o j) <*> (readIOA t j)))
                                       (y (j + 1))
                               else (x (i + 1))) in
                               (y z)
                 else do let product = 1
                         let v = 1
                         let w = lim
                         let q k bj =
                               (if (k <= w)
                               then do let s = 1
                                       u <- (readIOA o k)
                                       let r l bk =
                                             (if (l <= u)
                                             then do let bl = (bk * k)
                                                     (r (l + 1) bl)
                                             else (q (k + 1) bk)) in
                                             (r s bj)
                               else do printf "%d" (bj :: Int)::IO()
                                       printf "\n" ::IO()) in
                               (q v product)) in
                 (x bb)) =<< (array_init_withenv (lim + 1) (\ m () ->
                                                             let h = 0
                                                                     in return (((), h))) ()))

