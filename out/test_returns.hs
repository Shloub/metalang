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


is_pair i =
  do let j = 1
     let a b = let c = 6
                       in let d = if i < 20
                                  then let e = if i == 22
                                               then let f = 0
                                                            in f
                                               else c
                                               in let g = 8
                                                          in g
                                  else c
                                  in return ((i `rem` 2) == 0)
     if i < 10
     then do let h = 2
             if i == 0
             then let k = 4
                          in return True
             else do let l = 3
                     if i == 2
                     then let m = 4
                                  in return True
                     else do let n = 5
                             (a n)
     else (a j)

main =
  return ()


