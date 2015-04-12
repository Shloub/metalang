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
main =
  let d e f g =
        if e < 4000000
        then do let h = if (e `rem` 2) == 0
                        then g + e
                        else g
                let i = f + e
                d f i h
        else printf "%d\n" (g::Int) :: IO() in
        d 1 2 0


