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
                                                                                                                                                                                                                                                                        

devine0 nombre tab len =
  do min0 <- (readIOA tab 0)
     max0 <- (readIOA tab 1)
     let c = (len - 1)
     let b i f g =
           (if (i <= c)
           then ifM ((((>) <$> (readIOA tab i) <*> return (f)) <||> ((<) <$> (readIOA tab i) <*> return (g))))
                    (return (False))
                    (do h <- ifM (((<) <$> (readIOA tab i) <*> return (nombre)))
                                 (do j <- (readIOA tab i)
                                     return (j))
                                 (return (g))
                        k <- ifM (((>) <$> (readIOA tab i) <*> return (nombre)))
                                 (do l <- (readIOA tab i)
                                     return (l))
                                 (return (f))
                        ifM ((((==) <$> (readIOA tab i) <*> return (nombre)) <&&> return ((len /= (i + 1)))))
                            (return (False))
                            ((b (i + 1) k h)))
           else return (True)) in
           (b 2 max0 min0)

main =
  do nombre <- read_int
     skip_whitespaces
     len <- read_int
     skip_whitespaces
     ((\ (e, tab) ->
        do a <- (devine0 nombre tab len)
           (if a
           then printf "True" ::IO()
           else printf "False" ::IO())) =<< (array_init_withenv len (\ i e ->
                                                                      do tmp <- read_int
                                                                         skip_whitespaces
                                                                         let d = tmp
                                                                         return (((), d))) ()))


