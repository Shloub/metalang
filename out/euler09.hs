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
  {-
	a + b + c = 1000 && a * a + b * b = c * c
	-}
  let d a =
        (if (a <= 1000)
        then let e b =
                   (if (b <= 1000)
                   then do let c = ((1000 - a) - b)
                           let a2b2 = ((a * a) + (b * b))
                           let cc = (c * c)
                           (if ((cc == a2b2) && (c > a))
                           then do printf "%d" (a :: Int)::IO()
                                   printf "\n" ::IO()
                                   printf "%d" (b :: Int)::IO()
                                   printf "\n" ::IO()
                                   printf "%d" (c :: Int)::IO()
                                   printf "\n" ::IO()
                                   printf "%d" (((a * b) * c) :: Int)::IO()
                                   printf "\n" ::IO()
                                   (e (b + 1))
                           else (e (b + 1)))
                   else (d (a + 1))) in
                   (e (a + 1))
        else return (())) in
        (d 1)


