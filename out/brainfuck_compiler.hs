import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False

(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b


main :: IO ()

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

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
  do let input = ' '
     let current_pos = 500
     ((\ (b, mem) ->
        do return (b)
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           writeIOA mem current_pos =<< ((+) <$> (readIOA mem current_pos) <*> return (1))
           let d = (current_pos + 1)
           writeIOA mem d =<< ((+) <$> (readIOA mem d) <*> return (1))
           writeIOA mem d =<< ((+) <$> (readIOA mem d) <*> return (1))
           writeIOA mem d =<< ((+) <$> (readIOA mem d) <*> return (1))
           writeIOA mem d =<< ((+) <$> (readIOA mem d) <*> return (1))
           writeIOA mem d =<< ((+) <$> (readIOA mem d) <*> return (1))
           writeIOA mem d =<< ((+) <$> (readIOA mem d) <*> return (1))
           writeIOA mem d =<< ((+) <$> (readIOA mem d) <*> return (1))
           writeIOA mem d =<< ((+) <$> (readIOA mem d) <*> return (1))
           writeIOA mem d =<< ((+) <$> (readIOA mem d) <*> return (1))
           writeIOA mem d =<< ((+) <$> (readIOA mem d) <*> return (1))
           let c e =
                 ifM (((/=) <$> (readIOA mem e) <*> return (0)))
                     (do writeIOA mem e =<< ((-) <$> (readIOA mem e) <*> return (1))
                         let f = (e - 1)
                         writeIOA mem f =<< ((+) <$> (readIOA mem f) <*> return (1))
                         printf "%c" =<< (((fmap chr ((readIOA mem f)))) :: IO Char)
                         let g = (f + 1)
                         (c g))
                     (return (())) in
                 (c d)) =<< (array_init_withenv 1000 (\ i () ->
                                                       let a = 0
                                                               in return (((), a))) ()))

