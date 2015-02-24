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
  do let a = 1
     let b = 2
     let sum = 0
     let d e f g =
           (if (e < 4000000)
           then do let h = (if ((e `rem` 2) == 0)
                           then let i = (g + e)
                                        in i
                           else g)
                   let c = e
                   let j = f
                   let k = (f + c)
                   (d j k h)
           else do printf "%d" (g :: Int)::IO()
                   printf "\n" ::IO()) in
           (d a b sum)


