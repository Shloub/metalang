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
h i =
  {-  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end -}
  do let j = i - 2
     let a d =
           if d <= i + 2
           then if (i `rem` d) == 5
                then return True
                else do let e = d + 1
                        a e
           else return False in
           a j

main =
  do let j = 0
     let c k f =
           if k <= 10
           then do let g = f + k
                   printf "%d\n" (g::Int) :: IO()
                   c (k + 1) g
           else do let i = 4
                   let b l m =
                         if l < 10
                         then do printf "%d" (l :: Int) :: IO ()
                                 let n = l + 1
                                 let o = m + n
                                 b n o
                         else printf "%d%dFIN TEST\n" (m::Int) (l::Int) :: IO() in
                         b i f in
           c 0 j


