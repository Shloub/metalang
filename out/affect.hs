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
  do let t = t_
     let t2 = t2_
     t3 <- (Toto <$> (newIORef 0) <*> (newIORef 0) <*> (newIORef 0))
     let k = t2
     let l = t2
     let m = k
     writeIORef (_blah l) =<< (((+) 1) <$> (readIORef (_blah l)))
     let len = 1
     cache0 <- array_init len (\ i ->
                                 return (- i))
     cache1 <- array_init len (\ j ->
                                 return j)
     let cache2 = cache0
     let n = cache1
     let o = n
     ((+) <$> ((+) <$> (readIORef (_foo l)) <*> ((*) <$> (readIORef (_blah l)) <*> (readIORef (_bar l)))) <*> ((*) <$> (readIORef (_bar l)) <*> (readIORef (_foo l))))

main =
  do t <- mktoto 4
     t2 <- mktoto 5
     h <- read_int
     writeIORef (_bar t) h
     skip_whitespaces
     g <- read_int
     writeIORef (_blah t) g
     skip_whitespaces
     f <- read_int
     writeIORef (_bar t2) f
     skip_whitespaces
     e <- read_int
     writeIORef (_blah t2) e
     printf "%d" =<< (result t t2 :: IO Int)
     printf "%d" =<< (readIORef (_blah t) :: IO Int)


