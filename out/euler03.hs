import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e

main :: IO ()

main =
  do let sqrtia = ((floor . sqrt . fromIntegral) 408464633)
     let d f g h =
           if f /= 1
           then let e i j k l m =
                      if j <= m
                      then (\ (n, o, p, q, r) ->
                             do let s = o + 1
                                e n s p q r) (if (i `rem` j) == 0
                                              then let t = i `quot` j
                                                           in let w = ((floor . sqrt . fromIntegral) t)
                                                                      in (t, t, j, True, w)
                                              else (i, j, k, l, m))
                      else if not l
                           then do printf "%d\n" (i::Int) :: IO()
                                   d 1 k m
                           else d i k m in
                      e f g g False h
           else return () in
           d 408464633 2 sqrtia


