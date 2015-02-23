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

min2_ a b =
  return ((if (a < b)
          then a
          else b))
main =
  do printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 1 2) <*> (return 3))) <*> (return 4))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 1 2) <*> (return 4))) <*> (return 3))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 1 3) <*> (return 2))) <*> (return 4))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 1 3) <*> (return 4))) <*> (return 2))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 1 4) <*> (return 2))) <*> (return 3))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 1 4) <*> (return 3))) <*> (return 2))) :: IO Int)
     printf "\n" ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 2 1) <*> (return 3))) <*> (return 4))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 2 1) <*> (return 4))) <*> (return 3))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 2 3) <*> (return 1))) <*> (return 4))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 2 3) <*> (return 4))) <*> (return 1))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 2 4) <*> (return 1))) <*> (return 3))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 2 4) <*> (return 3))) <*> (return 1))) :: IO Int)
     printf "\n" ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 3 1) <*> (return 2))) <*> (return 4))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 3 1) <*> (return 4))) <*> (return 2))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 3 2) <*> (return 1))) <*> (return 4))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 3 2) <*> (return 4))) <*> (return 1))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 3 4) <*> (return 1))) <*> (return 2))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 3 4) <*> (return 2))) <*> (return 1))) :: IO Int)
     printf "\n" ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 4 1) <*> (return 2))) <*> (return 3))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 4 1) <*> (return 3))) <*> (return 2))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 4 2) <*> (return 1))) <*> (return 3))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 4 2) <*> (return 3))) <*> (return 1))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 4 3) <*> (return 1))) <*> (return 2))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (join (min2_ <$> (min2_ 4 3) <*> (return 2))) <*> (return 1))) :: IO Int)
     printf "\n" ::IO()

