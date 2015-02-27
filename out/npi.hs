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
                                                            


is_number c =
  (((<=) <$> ((fmap ord (return c))) <*> ((fmap ord (return '9')))) <&&> ((>=) <$> ((fmap ord (return c))) <*> ((fmap ord (return '0')))))

npi0 str len =
  do stack <- array_init len (\ i ->
                               return 0)
     let ptrStack = 0
     let ptrStr = 0
     let d k l =
           if l < len
           then ifM (((==) ' ') <$> (readIOA str l))
                    (do let m = l + 1
                        d k m)
                    (ifM ((readIOA str l) >>= is_number)
                         (do let num = 0
                             let e n o =
                                   ifM (((/=) ' ') <$> (readIOA str o))
                                       (do p <- ((-) <$> (((+) (n * 10)) <$> ((fmap ord (readIOA str o)))) <*> ((fmap ord (return '0'))))
                                           let q = o + 1
                                           e p q)
                                       (do writeIOA stack k n
                                           let r = k + 1
                                           d r o) in
                                   e num l)
                         (ifM (((==) '+') <$> (readIOA str l))
                              (do writeIOA stack (k - 2) =<< ((+) <$> (readIOA stack (k - 2)) <*> (readIOA stack (k - 1)))
                                  let s = k - 1
                                  let t = l + 1
                                  d s t)
                              (d k l)))
           else readIOA stack 0 in
           d ptrStack ptrStr

main =
  do let len = 0
     j <- read_int
     let u = j
     skip_whitespaces
     tab <- array_init u (\ i ->
                           do let tmp = '\000'
                              hGetChar stdin >>= ((\ h ->
                                                    let v = h
                                                            in return v)))
     result <- npi0 tab u
     printf "%d" (result :: Int) :: IO ()


