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
max2_ a b =
  return (if a > b
          then a
          else b)

nbPassePartout n passepartout m serrures =
  do let max_ancient = 0
     let max_recent = 0
     let f = m - 1
     let e i u v =
           if i <= f
           then do w <- ifM ((((==) (- 1)) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 0)) <&&> (((<) u) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 1)))
                            (do x <- join $ readIOA <$> (readIOA serrures i) <*> return 1
                                return x)
                            (return u)
                   ifM ((((==) 1) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 0)) <&&> (((<) v) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 1)))
                       (do y <- join $ readIOA <$> (readIOA serrures i) <*> return 1
                           e (i + 1) w y)
                       (e (i + 1) w v)
           else do let max_ancient_pp = 0
                   let max_recent_pp = 0
                   let d = n - 1
                   let c z ba bb =
                         if z <= d
                         then do pp <- readIOA passepartout z
                                 ifM ((((<=) u) <$> (readIOA pp 0)) <&&> (((<=) v) <$> (readIOA pp 1)))
                                     (return 1)
                                     (do bc <- max2_ ba =<< (readIOA pp 0)
                                         bd <- max2_ bb =<< (readIOA pp 1)
                                         c (z + 1) bc bd)
                         else return (if ba >= u && bb >= v
                                      then 2
                                      else 0) in
                         c 0 max_ancient_pp max_recent_pp in
           e 0 max_ancient max_recent

main =
  do n <- read_int
     skip_whitespaces
     passepartout <- array_init n (\ i ->
                                    do out0 <- array_init 2 (\ j ->
                                                              do out01 <- read_int
                                                                 skip_whitespaces
                                                                 return out01)
                                       return out0)
     m <- read_int
     skip_whitespaces
     serrures <- array_init m (\ k ->
                                do out1 <- array_init 2 (\ l ->
                                                          do out_ <- read_int
                                                             skip_whitespaces
                                                             return out_)
                                   return out1)
     printf "%d" =<< (nbPassePartout n passepartout m serrures :: IO Int)


