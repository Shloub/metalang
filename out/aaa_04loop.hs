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

h i =
  {-  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end -}
  do let j = (i - 2)
     let a d =
           (if (d <= (i + 2))
           then (if ((i `rem` d) == 5)
                then return (True)
                else do let e = (d + 1)
                        (a e))
           else return (False)) in
           (a j)
main =
  do let j = 0
     let c k f =
           (if (k <= 10)
           then do let g = (f + k)
                   printf "%d" (g :: Int)::IO()
                   printf "\n" ::IO()
                   (c (k + 1) g)
           else do let i = 4
                   let b l m =
                         (if (l < 10)
                         then do printf "%d" (l :: Int)::IO()
                                 let n = (l + 1)
                                 let o = (m + n)
                                 (b n o)
                         else do printf "%d" (m :: Int)::IO()
                                 printf "%d" (l :: Int)::IO()
                                 printf "FIN TEST\n" ::IO()) in
                         (b i f)) in
           (c 0 j)

