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
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
go0 tab a b =
  do let m = (a + b) `quot` 2
     if a == m
     then ifM (((==) m) <$> (readIOA tab a))
              (return b)
              (return a)
     else let c d f =
                if d < f
                then do e <- readIOA tab d
                        if e < m
                        then do let h = d + 1
                                c h f
                        else do let g = f - 1
                                writeIOA tab d =<< (readIOA tab g)
                                writeIOA tab g e
                                c d g
                else if d < m
                     then go0 tab a m
                     else go0 tab m b in
                c a b

plus_petit0 tab len =
  go0 tab 0 len

main =
  do k <- read_int
     skip_whitespaces
     tab <- array_init k (\ i ->
                            do l <- read_int
                               skip_whitespaces
                               return l)
     printf "%d" =<< (plus_petit0 tab k :: IO Int)


