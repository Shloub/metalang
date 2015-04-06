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
is_pair i =
  do let a internal_1 = let b = if i < 20
                                then let c = if i == 22
                                             then 0
                                             else 6
                                             in 8
                                else 6
                                in return ((i `rem` 2) == 0)
     if i < 10
     then if i == 0
          then return True
          else if i == 2
               then return True
               else a 5
     else a 1

main =
  return ()


