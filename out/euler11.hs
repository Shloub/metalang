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
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()


find n m x y dx dy =
  if ((x < 0 || x == 20) || y < 0) || y == 20
  then return (- 1)
  else if n == 0
       then return 1
       else ((*) <$> (join $ readIOA <$> (readIOA m y) <*> return x) <*> (find (n - 1) m (x + dx) (y + dy) dx dy))

main =
  do directions <- array_init 8 (\ i ->
                                   return (if i == 0
                                           then (0, 1)
                                           else if i == 1
                                                then (1, 0)
                                                else if i == 2
                                                     then (0, - 1)
                                                     else if i == 3
                                                          then (- 1, 0)
                                                          else if i == 4
                                                               then (1, 1)
                                                               else if i == 5
                                                                    then (1, - 1)
                                                                    else if i == 6
                                                                         then (- 1, 1)
                                                                         else (- 1, - 1)))
     m <- array_init 20 (\ c ->
                           (join (newListArray . (,) 0 . subtract 1 <$> return 20 <*> fmap (map read . words) getLine)))
     let h j o =
           if j <= 7
           then (readIOA directions j) >>= (\ (dx, dy) ->
                                             let k x p =
                                                   if x <= 19
                                                   then let l y q =
                                                              if y <= 19
                                                              then do r <- ((max <$> (return q) <*> (find 4 m x y dx dy)))
                                                                      l (y + 1) r
                                                              else k (x + 1) q in
                                                              l 0 p
                                                   else h (j + 1) p in
                                                   k 0 o)
           else printf "%d\n" (o::Int) :: IO() in
           h 0 0


