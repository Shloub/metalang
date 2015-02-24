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



foo () =
  let c i =
        (if (i <= 10)
        then (c (i + 1))
        else return (0)) in
        (c 0)

bar () =
  let b i =
        (if (i <= 10)
        then do let a = 0
                (b (i + 1))
        else return (0)) in
        (b 0)

main =
  return (())


