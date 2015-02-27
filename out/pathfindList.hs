import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False
(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

main :: IO ()


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
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f =
  do li <- g 0
     newListArray (0, len - 1) li
  where g i =
           if i == len
           then return []
           else do item <- f i
                   li <- g (i+1)
                   return (item:li)
                                                            

pathfind_aux cache tab len pos =
  if pos >= len - 1
  then return 0
  else ifM (((/=) (- 1)) <$> (readIOA cache pos))
           (readIOA cache pos)
           (do writeIOA cache pos (len * 2)
               posval <- pathfind_aux cache tab len =<< (readIOA tab pos)
               oneval <- pathfind_aux cache tab len (pos + 1)
               let out0 = 0
               let g = if posval < oneval
                       then let h = 1 + posval
                                    in h
                       else let j = 1 + oneval
                                    in j
               writeIOA cache pos g
               return g)

pathfind tab len =
  do cache <- array_init len (\ i ->
                               return (- 1))
     pathfind_aux cache tab len 0

main =
  do let len = 0
     f <- read_int
     let k = f
     skip_whitespaces
     tab <- array_init k (\ i ->
                           do let tmp = 0
                              e <- read_int
                              let l = e
                              skip_whitespaces
                              return l)
     result <- pathfind tab k
     printf "%d" (result :: Int) :: IO ()


