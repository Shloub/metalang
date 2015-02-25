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



max2_ a b =
  return (if a > b
          then a
          else b)

min2_ a b =
  return (if a < b
          then a
          else b)

pgcd a b =
  do c <- (min2_ a b)
     d <- (max2_ a b)
     let reste = d `rem` c
     if reste == 0
     then return c
     else (pgcd c reste)

main =
  do let top = 1
     let bottom = 1
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
                                              then do printf "%d" (a :: Int) :: IO ()
                                                      printf "/" :: IO ()
                                                      printf "%d" (b :: Int) :: IO ()
                                                      printf "\n" :: IO ()
                                                      let r = q * a
                                                      let s = o * b
                                                      (g (k + 1) s r)
                                              else (g (k + 1) o q)
                                      else (g (k + 1) o q)
                                 else (f (j + 1) o q) in
                                 (g 1 m n)
                      else (e (i + 1) m n) in
                      (f 1 h l)
           else do printf "%d" (l :: Int) :: IO ()
                   printf "/" :: IO ()
                   printf "%d" (h :: Int) :: IO ()
                   printf "\n" :: IO ()
                   p <- (pgcd l h)
                   printf "pgcd=" :: IO ()
                   printf "%d" (p :: Int) :: IO ()
                   printf "\n" :: IO ()
                   printf "%d" (h `quot` p :: Int) :: IO ()
                   printf "\n" :: IO () in
           (e 1 bottom top)


