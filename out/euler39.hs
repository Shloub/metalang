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

main =
  do t <- array_init 1001 (\ i ->
                             return 0)
     let g a =
           if a <= 1000
           then let h b =
                      if b <= 1000
                      then do let c2 = a * a + b * b
                              let c = ((floor . sqrt . fromIntegral) c2)
                              if c * c == c2
                              then do let p = a + b + c
                                      if p <= 1000
                                      then do writeIOA t p =<< (((+) 1) <$> (readIOA t p))
                                              h (b + 1)
                                      else h (b + 1)
                              else h (b + 1)
                      else g (a + 1) in
                      h 1
           else let f k l =
                      if k <= 1000
                      then ifM ((>) <$> (readIOA t k) <*> (readIOA t l))
                               (f (k + 1) k)
                               (f (k + 1) l)
                      else printf "%d" (l :: Int) :: IO () in
                      f 1 0 in
           g 1


