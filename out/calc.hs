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


fibo a b i =
  do let out_ = 0
     let a2 = a
     let b2 = b
     let d = (i + 1)
     let c j e f g =
           (if (j <= d)
           then do printf "%d" (j :: Int)::IO()
                   let h = (g + e)
                   let tmp = f
                   let k = (f + e)
                   let l = tmp
                   (c (j + 1) l k h)
           else return (g)) in
           (c 0 a2 b2 out_)

main =
  printf "%d" =<< ((fibo 1 2 4) :: IO Int)


