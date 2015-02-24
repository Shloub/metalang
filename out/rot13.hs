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

array_init_withenv :: Int -> ( Int -> env -> IO(env, tabcontent)) -> env -> IO(env, IOArray Int tabcontent)
array_init_withenv len f env =
  do (env, li) <- g 0 env
     o <- newListArray (0, len - 1) li
     return (env, o)
  where g i env =
           if i == len
           then return (env, [])
           else do (env', item) <- f i env
                   (env'', li) <- g (i+1) env'
                   return (env'', item:li)
                                                                                                                                                                                                                                                                         



main =
  do strlen <- read_int
     skip_whitespaces
     ((array_init_withenv strlen (\ toto b ->
                                   hGetChar stdin >>= ((\ tmpc ->
                                                         do c <- ((fmap ord (return tmpc)))
                                                            f <- (if (tmpc /= ' ')
                                                                 then do g <- ((+) <$> (rem <$> (((+) 13) <$> (((-) c) <$> ((fmap ord (return 'a'))))) <*> return 26) <*> ((fmap ord (return 'a'))))
                                                                         return g
                                                                 else return c)
                                                            a <- ((fmap chr (return f)))
                                                            return ((), a)))) ()) >>= (\ (b, tab4) ->
                                                                                        do let e = (strlen - 1)
                                                                                           let d j =
                                                                                                 (if (j <= e)
                                                                                                 then do printf "%c" =<< ((readIOA tab4 j) :: IO Char)
                                                                                                         (d (j + 1))
                                                                                                 else return ()) in
                                                                                                 (d 0)))


