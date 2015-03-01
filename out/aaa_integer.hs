import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

main :: IO ()
main =
  do let a = 0 - 1
     printf "%d\n" (a::Int) :: IO()
     let b = a + 55
     printf "%d\n" (b::Int) :: IO()
     let c = b * 13
     printf "%d\n" (c::Int) :: IO()
     let d = c `quot` 2
     printf "%d\n" (d::Int) :: IO()
     let e = d + 1
     printf "%d\n" (e::Int) :: IO()
     let f = e `quot` 3
     printf "%d\n" (f::Int) :: IO()
     let g = f - 1
     printf "%d\n" (g::Int) :: IO()
     {-
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
-}
     printf "%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n" ((117 `quot` 17)::Int) ((117 `quot` (- 17))::Int) (((- 117) `quot` 17)::Int) (((- 117) `quot` (- 17))::Int) ((117 `rem` 17)::Int) ((117 `rem` (- 17))::Int) (((- 117) `rem` 17)::Int) (((- 117) `rem` (- 17))::Int) :: IO()


