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


fibo0 a b i =
  do let out0 = 0
     let a2 = a
     let b2 = b
     let d = i + 1
     let c j h k l =
           if j <= d
           then do let m = l + h
                   let tmp = k
                   let n = k + h
                   let o = tmp
                   c (j + 1) o n m
           else return l in
           c 0 a2 b2 out0

main =
  do let a = 0
     let b = 0
     let i = 0
     g <- read_int
     let p = g
     skip_whitespaces
     f <- read_int
     let q = f
     skip_whitespaces
     e <- read_int
     let r = e
     printf "%d" =<< (fibo0 p q r :: IO Int)


