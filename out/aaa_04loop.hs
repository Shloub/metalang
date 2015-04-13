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
     let a b =
           if b <= i + 2
           then if (i `rem` b) == 5
                then return True
                else do let c = b + 1
                        a c
           else return False in
           a j

main =
  let d k e =
        if k <= 10
        then do let o = e + k
                printf "%d\n" (o::Int) :: IO()
                d (k + 1) o
        else let f g l =
                   if g < 10
                   then do printf "%d" (g :: Int) :: IO ()
                           let m = g + 1
                           let n = l + m
                           f m n
                   else printf "%d%dFIN TEST\n" (l::Int) (g::Int) :: IO() in
                   f 4 e in
        d 0 0


