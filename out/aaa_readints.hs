import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef
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


main =
  do len <- (fmap read getLine)
     printf "%d" (len :: Int) :: IO ()
     printf "=len\n" :: IO ()
     tab1 <- (join (newListArray . (,) 0 . subtract 1 <$> return len <*> fmap (map read . words) getLine))
     let k = len - 1
     let h i =
           if i <= k
           then do printf "%d" (i :: Int) :: IO ()
                   printf "=>" :: IO ()
                   printf "%d" =<< (readIOA tab1 i :: IO Int)
                   printf "\n" :: IO ()
                   h (i + 1)
           else do l <- (fmap read getLine)
                   tab2 <- array_init (l - 1) (\ a ->
                                                (join (newListArray . (,) 0 . subtract 1 <$> return l <*> fmap (map read . words) getLine)))
                   let g = l - 2
                   let d m =
                         if m <= g
                         then do let f = l - 1
                                 let e j =
                                       if j <= f
                                       then do printf "%d" =<< (join $ readIOA <$> (readIOA tab2 m) <*> return j :: IO Int)
                                               printf " " :: IO ()
                                               e (j + 1)
                                       else do printf "\n" :: IO ()
                                               d (m + 1) in
                                       e 0
                         else return () in
                         d 0 in
           h 0


