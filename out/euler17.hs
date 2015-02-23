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
  do let one = 3
     let two = 3
     let three = 5
     let four = 4
     let five = 4
     let six = 3
     let seven = 5
     let eight = 5
     let nine = 4
     let ten = 3
     let eleven = 6
     let twelve = 6
     let thirteen = 8
     let fourteen = 8
     let fifteen = 7
     let sixteen = 7
     let seventeen = 9
     let eighteen = 8
     let nineteen = 8
     let twenty = 6
     let thirty = 6
     let forty = 5
     let fifty = 5
     let sixty = 5
     let seventy = 7
     let eighty = 6
     let ninety = 6
     let hundred = 7
     let thousand = 8
     printf "%d" (((((one + two) + three) + four) + five) :: Int)::IO()
     printf "\n" ::IO()
     let hundred_and = 10
     let one_to_nine = ((((((((one + two) + three) + four) + five) + six) + seven) + eight) + nine)
     printf "%d" (one_to_nine :: Int)::IO()
     printf "\n" ::IO()
     let one_to_ten = (one_to_nine + ten)
     let one_to_twenty = ((((((((((one_to_ten + eleven) + twelve) + thirteen) + fourteen) + fifteen) + sixteen) + seventeen) + eighteen) + nineteen) + twenty)
     let one_to_thirty = (((one_to_twenty + (twenty * 9)) + one_to_nine) + thirty)
     let one_to_forty = (((one_to_thirty + (thirty * 9)) + one_to_nine) + forty)
     let one_to_fifty = (((one_to_forty + (forty * 9)) + one_to_nine) + fifty)
     let one_to_sixty = (((one_to_fifty + (fifty * 9)) + one_to_nine) + sixty)
     let one_to_seventy = (((one_to_sixty + (sixty * 9)) + one_to_nine) + seventy)
     let one_to_eighty = (((one_to_seventy + (seventy * 9)) + one_to_nine) + eighty)
     let one_to_ninety = (((one_to_eighty + (eighty * 9)) + one_to_nine) + ninety)
     let one_to_ninety_nine = ((one_to_ninety + (ninety * 9)) + one_to_nine)
     printf "%d" (one_to_ninety_nine :: Int)::IO()
     printf "\n" ::IO()
     printf "%d" (((((((100 * one_to_nine) + (one_to_ninety_nine * 10)) + ((hundred_and * 9) * 99)) + (hundred * 9)) + one) + thousand) :: Int)::IO()
     printf "\n" ::IO()

