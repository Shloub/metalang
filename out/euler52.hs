import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

(<&&>) a b =
	do c <- a
	   if c then b
		 else return False
(<||>) a b =
	do c <- a
	   if c then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e

main :: IO ()
chiffre_sort a =
  if a < 10
  then return a
  else do b <- chiffre_sort (a `quot` 10)
          let c = a `rem` 10
          let d = b `rem` 10
          let e = b `quot` 10
          if c < d
          then return (c + b * 10)
          else (((+) d) <$> (((*) 10) <$> (chiffre_sort (c + e * 10))))

same_numbers a b c d e f =
  do ca <- chiffre_sort a
     (((((((==) ca) <$> (chiffre_sort b)) <&&> (((==) ca) <$> (chiffre_sort c))) <&&> (((==) ca) <$> (chiffre_sort d))) <&&> (((==) ca) <$> (chiffre_sort e))) <&&> (((==) ca) <$> (chiffre_sort f)))

main =
  ifM (same_numbers 142857 (142857 * 2) (142857 * 3) (142857 * 4) (142857 * 6) (142857 * 5))
      ((printf "%d %d %d %d %d %d\n" (142857::Int) ((142857 * 2)::Int) ((142857 * 3)::Int) ((142857 * 4)::Int) ((142857 * 5)::Int) ((142857 * 6)::Int)) :: IO())
      (return ())


