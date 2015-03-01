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
fibo a b i =
  do let d = i + 1
     let c j e f g =
           if j <= d
           then do printf "%d" (j :: Int) :: IO ()
                   let h = g + e
                   let k = f + e
                   c (j + 1) f k h
           else return g in
           c 0 a b 0

main =
  printf "%d" =<< (fibo 1 2 4 :: IO Int)


