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
read_int_a :: Int -> IO Int
read_int_a b =
  ifM isEOF
      (return b)
      (do c <- hLookAhead stdin
          if isNumber c then
           do getChar
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      (* sign) <$> read_int_a 0

main :: IO ()
foo () =
  {- test -}
  let b = 0 + 1
          in {- test 2 -}
             return ()

foo2 () =
  return ()

foo3 () =
  return (if 1 == 1
          then ()
          else ())

sumdiv n =
  {- On désire renvoyer la somme des diviseurs -}
  {- On déclare un entier qui contiendra la somme -}
  let c i d =
        if i <= n
        then {- La boucle : i est le diviseur potentiel-}
             if (n `rem` i) == 0
             then {- Si i divise -}
                  do let e = d + i
                     {- On incrémente -}
                     c (i + 1) e
             else {- nop -}
                  c (i + 1) d
        else return d in
        c 1 0

main =
  {- Programme principal -}
  do f <- read_int
     {- Lecture de l'entier -}
     printf "%d" =<< (sumdiv f :: IO Int)


