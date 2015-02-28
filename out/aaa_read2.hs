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
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

main :: IO ()





main =
  do len <- (fmap read getLine)
     printf "%d" (len :: Int) :: IO ()
     printf "=len\n" :: IO ()
     tab <- (join (newListArray . (,) 0 . subtract 1 <$> return len <*> fmap (map read . words) getLine))
     let k = len - 1
     let h i =
           if i <= k
           then do printf "%d" (i :: Int) :: IO ()
                   printf "=>" :: IO ()
                   printf "%d" =<< (readIOA tab i :: IO Int)
                   printf " " :: IO ()
                   h (i + 1)
           else do printf "\n" :: IO ()
                   tab2 <- (join (newListArray . (,) 0 . subtract 1 <$> return len <*> fmap (map read . words) getLine))
                   let g = len - 1
                   let f i_ =
                         if i_ <= g
                         then do printf "%d" (i_ :: Int) :: IO ()
                                 printf "==>" :: IO ()
                                 printf "%d" =<< (readIOA tab2 i_ :: IO Int)
                                 printf " " :: IO ()
                                 f (i_ + 1)
                         else do strlen <- (fmap read getLine)
                                 printf "%d" (strlen :: Int) :: IO ()
                                 printf "=strlen\n" :: IO ()
                                 tab4 <- (join (newListArray <$> (fmap (\x -> (0, x-1)) (return strlen)) <*> getLine))
                                 let e = strlen - 1
                                 let d i3 =
                                       if i3 <= e
                                       then do tmpc <- readIOA tab4 i3
                                               let c = (ord tmpc)
                                               printf "%c" (tmpc :: Char) :: IO ()
                                               printf ":" :: IO ()
                                               printf "%d" (c :: Int) :: IO ()
                                               printf " " :: IO ()
                                               let l = if tmpc /= ' '
                                                       then let m = ((c - (ord 'a') + 13) `rem` 26) + (ord 'a')
                                                                    in m
                                                       else c
                                               writeIOA tab4 i3 (chr l)
                                               d (i3 + 1)
                                       else do let b = strlen - 1
                                               let a j =
                                                     if j <= b
                                                     then do printf "%c" =<< (readIOA tab4 j :: IO Char)
                                                             a (j + 1)
                                                     else return () in
                                                     a 0 in
                                       d 0 in
                         f 0 in
           h 0


