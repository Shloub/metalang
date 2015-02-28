import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

(<&&>) a b =
	do c <- a
	   if c then b
		 else return False
(<||>) a b =
	do c <- a
	   if c then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e
skip_whitespaces :: IO ()
skip_whitespaces =
  ifM isEOF
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do getChar
              skip_whitespaces
           else return ())
read_int_a :: Int -> IO Int
read_int_a b =
  ifM isEOF
      (return b)
      (do c <- hLookAhead stdin
          if isNumber c then
           do getChar
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      (* sign) <$> read_int_a 0
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
nth tab tofind len =
  do let out0 = 0
     let b = len - 1
     let a i h =
           if i <= b
           then ifM (((==) tofind) <$> (readIOA tab i))
                    (do let j = h + 1
                        a (i + 1) j)
                    (a (i + 1) h)
           else return h in
           a 0 out0

main =
  do let len = 0
     g <- read_int
     let k = g
     skip_whitespaces
     let tofind = '\000'
     f <- getChar
     let l = f
     skip_whitespaces
     tab <- array_init k (\ i ->
                            do let tmp = '\000'
                               e <- getChar
                               let m = e
                               return m)
     result <- nth tab l k
     printf "%d" (result :: Int) :: IO ()


