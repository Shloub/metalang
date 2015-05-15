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
test tab len =
  let a i =
        if i <= len - 1
        then do printf "%d " =<< ((readIOA tab i)::IO Int)
                a (i + 1)
        else printf "\n" :: IO () in
        a 0

main =
  do t <- array_init 5 (\ i ->
                          return 1)
     test t 5
     return ()


