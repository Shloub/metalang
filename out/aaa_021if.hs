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

main :: IO ()
testA a b =
  if a
  then if b
       then printf "A" :: IO ()
       else printf "B" :: IO ()
  else if b
       then printf "C" :: IO ()
       else printf "D" :: IO ()

testB a b =
  if a
  then printf "A" :: IO ()
  else if b
       then printf "B" :: IO ()
       else printf "C" :: IO ()

testC a b =
  if a
  then if b
       then printf "A" :: IO ()
       else printf "B" :: IO ()
  else printf "C" :: IO ()

testD a b =
  if a
  then do if b
          then printf "A" :: IO ()
          else printf "B" :: IO ()
          printf "C" :: IO ()
  else printf "D" :: IO ()

testE a b =
  if a
  then if b
       then printf "A" :: IO ()
       else return ()
  else do if b
          then printf "C" :: IO ()
          else printf "D" :: IO ()
          printf "E" :: IO ()

test a b =
  do testD a b
     testE a b
     printf "\n" :: IO ()

main =
  do test True True
     test True False
     test False True
     test False False
     return ()


