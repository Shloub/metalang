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
sumdiag n =
  do let nterms = n * 2 - 1
     let a i b c =
           if i <= nterms - 2
           then do let d = 2 * (1 + (i `quot` 4))
                   let e = c + d
                   {- print int d print "=>" print un print " " -}
                   do let f = b + e
                      a (i + 1) f e
           else return b in
           a 0 1 1

main =
  printf "%d" =<< (sumdiag 1001 :: IO Int)


