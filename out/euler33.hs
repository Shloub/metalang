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


pgcd a b =
  do let c = (min a b)
     let d = (max a b)
     let reste = d `rem` c
     if reste == 0
     then return c
     else pgcd c reste

main =
  let e i f g =
        if i <= 9
        then let h j l m =
                   if j <= 9
                   then let n k o q =
                              if k <= 9
                              then if i /= j && j /= k
                                   then do let a = i * 10 + j
                                           let b = j * 10 + k
                                           if a * k == i * b
                                           then do printf "%d/%d\n" (a::Int) (b::Int) :: IO()
                                                   let r = q * a
                                                   let s = o * b
                                                   n (k + 1) s r
                                           else n (k + 1) o q
                                   else n (k + 1) o q
                              else h (j + 1) o q in
                              n 1 l m
                   else e (i + 1) l m in
                   h 1 f g
        else do printf "%d/%d\n" (g::Int) (f::Int) :: IO()
                p <- pgcd g f
                printf "pgcd=%d\n%d\n" (p::Int) ((f `quot` p)::Int) :: IO() in
        e 1 1 1


