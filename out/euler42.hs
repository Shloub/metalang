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
skip_whitespaces :: IO ()
skip_whitespaces =
  ifM isEOF
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do getChar
              skip_whitespaces
           else return ())
read_int_a :: Int -> IO Int
read_int_a b =
  ifM isEOF
      (return b)
      (do c <- hLookAhead stdin
          if isNumber c then
           do getChar
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      (* sign) <$> read_int_a 0

main :: IO ()


is_triangular n =
  {-
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   -}
  do a <- ((fmap (floor . sqrt . fromIntegral) (return (n * 2))))
     return (a * (a + 1) == n * 2)

score () =
  do skip_whitespaces
     len <- read_int
     skip_whitespaces
     let sum = 0
     let b i f =
           if i <= len
           then hGetChar stdin >>= ((\ c ->
                                      do g <- (((+) f) <$> (((+) 1) <$> ((-) <$> ((fmap ord (return c))) <*> ((fmap ord (return 'A'))))))
                                         {-		print c print " " print sum print " " -}
                                         b (i + 1) g))
           else ifM (is_triangular f)
                    (return 1)
                    (return 0) in
           b 1 sum

main =
  let e i =
        if i <= 55
        then ifM (is_triangular i)
                 (do printf "%d" (i :: Int) :: IO ()
                     printf " " :: IO ()
                     e (i + 1))
                 (e (i + 1))
        else do printf "\n" :: IO ()
                let sum = 0
                n <- read_int
                let d h j =
                      if h <= n
                      then do k <- (((+) j) <$> (score ()))
                              d (h + 1) k
                      else do printf "%d" (j :: Int) :: IO ()
                              printf "\n" :: IO () in
                      d 1 sum in
        e 1


