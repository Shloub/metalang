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
     let d a =
           if a <= 1000
           then let g b =
                      if b <= 1000
                      then do let c2 = a * a + b * b
                              let c = ((floor . sqrt . fromIntegral) c2)
                              if c * c == c2
                              then do let p = a + b + c
                                      if p <= 1000
                                      then do writeIOA t p =<< (((+) 1) <$> (readIOA t p))
                                              g (b + 1)
                                      else g (b + 1)
                              else g (b + 1)
                      else d (a + 1) in
                      g 1
           else let e k f =
                      if k <= 1000
                      then ifM ((>) <$> (readIOA t k) <*> (readIOA t f))
                               (e (k + 1) k)
                               (e (k + 1) f)
                      else printf "%d" (f :: Int) :: IO () in
                      e 1 0 in
           d 1


