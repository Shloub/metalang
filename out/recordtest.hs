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
data Toto = Toto {
                    _foo :: IORef Int,
                    _bar :: IORef Int
                    }
  deriving Eq


main =
  do param <- (Toto <$> (newIORef 0) <*> (newIORef 0))
     a <- read_int
     writeIORef (_bar param) a
     skip_whitespaces
     b <- read_int
     writeIORef (_foo param) b
     printf "%d" =<< (((+) <$> (readIORef (_bar param)) <*> ((*) <$> (readIORef (_foo param)) <*> (readIORef (_bar param)))) :: IO Int)


