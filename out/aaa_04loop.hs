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
        then do let f = e + k
                printf "%d\n" (f::Int) :: IO()
                d (k + 1) f
        else let g l m =
                   if l < 10
                   then do printf "%d" (l :: Int) :: IO ()
                           let n = l + 1
                           let o = m + n
                           g n o
                   else printf "%d%dFIN TEST\n" (m::Int) (l::Int) :: IO() in
                   g 4 e in
        d 0 0


