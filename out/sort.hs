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
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
copytab tab len =
  do o <- array_init len (\ i ->
                            readIOA tab i)
     return o

bubblesort tab len =
  let b i =
        if i <= len - 1
        then let c j =
                   if j <= len - 1
                   then ifM ((>) <$> (readIOA tab i) <*> (readIOA tab j))
                            (do tmp <- readIOA tab i
                                writeIOA tab i =<< (readIOA tab j)
                                writeIOA tab j tmp
                                c (j + 1))
                            (c (j + 1))
                   else b (i + 1) in
                   c (i + 1)
        else return () in
        b 0

qsort0 tab len i j =
  if i < j
  then {- pivot : tab[0] -}
       let a n p =
             if n /= p
             then ifM ((>) <$> (readIOA tab n) <*> (readIOA tab p))
                      (if n == p - 1
                       then {- on inverse simplement-}
                            do tmp <- readIOA tab n
                               writeIOA tab n =<< (readIOA tab p)
                               writeIOA tab p tmp
                               let q = n + 1
                               a q p
                       else {- on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] -}
                            do tmp <- readIOA tab n
                               writeIOA tab n =<< (readIOA tab p)
                               writeIOA tab p =<< (readIOA tab (n + 1))
                               writeIOA tab (n + 1) tmp
                               let r = n + 1
                               a r p)
                      (do let s = p - 1
                          a n s)
             else do qsort0 tab len i (n - 1)
                     qsort0 tab len (n + 1) j
                     return () in
             a i j
  else return ()

main =
  do m <- read_int
     skip_whitespaces
     tab <- array_init m (\ i_ ->
                            do l <- read_int
                               skip_whitespaces
                               return l)
     tab2 <- copytab tab m
     bubblesort tab2 m
     let k i =
           if i <= m - 1
           then do printf "%d " =<< ((readIOA tab2 i)::IO Int)
                   k (i + 1)
           else do printf "\n" :: IO ()
                   tab3 <- copytab tab m
                   qsort0 tab3 m 0 (m - 1)
                   let h v =
                         if v <= m - 1
                         then do printf "%d " =<< ((readIOA tab3 v)::IO Int)
                                 h (v + 1)
                         else printf "\n" :: IO () in
                         h 0 in
           k 0


