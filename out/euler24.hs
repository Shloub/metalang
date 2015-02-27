import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

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
                                                                                                                                 

fact n =
  do let prod = 1
     let q i r =
           if i <= n
           then do let s = r * i
                   q (i + 1) s
           else return r in
           q 2 prod

show0 lim nth =
  do t <- array_init lim (\ i ->
                           return i)
     pris <- array_init lim (\ j ->
                              return False)
     let p = lim - 1
     let g k u =
           if k <= p
           then do n <- fact (lim - k)
                   let nchiffre = u `quot` n
                   let v = u `rem` n
                   let o = lim - 1
                   let h l w =
                         if l <= o
                         then ifM (fmap not (readIOA pris l))
                                  (do if w == 0
                                      then do printf "%d" (l :: Int) :: IO ()
                                              writeIOA pris l True
                                      else return ()
                                      let x = w - 1
                                      h (l + 1) x)
                                  (h (l + 1) w)
                         else g (k + 1) v in
                         h 0 nchiffre
           else do let f = lim - 1
                   let e m =
                         if m <= f
                         then ifM (fmap not (readIOA pris m))
                                  (do printf "%d" (m :: Int) :: IO ()
                                      e (m + 1))
                                  (e (m + 1))
                         else printf "\n" :: IO () in
                         e 0 in
           g 1 nth

main =
  do show0 10 999999
     return ()


