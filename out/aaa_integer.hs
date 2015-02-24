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
  do let i = 0
     let a = (i - 1)
     printf "%d" (a :: Int)::IO()
     printf "\n" ::IO()
     let b = (a + 55)
     printf "%d" (b :: Int)::IO()
     printf "\n" ::IO()
     let c = (b * 13)
     printf "%d" (c :: Int)::IO()
     printf "\n" ::IO()
     let d = (c `quot` 2)
     printf "%d" (d :: Int)::IO()
     printf "\n" ::IO()
     let e = (d + 1)
     printf "%d" (e :: Int)::IO()
     printf "\n" ::IO()
     let f = (e `quot` 3)
     printf "%d" (f :: Int)::IO()
     printf "\n" ::IO()
     let g = (f - 1)
     printf "%d" (g :: Int)::IO()
     printf "\n" ::IO()
     {-
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
-}
     do printf "%d" ((117 `quot` 17) :: Int)::IO()
        printf "\n" ::IO()
        printf "%d" ((117 `quot` (- 17)) :: Int)::IO()
        printf "\n" ::IO()
        printf "%d" (((- 117) `quot` 17) :: Int)::IO()
        printf "\n" ::IO()
        printf "%d" (((- 117) `quot` (- 17)) :: Int)::IO()
        printf "\n" ::IO()
        printf "%d" ((117 `rem` 17) :: Int)::IO()
        printf "\n" ::IO()
        printf "%d" ((117 `rem` (- 17)) :: Int)::IO()
        printf "\n" ::IO()
        printf "%d" (((- 117) `rem` 17) :: Int)::IO()
        printf "\n" ::IO()
        printf "%d" (((- 117) `rem` (- 17)) :: Int)::IO()
        printf "\n" ::IO()


