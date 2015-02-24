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

main :: IO ()

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_


min2_ a b =
  return ((if (a < b)
          then a
          else b))

main =
  do printf "%d" =<< ((join (min2_ <$> (min2_ 2 3) <*> (return 4))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (min2_ 2 4) <*> (return 3))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (min2_ 3 2) <*> (return 4))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (min2_ 3 4) <*> (return 2))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (min2_ 4 2) <*> (return 3))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< ((join (min2_ <$> (min2_ 4 3) <*> (return 2))) :: IO Int)
     printf "\n" ::IO()


