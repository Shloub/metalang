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


main =
  do printf "Hello World" ::IO()
     let a = 5
     printf "%d" (((4 + 6) * 2) :: Int)::IO()
     printf " " ::IO()
     printf "\n" ::IO()
     printf "%d" (a :: Int)::IO()
     printf "foo" ::IO()
     printf "" ::IO()


