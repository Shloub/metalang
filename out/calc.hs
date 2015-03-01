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
  let c j d e f =
        if j <= i + 1
        then do printf "%d" (j :: Int) :: IO ()
                let g = f + d
                let h = e + d
                c (j + 1) e h g
        else return f in
        c 0 a b 0

main =
  printf "%d" =<< (fibo 1 2 4 :: IO Int)


