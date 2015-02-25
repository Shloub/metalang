import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

main :: IO ()


f i =
  return (if i == 0
          then True
          else False)

main =
  do ifM (f 4)
         (printf "true <-\n ->\n" :: IO ())
         (printf "false <-\n ->\n" :: IO ())
     printf "small test end\n" :: IO ()


