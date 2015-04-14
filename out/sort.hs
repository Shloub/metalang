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
  array_init len (\ i ->
                    readIOA tab i)

bubblesort tab len =
  let a i =
        if i <= len - 1
        then let b j =
                   if j <= len - 1
                   then ifM ((>) <$> (readIOA tab i) <*> (readIOA tab j))
                            (do tmp <- readIOA tab i
                                writeIOA tab i =<< (readIOA tab j)
                                writeIOA tab j tmp
                                b (j + 1))
                            (b (j + 1))
                   else a (i + 1) in
                   b (i + 1)
        else return () in
        a 0

qsort0 tab len i j =
  if i < j
  then {- pivot : tab[0] -}
       let c d e =
             if d /= e
             then ifM ((>) <$> (readIOA tab d) <*> (readIOA tab e))
                      (if d == e - 1
                       then {- on inverse simplement-}
                            do tmp <- readIOA tab d
                               writeIOA tab d =<< (readIOA tab e)
                               writeIOA tab e tmp
                               let h = d + 1
                               c h e
                       else {- on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] -}
                            do tmp <- readIOA tab d
                               writeIOA tab d =<< (readIOA tab e)
                               writeIOA tab e =<< (readIOA tab (d + 1))
                               writeIOA tab (d + 1) tmp
                               let g = d + 1
                               c g e)
                      (do let f = e - 1
                          c d f)
             else do qsort0 tab len i (d - 1)
                     qsort0 tab len (d + 1) j
                     return () in
             c i j
  else return ()

main =
  do k <- read_int
     skip_whitespaces
     tab <- array_init k (\ i_ ->
                            do p <- read_int
                               skip_whitespaces
                               return p)
     tab2 <- copytab tab k
     bubblesort tab2 k
     let l i =
           if i <= k - 1
           then do printf "%d " =<< ((readIOA tab2 i)::IO Int)
                   l (i + 1)
           else do printf "\n" :: IO ()
                   tab3 <- copytab tab k
                   qsort0 tab3 k 0 (k - 1)
                   let m n =
                         if n <= k - 1
                         then do printf "%d " =<< ((readIOA tab3 n)::IO Int)
                                 m (n + 1)
                         else printf "\n" :: IO () in
                         m 0 in
           l 0


