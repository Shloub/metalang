import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False
(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

main :: IO ()
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f =
  do li <- g 0
     newListArray (0, len - 1) li
  where g i =
           if i == len
           then return []
           else do item <- f i
                   li <- g (i+1)
                   return (item:li)
                                                                                                                                 

periode restes len a b =
  let c k l =
        if k /= 0
        then do let chiffre = k `quot` b
                let reste = k `rem` b
                let e = l - 1
                let d i =
                      if i <= e
                      then ifM (((==) reste) <$> (readIOA restes i))
                               (return (l - i))
                               (d (i + 1))
                      else do writeIOA restes l reste
                              let n = l + 1
                              let o = reste * 10
                              c o n in
                      d 0
        else return 0 in
        c a len

main =
  do t <- array_init 1000 (\ j ->
                            return 0)
     let m = 0
     let mi = 0
     let h i q r =
           if i <= 1000
           then do p <- periode t 0 1 i
                   if p > q
                   then do let s = i
                           let u = p
                           h (i + 1) u s
                   else h (i + 1) q r
           else do printf "%d" (r :: Int) :: IO ()
                   printf "\n" :: IO ()
                   printf "%d" (q :: Int) :: IO ()
                   printf "\n" :: IO () in
           h 1 m mi


