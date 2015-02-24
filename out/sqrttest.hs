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
  do printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return (4)))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return (16)))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return (20)))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return (1000)))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return (500)))) :: IO Int)
     printf " " ::IO()
     printf "%d" =<< (((fmap (floor . sqrt . fromIntegral) (return (10)))) :: IO Int)
     printf " " ::IO()


