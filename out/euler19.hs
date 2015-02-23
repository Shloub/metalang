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
  (if (month == 0)
  then return (31)
  else (if (month == 1)
       then ifM ((is_leap year))
                (return (29))
                (return (28))
       else return ((if (month == 2)
                    then 31
                    else (if (month == 3)
                         then 30
                         else (if (month == 4)
                              then 31
                              else (if (month == 5)
                                   then 30
                                   else (if (month == 6)
                                        then 31
                                        else (if (month == 7)
                                             then 31
                                             else (if (month == 8)
                                                  then 30
                                                  else (if (month == 9)
                                                       then 31
                                                       else (if (month == 10)
                                                            then 30
                                                            else (if (month == 11)
                                                                 then 31
                                                                 else 0)))))))))))))
main =
  do let month = 0
     let year = 1901
     let dayofweek = 1
     {- 01-01-1901 : mardi -}
     do let count = 0
        let a b c d e =
              (if (e /= 2001)
              then do ndays <- (ndayinmonth d e)
                      let f = ((c + ndays) `rem` 7)
                      let g = (d + 1)
                      ((\ (h, i) ->
                         (if ((f `rem` 7) == 6)
                         then do let j = (b + 1)
                                 (a j f h i)
                         else (a b f h i))) (if (g == 12)
                                            then let k = 0
                                                         in let l = (e + 1)
                                                                    in (k, l)
                                            else (g, e)))
              else do printf "%d" (b :: Int)::IO()
                      printf "\n" ::IO()) in
              (a count dayofweek month year)

