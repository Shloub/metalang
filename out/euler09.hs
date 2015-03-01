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
  {-
	a + b + c = 1000 && a * a + b * b = c * c
	-}
  let d a =
        if a <= 1000
        then let e b =
                   if b <= 1000
                   then do let c = 1000 - a - b
                           let a2b2 = a * a + b * b
                           let cc = c * c
                           if cc == a2b2 && c > a
                           then do printf "%d\n%d\n%d\n%d\n" (a::Int) (b::Int) (c::Int) ((a * b * c)::Int) :: IO()
                                   e (b + 1)
                           else e (b + 1)
                   else d (a + 1) in
                   e (a + 1)
        else return () in
        d 1


