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
periode restes len a b =
  let c h k =
        if h /= 0
        then do let chiffre = h `quot` b
                let reste = h `rem` b
                let d i =
                      if i <= k - 1
                      then ifM (((==) reste) <$> (readIOA restes i))
                               (return (k - i))
                               (d (i + 1))
                      else do writeIOA restes k reste
                              let l = k + 1
                              let n = reste * 10
                              c n l in
                      d 0
        else return 0 in
        c a len

main =
  do t <- array_init 1000 (\ j ->
                             return 0)
     let g i o q =
           if i <= 1000
           then do p <- periode t 0 1 i
                   if p > o
                   then g (i + 1) p i
                   else g (i + 1) o q
           else printf "%d\n%d\n" (q::Int) (o::Int) :: IO() in
           g 1 0 0


