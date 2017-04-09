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
     let d e f g =
           if e /= 1
           then let h i j k l m =
                      if j <= m
                      then (\ (p, q, r, s, t) ->
                             do let u = q + 1
                                h p u r s t) (if (i `rem` j) == 0
                                              then let n = i `quot` j
                                                           in let o = ((floor . sqrt . fromIntegral) n)
                                                                      in (n, n, j, True, o)
                                              else (i, j, k, l, m))
                      else if not l
                           then do printf "%d\n" (i::Int) :: IO()
                                   d 1 k m
                           else d i k m in
                      h e f f False g
           else return () in
           d 408464633 2 sqrtia


