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



score () =
  do skip_whitespaces
     len <- read_int
     skip_whitespaces
     let sum = 0
     let a i d =
           if i <= len
           then hGetChar stdin >>= ((\ c ->
                                      do e <- (((+) d) <$> (((+) 1) <$> ((-) <$> ((fmap ord (return c))) <*> ((fmap ord (return 'A'))))))
                                         {-		print c print " " print sum print " " -}
                                         (a (i + 1) e)))
           else return d in
           (a 1 sum)

main =
  do let sum = 0
     n <- read_int
     let b i f =
           if i <= n
           then do g <- (((+) f) <$> (((*) i) <$> (score ())))
                   (b (i + 1) g)
           else do printf "%d" (f :: Int) :: IO ()
                   printf "\n" :: IO () in
           (b 1 sum)


