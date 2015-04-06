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
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
data Toto = Toto {
                    _foo :: IORef Int,
                    _bar :: IORef Int,
                    _blah :: IORef Int
                    }
  deriving Eq


mktoto v1 =
  do t <- (Toto <$> (newIORef v1) <*> (newIORef v1) <*> (newIORef v1))
     return t

mktoto2 v1 =
  do t <- (Toto <$> (newIORef (v1 + 3)) <*> (newIORef (v1 + 2)) <*> (newIORef (v1 + 1)))
     return t

result t_ t2_ =
  do t3 <- (Toto <$> (newIORef 0) <*> (newIORef 0) <*> (newIORef 0))
     writeIORef (_blah t2_) =<< (((+) 1) <$> (readIORef (_blah t2_)))
     cache0 <- array_init 1 (\ i ->
                               return (- i))
     cache1 <- array_init 1 (\ j ->
                               return j)
     ((+) <$> ((+) <$> (readIORef (_foo t2_)) <*> ((*) <$> (readIORef (_blah t2_)) <*> (readIORef (_bar t2_)))) <*> ((*) <$> (readIORef (_bar t2_)) <*> (readIORef (_foo t2_))))

main =
  do t <- mktoto 4
     t2 <- mktoto 5
     a <- read_int
     writeIORef (_bar t) a
     skip_whitespaces
     b <- read_int
     writeIORef (_blah t) b
     skip_whitespaces
     c <- read_int
     writeIORef (_bar t2) c
     skip_whitespaces
     d <- read_int
     writeIORef (_blah t2) d
     join $ printf "%d%d" <$> ((result t t2)::IO Int) <*> ((readIORef (_blah t))::IO Int)


