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

main :: IO ()

score () =
  do skip_whitespaces
     len <- read_int
     skip_whitespaces
     let a i b =
           if i <= len
           then do c <- getChar
                   let d = b + (ord c) - (ord 'A') + 1
                   {-		print c print " " print sum print " " -}
                   a (i + 1) d
           else return b in
           a 1 0

main =
  do n <- read_int
     let e i f =
           if i <= n
           then do g <- (((+) f) <$> (((*) i) <$> (score ())))
                   e (i + 1) g
           else printf "%d\n" (f::Int) :: IO() in
           e 1 0


