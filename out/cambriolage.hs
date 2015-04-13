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
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()

nbPassePartout n passepartout m serrures =
  let c i d e =
        if i <= m - 1
        then do r <- ifM ((((==) (- 1)) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 0)) <&&> (((<) d) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 1)))
                         (join $ readIOA <$> (readIOA serrures i) <*> return 1)
                         (return d)
                ifM ((((==) 1) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 0)) <&&> (((<) e) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 1)))
                    (do s <- join $ readIOA <$> (readIOA serrures i) <*> return 1
                        c (i + 1) r s)
                    (c (i + 1) r e)
        else let f g h o =
                   if g <= n - 1
                   then do pp <- readIOA passepartout g
                           ifM ((((<=) d) <$> (readIOA pp 0)) <&&> (((<=) e) <$> (readIOA pp 1)))
                               (return 1)
                               (do p <- ((max <$> (return h) <*> (readIOA pp 0)))
                                   q <- ((max <$> (return o) <*> (readIOA pp 1)))
                                   f (g + 1) p q)
                   else return (if h >= d && o >= e
                                then 2
                                else 0) in
                   f 0 0 0 in
        c 0 0 0

main =
  do n <- read_int
     skip_whitespaces
     passepartout <- array_init n (\ i ->
                                     array_init 2 (\ j ->
                                                     do out01 <- read_int
                                                        skip_whitespaces
                                                        return out01))
     m <- read_int
     skip_whitespaces
     serrures <- array_init m (\ k ->
                                 array_init 2 (\ l ->
                                                 do out_ <- read_int
                                                    skip_whitespaces
                                                    return out_))
     printf "%d" =<< (nbPassePartout n passepartout m serrures :: IO Int)


