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
max2_ a b =
  return (if a > b
          then a
          else b)

min2_ a b =
  return (if a < b
          then a
          else b)

pgcd a b =
  do c <- min2_ a b
     d <- max2_ a b
     let reste = d `rem` c
     if reste == 0
     then return c
     else pgcd c reste

main =
  let e i h l =
        if i <= 9
        then let f j m n =
                   if j <= 9
                   then let g k o q =
                              if k <= 9
                              then if i /= j && j /= k
                                   then do let a = i * 10 + j
                                           let b = j * 10 + k
                                           if a * k == i * b
                                           then do printf "%d/%d\n" (a::Int) (b::Int) :: IO()
                                                   let r = q * a
                                                   let s = o * b
                                                   g (k + 1) s r
                                           else g (k + 1) o q
                                   else g (k + 1) o q
                              else f (j + 1) o q in
                              g 1 m n
                   else e (i + 1) m n in
                   f 1 h l
        else do printf "%d/%d\n" (l::Int) (h::Int) :: IO()
                p <- pgcd l h
                printf "pgcd=%d\n%d\n" (p::Int) ((h `quot` p)::Int) :: IO() in
        e 1 1 1


