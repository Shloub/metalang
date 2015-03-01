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
data Toto = Toto {
                    _foo :: IORef Int,
                    _bar :: IORef Int,
                    _blah :: IORef Int
                    }
  deriving Eq


mktoto v1 =
  do t <- (Toto <$> (newIORef v1) <*> (newIORef 0) <*> (newIORef 0))
     return t

result t len =
  do let out0 = 0
     let b = len - 1
     let a j g =
           if j <= b
           then do join $ writeIORef <$> (_blah <$> (readIOA t j)) <*> (((+) 1) <$> ((_blah <$> (readIOA t j)) >>= readIORef))
                   h <- ((+) <$> ((+) <$> (((+) g) <$> ((_foo <$> (readIOA t j)) >>= readIORef)) <*> ((*) <$> ((_blah <$> (readIOA t j)) >>= readIORef) <*> ((_bar <$> (readIOA t j)) >>= readIORef))) <*> ((*) <$> ((_bar <$> (readIOA t j)) >>= readIORef) <*> ((_foo <$> (readIOA t j)) >>= readIORef)))
                   a (j + 1) h
           else return g in
           a 0 out0

main =
  do t <- array_init 4 (\ i ->
                          mktoto i)
     f <- read_int
     join $ writeIORef <$> (_bar <$> (readIOA t 0)) <*> return f
     skip_whitespaces
     e <- read_int
     join $ writeIORef <$> (_blah <$> (readIOA t 1)) <*> return e
     titi <- result t 4
     printf "%d%d" (titi::Int) =<< (((_blah <$> (readIOA t 2)) >>= readIORef)::IO Int) :: IO()


