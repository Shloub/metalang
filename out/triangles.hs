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
find0 len tab cache x y =
  {-
	Cette fonction est récursive
	-}
  if y == len - 1
  then join $ readIOA <$> (readIOA tab y) <*> return x
  else if x > y
       then return (- 10000)
       else ifM (((/=) 0) <$> (join $ readIOA <$> (readIOA cache y) <*> return x))
                (join $ readIOA <$> (readIOA cache y) <*> return x)
                (do let result = 0
                    out0 <- find0 len tab cache x (y + 1)
                    out1 <- find0 len tab cache (x + 1) (y + 1)
                    r <- if out0 > out1
                         then do s <- (((+) out0) <$> (join $ readIOA <$> (readIOA tab y) <*> return x))
                                 return s
                         else do t <- (((+) out1) <$> (join $ readIOA <$> (readIOA tab y) <*> return x))
                                 return t
                    join $ writeIOA <$> (readIOA cache y) <*> return x <*> return r
                    return r)

find len tab =
  do tab2 <- array_init len (\ i ->
                              do tab3 <- array_init (i + 1) (\ j ->
                                                              return 0)
                                 return tab3)
     find0 len tab tab2 0 0

main =
  do let len = 0
     q <- read_int
     let u = q
     skip_whitespaces
     tab <- array_init u (\ i ->
                           do tab2 <- array_init (i + 1) (\ j ->
                                                           do let tmp = 0
                                                              p <- read_int
                                                              let v = p
                                                              skip_whitespaces
                                                              return v)
                              return tab2)
     printf "%d" =<< (find u tab :: IO Int)
     printf "\n" :: IO ()
     let m = u - 1
     let g k =
           if k <= m
           then let h l =
                      if l <= k
                      then do printf "%d" =<< (join $ readIOA <$> (readIOA tab k) <*> return l :: IO Int)
                              printf " " :: IO ()
                              h (l + 1)
                      else do printf "\n" :: IO ()
                              g (k + 1) in
                      h 0
           else return () in
           g 0


