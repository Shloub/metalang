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

max2_ a b =
  let h () = ()
             in return ((if (a > b)
                        then a
                        else b))
chiffre c m =
  do let g () = return (())
     (if (c == 0)
     then return ((m `rem` 10))
     else (chiffre (c - 1) (m `quot` 10)))
main =
  do let m = 1
     let z = 0
     let ba = 9
     let i a bb =
           (if (a <= ba)
           then do let x = 1
                   let y = 9
                   let j f bc =
                         (if (f <= y)
                         then do let v = 0
                                 let w = 9
                                 let k d bd =
                                       (if (d <= w)
                                       then do let t = 1
                                               let u = 9
                                               let l c be =
                                                     (if (c <= u)
                                                     then do let r = 0
                                                             let s = 9
                                                             let n b bf =
                                                                   (if (b <= s)
                                                                   then do let p = 0
                                                                           let q = 9
                                                                           let o e bg =
                                                                                 (if (e <= q)
                                                                                 then do let mul = (((((a * d) + (10 * ((a * e) + (b * d)))) + (100 * (((a * f) + (b * e)) + (c * d)))) + (1000 * ((c * e) + (b * f)))) + ((10000 * c) * f))
                                                                                         bh <- ifM (((((==) <$> (chiffre 0 mul) <*> (chiffre 5 mul)) <&&> ((==) <$> (chiffre 1 mul) <*> (chiffre 4 mul))) <&&> ((==) <$> (chiffre 2 mul) <*> (chiffre 3 mul))))
                                                                                                   (do bi <- (max2_ mul bg)
                                                                                                       return (bi))
                                                                                                   (return (bg))
                                                                                         (o (e + 1) bh)
                                                                                 else (n (b + 1) bg)) in
                                                                                 (o p bf)
                                                                   else (l (c + 1) bf)) in
                                                                   (n r be)
                                                     else (k (d + 1) be)) in
                                                     (l t bd)
                                       else (j (f + 1) bd)) in
                                       (k v bc)
                         else (i (a + 1) bc)) in
                         (j x bb)
           else do printf "%d" (bb :: Int)::IO()
                   printf "\n" ::IO()) in
           (i z m)

