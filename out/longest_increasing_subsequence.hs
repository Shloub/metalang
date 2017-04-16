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
dichofind len tab tofind a b =
  if a >= b - 1
  then return a
  else do let c = (a + b) `quot` 2
          ifM (((>) tofind) <$> (readIOA tab c))
              (dichofind len tab tofind c b)
              (dichofind len tab tofind a c)

process len tab =
  do size <- array_init len (\ j ->
                               return (if j == 0
                                       then 0
                                       else len * 2))
     let d i =
           if i <= len - 1
           then do k <- join $ dichofind len size <$> (readIOA tab i) <*> return 0 <*> return (len - 1)
                   ifM ((>) <$> (readIOA size (k + 1)) <*> (readIOA tab i))
                       (do writeIOA size (k + 1) =<< (readIOA tab i)
                           d (i + 1))
                       (d (i + 1))
           else let e l =
                      if l <= len - 1
                      then do printf "%d " =<< ((readIOA size l)::IO Int)
                              e (l + 1)
                      else let f m =
                                 if m <= len - 1
                                 then do let k = len - 1 - m
                                         ifM (((/=) (len * 2)) <$> (readIOA size k))
                                             (return k)
                                             (f (m + 1))
                                 else return 0 in
                                 f 0 in
                      e 0 in
           d 0

main =
  do n <- (fmap read getLine)
     let g i =
           if i <= n
           then do len <- (fmap read getLine)
                   printf "%d\n" =<< ((process len =<< (join (newListArray . (,) 0 . subtract 1 <$> return len <*> fmap (map read . words) getLine)))::IO Int)
                   g (i + 1)
           else return () in
           g 1


