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




main =
  do let maximum = 1
     let b0 = 2
     let a = 408464633
     sqrtia <- ((fmap (floor . sqrt . fromIntegral) (return a)))
     let d f g h =
           (if (f /= 1)
           then do let b = g
                   let found = False
                   let e i j k l m =
                         (if (j <= m)
                         then ((if ((i `rem` j) == 0)
                               then do let t = (i `quot` j)
                                       let u = j
                                       let v = t
                                       w <- ((fmap (floor . sqrt . fromIntegral) (return t)))
                                       let x = True
                                       return (t, v, u, x, w)
                               else return (i, j, k, l, m)) >>= (\ (n, o, p, q, r) ->
                                                                  do let s = (o + 1)
                                                                     (e n s p q r)))
                         else (if (not l)
                              then do printf "%d" (i :: Int)::IO()
                                      printf "\n" ::IO()
                                      let y = 1
                                      (d y k m)
                              else (d i k m))) in
                         (e f b g found h)
           else return ()) in
           (d a b0 sqrtia)


