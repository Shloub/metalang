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
  let c d e =
        if d /= 0
        then do let chiffre = d `quot` b
                let reste = d `rem` b
                let f i =
                      if i <= e - 1
                      then ifM (((==) reste) <$> (readIOA restes i))
                               (return (e - i))
                               (f (i + 1))
                      else do writeIOA restes e reste
                              let g = e + 1
                              let h = reste * 10
                              c h g in
                      f 0
        else return 0 in
        c a len

main =
  do t <- array_init 1000 (\ j ->
                             return 0)
     let k i l n =
           if i <= 1000
           then do p <- periode t 0 1 i
                   if p > l
                   then k (i + 1) p i
                   else k (i + 1) l n
           else printf "%d\n%d\n" (n::Int) (l::Int) :: IO() in
           k 1 0 0


