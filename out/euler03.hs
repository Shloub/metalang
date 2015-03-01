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
  do let maximum = 1
     let b0 = 2
     let a = 408464633
     let sqrtia = ((floor . sqrt . fromIntegral) a)
     let d f g h =
           if f /= 1
           then do let b = g
                   let found = False
                   let e i j k l m =
                         if j <= m
                         then (\ (n, o, p, q, r) ->
                                do let s = o + 1
                                   e n s p q r) (if (i `rem` j) == 0
                                                 then let t = i `quot` j
                                                              in let u = j
                                                                         in let v = t
                                                                                    in let w = ((floor . sqrt . fromIntegral) t)
                                                                                               in let x = True
                                                                                                          in (t, v, u, x, w)
                                                 else (i, j, k, l, m))
                         else if not l
                              then do printf "%d\n" (i::Int) :: IO()
                                      let y = 1
                                      d y k m
                              else d i k m in
                         e f b g found h
           else return () in
           d a b0 sqrtia


