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
triangle n =
  return (if (n `rem` 2) == 0
          then (n `quot` 2) * (n + 1)
          else n * ((n + 1) `quot` 2))

penta n =
  return (if (n `rem` 2) == 0
          then (n `quot` 2) * (3 * n - 1)
          else ((3 * n - 1) `quot` 2) * n)

hexa n =
  return (n * (2 * n - 1))

findPenta2 n a b =
  if b == a + 1
  then ((((==) n) <$> (penta a)) <||> (((==) n) <$> (penta b)))
  else do let c = (a + b) `quot` 2
          p <- penta c
          if p == n
          then return True
          else if p < n
               then findPenta2 n c b
               else findPenta2 n a c

findHexa2 n a b =
  if b == a + 1
  then ((((==) n) <$> (hexa a)) <||> (((==) n) <$> (hexa b)))
  else do let c = (a + b) `quot` 2
          p <- hexa c
          if p == n
          then return True
          else if p < n
               then findHexa2 n c b
               else findHexa2 n a c

main =
  let d n =
        if n <= 55385
        then do t <- triangle n
                ifM ((findPenta2 t (n `quot` 5) n) <&&> (findHexa2 t (n `quot` 5) ((n `quot` 2) + 10)))
                    (do printf "%d\n%d\n" (n::Int) (t::Int) :: IO()
                        d (n + 1))
                    (d (n + 1))
        else return () in
        d 285


