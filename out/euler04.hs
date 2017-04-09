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
chiffre c m =
  if c == 0
  then return (m `rem` 10)
  else chiffre (c - 1) (m `quot` 10)

main =
  let g a h =
        if a <= 9
        then let i f j =
                   if f <= 9
                   then let k d l =
                              if d <= 9
                              then let n c o =
                                         if c <= 9
                                         then let p b q =
                                                    if b <= 9
                                                    then let r e s =
                                                               if e <= 9
                                                               then do let mul = a * d + 10 * (a * e + b * d) + 100 * (a * f + b * e + c * d) + 1000 * (c * e + b * f) + 10000 * c * f
                                                                       ifM ((((==) <$> (chiffre 0 mul) <*> (chiffre 5 mul)) <&&> ((==) <$> (chiffre 1 mul) <*> (chiffre 4 mul))) <&&> ((==) <$> (chiffre 2 mul) <*> (chiffre 3 mul)))
                                                                           (do let t = (max mul s)
                                                                               r (e + 1) t)
                                                                           (r (e + 1) s)
                                                               else p (b + 1) s in
                                                               r 0 q
                                                    else n (c + 1) q in
                                                    p 0 o
                                         else k (d + 1) o in
                                         n 1 l
                              else i (f + 1) l in
                              k 0 j
                   else g (a + 1) j in
                   i 1 h
        else printf "%d\n" (h::Int) :: IO() in
        g 0 1


