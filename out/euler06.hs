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
  do let lim = 100
     let sum = ((lim * (lim + 1)) `quot` 2)
     let carressum = (sum * sum)
     let sumcarres = (((lim * (lim + 1)) * ((2 * lim) + 1)) `quot` 6)
     printf "%d" ((carressum - sumcarres) :: Int)::IO()


