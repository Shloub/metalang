import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False

(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

main :: IO ()



max2_ a b =
  return (if (a > b)
         then a
         else b)

chiffre c m =
  (if (c == 0)
  then return (m `rem` 10)
  else (chiffre (c - 1) (m `quot` 10)))

main =
  do let m = 1
     let g a n =
           (if (a <= 9)
           then let h f o =
                      (if (f <= 9)
                      then let i d p =
                                 (if (d <= 9)
                                 then let j c q =
                                            (if (c <= 9)
                                            then let k b r =
                                                       (if (b <= 9)
                                                       then let l e s =
                                                                  (if (e <= 9)
                                                                  then do let mul = (((((a * d) + (10 * ((a * e) + (b * d)))) + (100 * (((a * f) + (b * e)) + (c * d)))) + (1000 * ((c * e) + (b * f)))) + ((10000 * c) * f))
                                                                          ifM ((((==) <$> (chiffre 0 mul) <*> (chiffre 5 mul)) <&&> ((==) <$> (chiffre 1 mul) <*> (chiffre 4 mul))) <&&> ((==) <$> (chiffre 2 mul) <*> (chiffre 3 mul)))
                                                                              (do t <- (max2_ mul s)
                                                                                  (l (e + 1) t))
                                                                              ((l (e + 1) s))
                                                                  else (k (b + 1) s)) in
                                                                  (l 0 r)
                                                       else (j (c + 1) r)) in
                                                       (k 0 q)
                                            else (i (d + 1) q)) in
                                            (j 1 p)
                                 else (h (f + 1) p)) in
                                 (i 0 o)
                      else (g (a + 1) o)) in
                      (h 1 n)
           else do printf "%d" (n :: Int)::IO()
                   printf "\n" ::IO()) in
           (g 0 m)


