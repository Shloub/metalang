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

is_pair i =
  let j = 1
          in return ((if (i < 10)
                     then let a = 2
                                  in (if (i == 0)
                                     then let b = 4
                                                  in True
                                     else let c = 3
                                                  in (if (i == 2)
                                                     then let d = 4
                                                                  in True
                                                     else let e = 5
                                                                  in let f = 6
                                                                             in let g = (if (i < 20)
                                                                                        then let h = (if (i == 22)
                                                                                                     then let k = 0
                                                                                                                  in k
                                                                                                     else f)
                                                                                                     in let l = 8
                                                                                                                in l
                                                                                        else f)
                                                                                        in ((i `rem` 2) == 0)))
                     else let m = 6
                                  in let n = (if (i < 20)
                                             then let o = (if (i == 22)
                                                          then let p = 0
                                                                       in p
                                                          else m)
                                                          in let q = 8
                                                                     in q
                                             else m)
                                             in ((i `rem` 2) == 0)))
main =
  return (())

