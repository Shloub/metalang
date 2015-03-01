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
     printf "%d=len\n" (len::Int) :: IO()
     tab <- (join (newListArray . (,) 0 . subtract 1 <$> return len <*> fmap (map read . words) getLine))
     let e i =
           if i <= len - 1
           then do printf "%d=>%d " (i::Int) =<< ((readIOA tab i)::IO Int)
                   e (i + 1)
           else do printf "\n" :: IO ()
                   tab2 <- (join (newListArray . (,) 0 . subtract 1 <$> return len <*> fmap (map read . words) getLine))
                   let d i_ =
                         if i_ <= len - 1
                         then do printf "%d==>%d " (i_::Int) =<< ((readIOA tab2 i_)::IO Int)
                                 d (i_ + 1)
                         else do strlen <- (fmap read getLine)
                                 printf "%d=strlen\n" (strlen::Int) :: IO()
                                 tab4 <- (join (newListArray <$> (fmap (\x -> (0, x-1)) (return strlen)) <*> getLine))
                                 let b i3 =
                                       if i3 <= strlen - 1
                                       then do tmpc <- readIOA tab4 i3
                                               let c = (ord tmpc)
                                               printf "%c:%d " (tmpc::Char) (c::Int) :: IO()
                                               let f = if tmpc /= ' '
                                                       then let g = ((c - (ord 'a') + 13) `rem` 26) + (ord 'a')
                                                                    in g
                                                       else c
                                               writeIOA tab4 i3 (chr f)
                                               b (i3 + 1)
                                       else let a j =
                                                  if j <= strlen - 1
                                                  then do printf "%c" =<< (readIOA tab4 j :: IO Char)
                                                          a (j + 1)
                                                  else return () in
                                                  a 0 in
                                       b 0 in
                         d 0 in
           e 0


