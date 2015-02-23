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

max2_ a b =
  let g () = ()
             in return ((if (a > b)
                        then a
                        else b))
min2_ a b =
  let f () = ()
             in return ((if (a < b)
                        then a
                        else b))
pgcd a b =
  do c <- (min2_ a b)
     d <- (max2_ a b)
     let reste = (d `rem` c)
     let e () = return (())
     (if (reste == 0)
     then return (c)
     else (pgcd c reste))
main =
  do let top = 1
     let bottom = 1
     let s = 1
     let t = 9
     let h i u v =
           (if (i <= t)
           then do let q = 1
                   let r = 9
                   let l j w x =
                         (if (j <= r)
                         then do let n = 1
                                 let o = 9
                                 let m k y z =
                                       (if (k <= o)
                                       then ((\ (ba, bb) ->
                                               (m (k + 1) ba bb)) =<< (if ((i /= j) && (j /= k))
                                                                      then do let a = ((i * 10) + j)
                                                                              let b = ((j * 10) + k)
                                                                              ((\ (bc, bd) ->
                                                                                 return ((bc, bd))) =<< (if ((a * k) == (i * b))
                                                                                                        then do printf "%d" (a :: Int)::IO()
                                                                                                                printf "/" ::IO()
                                                                                                                printf "%d" (b :: Int)::IO()
                                                                                                                printf "\n" ::IO()
                                                                                                                let be = (z * a)
                                                                                                                let bf = (y * b)
                                                                                                                return ((bf, be))
                                                                                                        else return ((y, z))))
                                                                      else return ((y, z))))
                                       else (l (j + 1) y z)) in
                                       (m n w x)
                         else (h (i + 1) w x)) in
                         (l q u v)
           else do printf "%d" (v :: Int)::IO()
                   printf "/" ::IO()
                   printf "%d" (u :: Int)::IO()
                   printf "\n" ::IO()
                   p <- (pgcd v u)
                   printf "pgcd=" ::IO()
                   printf "%d" (p :: Int)::IO()
                   printf "\n" ::IO()
                   printf "%d" ((u `quot` p) :: Int)::IO()
                   printf "\n" ::IO()) in
           (h s bottom top)

