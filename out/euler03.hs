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

main =
  do let maximum = 1
     let b0 = 2
     let a = 408464633
     sqrtia <- ((fmap (floor . sqrt . fromIntegral) (return (a))))
     let d f g h =
           (if (f /= 1)
           then do let b = g
                   let found = False
                   let e i j k l m =
                         (if (j <= m)
                         then ((\ (n, o, p, q, r) ->
                                 do let s = (o + 1)
                                    (e n s p q r)) =<< (if ((i `rem` j) == 0)
                                                       then do let t = (i `quot` j)
                                                               let u = j
                                                               let v = t
                                                               w <- ((fmap (floor . sqrt . fromIntegral) (return (t))))
                                                               let x = True
                                                               return ((t, v, u, x, w))
                                                       else return ((i, j, k, l, m))))
                         else (if (not l)
                              then do printf "%d" (i :: Int)::IO()
                                      printf "\n" ::IO()
                                      let y = 1
                                      (d y k m)
                              else (d i k m))) in
                         (e f b g found h)
           else return (())) in
           (d a b0 sqrtia)

