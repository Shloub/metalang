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
  let a = ((floor . sqrt . fromIntegral) (n * 2))
          in return (a * (a + 1) == n * 2)

score () =
  do skip_whitespaces
     len <- read_int
     skip_whitespaces
     let b i d =
           if i <= len
           then do c <- getChar
                   let e = d + (ord c) - (ord 'A') + 1
                   {-		print c print " " print sum print " " -}
                   b (i + 1) e
           else ifM (is_triangular d)
                    (return 1)
                    (return 0) in
           b 1 0

main =
  let f i =
        if i <= 55
        then ifM (is_triangular i)
                 (do printf "%d " (i::Int) :: IO()
                     f (i + 1))
                 (f (i + 1))
        else do printf "\n" :: IO ()
                n <- read_int
                let g h j =
                      if h <= n
                      then do k <- (((+) j) <$> (score ()))
                              g (h + 1) k
                      else printf "%d\n" (j::Int) :: IO() in
                      g 1 0 in
        f 1


