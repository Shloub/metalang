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

is_leap year =
  return ((((year `rem` 400) == 0) || (((year `rem` 100) /= 0) && ((year `rem` 4) == 0))))
ndayinmonth month year =
  do let a () = return (0)
     (if (month == 0)
     then return (31)
     else do let b () = (a ())
             (if (month == 1)
             then do let c () = (b ())
                     ifM ((is_leap year))
                         (return (29))
                         (return (28))
             else do let d () = (b ())
                     (if (month == 2)
                     then return (31)
                     else do let e () = (d ())
                             (if (month == 3)
                             then return (30)
                             else do let f () = (e ())
                                     (if (month == 4)
                                     then return (31)
                                     else do let g () = (f ())
                                             (if (month == 5)
                                             then return (30)
                                             else do let h () = (g ())
                                                     (if (month == 6)
                                                     then return (31)
                                                     else do let i () = (h ())
                                                             (if (month == 7)
                                                             then return (31)
                                                             else do let j () = (i ())
                                                                     (if (month == 8)
                                                                     then return (30)
                                                                     else do let k () = (j ())
                                                                             (if (month == 9)
                                                                             then return (31)
                                                                             else do let l () = (k ())
                                                                                     (if (month == 10)
                                                                                     then return (30)
                                                                                     else (if (month == 11)
                                                                                          then return (31)
                                                                                          else (l ())))))))))))))
main =
  do let month = 0
     let year = 1901
     let dayofweek = 1
     {- 01-01-1901 : mardi -}
     do let count = 0
        let m n o p q =
              (if (q /= 2001)
              then do ndays <- (ndayinmonth p q)
                      let r = ((o + ndays) `rem` 7)
                      let s = (p + 1)
                      ((\ (t, u) ->
                         do let v = (if ((r `rem` 7) == 6)
                                    then let w = (n + 1)
                                                 in w
                                    else n)
                            (m v r t u)) (if (s == 12)
                                         then let x = 0
                                                      in let y = (q + 1)
                                                                 in (x, y)
                                         else (s, q)))
              else do printf "%d" (n :: Int)::IO()
                      printf "\n" ::IO()) in
              (m count dayofweek month year)

