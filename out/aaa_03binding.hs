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


g i =
  let j = (i * 4)
          in return ((if ((j `rem` 2) == 1)
                     then 0
                     else j))

h i =
  do printf "%d" (i :: Int)::IO()
     printf "\n" ::IO()

main =
  do (h 14)
     let a = 4
     let b = 5
     printf "%d" ((a + b) :: Int)::IO()
     {- main -}
     do (h 15)
        let c = 2
        let d = 1
        printf "%d" ((c + d) :: Int)::IO()


