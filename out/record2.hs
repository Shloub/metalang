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
                    _bar :: IORef Int,
                    _blah :: IORef Int
                    }
  deriving Eq


mktoto v1 =
  do t <- (Toto <$> (newIORef v1) <*> (newIORef 0) <*> (newIORef 0))
     return t

result t =
  do writeIORef (_blah t) =<< (((+) 1) <$> (readIORef (_blah t)))
     ((+) <$> ((+) <$> (readIORef (_foo t)) <*> ((*) <$> (readIORef (_blah t)) <*> (readIORef (_bar t)))) <*> ((*) <$> (readIORef (_bar t)) <*> (readIORef (_foo t))))

main =
  do t <- mktoto 4
     b <- read_int
     writeIORef (_bar t) b
     skip_whitespaces
     a <- read_int
     writeIORef (_blah t) a
     printf "%d" =<< (result t :: IO Int)


