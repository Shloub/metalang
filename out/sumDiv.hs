import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False

(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b


main :: IO ()

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

skip_whitespaces :: IO ()
skip_whitespaces =
  ifM (hIsEOF stdin)
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do hGetChar stdin
              skip_whitespaces
           else return ())

read_int_a :: Int -> IO Int
read_int_a b =
  ifM (hIsEOF stdin)
      (return b)
      (do c <- hLookAhead stdin
          if c >= '0' && c <= '9' then
           do hGetChar stdin
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      num <- read_int_a 0
      return (num * sign)

foo () =
  let a = 0
          in return ({- test -}
                     let d = (a + 1)
                             in {- test 2 -}
                                ())
foo2 () =
  return (())
foo3 () =
  return ((if (1 == 1)
          then ()
          else ()))
sumdiv n =
  {- On désire renvoyer la somme des diviseurs -}
  do let out0 = 0
     {- On déclare un entier qui contiendra la somme -}
     let b i e =
           (if (i <= n)
           then {- La boucle : i est le diviseur potentiel-}
                (if ((n `rem` i) == 0)
                then {- Si i divise -}
                     do let f = (e + i)
                        {- On incrémente -}
                        (b (i + 1) f)
                else {- nop -}
                     (b (i + 1) e))
           else return (e)) in
           (b 1 out0)
main =
  {- Programme principal -}
  do let n = 0
     c <- read_int
     let g = c
     {- Lecture de l'entier -}
     printf "%d" =<< ((sumdiv g) :: IO Int)

