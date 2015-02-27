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


skip_whitespaces :: IO ()
skip_whitespaces =
  ifM (hIsEOF stdin)
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do hGetChar stdin
              skip_whitespaces
           else return ())
read_int_a :: Int -> IO Int
read_int_a b =
  ifM (hIsEOF stdin)
      (return b)
      (do c <- hLookAhead stdin
          if c >= '0' && c <= '9' then
           do hGetChar stdin
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      num <- read_int_a 0
      return (num * sign)
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f =
  do li <- g 0
     newListArray (0, len - 1) li
  where g i =
           if i == len
           then return []
           else do item <- f i
                   li <- g (i+1)
                   return (item:li)
                                                            

copytab tab len =
  do o <- array_init len (\ i ->
                           readIOA tab i)
     return o

bubblesort tab len =
  do let e = len - 1
     let b i =
           if i <= e
           then do let d = len - 1
                   let c j =
                         if j <= d
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
  then do let i0 = i
          let j0 = j
          {- pivot : tab[0] -}
          let a s t =
                if s /= t
                then ifM ((>) <$> (readIOA tab s) <*> (readIOA tab t))
                         (if s == t - 1
                          then {- on inverse simplement-}
                               do tmp <- readIOA tab s
                                  writeIOA tab s =<< (readIOA tab t)
                                  writeIOA tab t tmp
                                  let u = s + 1
                                  a u t
                          else {- on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] -}
                               do tmp <- readIOA tab s
                                  writeIOA tab s =<< (readIOA tab t)
                                  writeIOA tab t =<< (readIOA tab (s + 1))
                                  writeIOA tab (s + 1) tmp
                                  let v = s + 1
                                  a v t)
                         (do let w = t - 1
                             a s w)
                else do qsort0 tab len i0 (s - 1)
                        qsort0 tab len (s + 1) j0
                        return () in
                a i j
  else return ()

main =
  do let len = 2
     r <- read_int
     let x = r
     skip_whitespaces
     tab <- array_init x (\ i_ ->
                           do let tmp = 0
                              q <- read_int
                              let y = q
                              skip_whitespaces
                              return y)
     tab2 <- copytab tab x
     bubblesort tab2 x
     let p = x - 1
     let n i =
           if i <= p
           then do printf "%d" =<< (readIOA tab2 i :: IO Int)
                   printf " " :: IO ()
                   n (i + 1)
           else do printf "\n" :: IO ()
                   tab3 <- copytab tab x
                   qsort0 tab3 x 0 (x - 1)
                   let m = x - 1
                   let l z =
                         if z <= m
                         then do printf "%d" =<< (readIOA tab3 z :: IO Int)
                                 printf " " :: IO ()
                                 l (z + 1)
                         else printf "\n" :: IO () in
                         l 0 in
           n 0


