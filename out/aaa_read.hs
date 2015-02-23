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
  do len <- read_int
     skip_whitespaces
     printf "%d" (len :: Int)::IO()
     printf "=len\n" ::IO()
     let m = (len * 2)
     printf "len*2=" ::IO()
     printf "%d" (m :: Int)::IO()
     printf "\n" ::IO()
     let n = (m `quot` 2)
     ((\ (b, tab) ->
        do return (b)
           printf "\n" ::IO()
           ((\ (e, tab2) ->
              do return (e)
                 strlen <- read_int
                 skip_whitespaces
                 printf "%d" (strlen :: Int)::IO()
                 printf "=strlen\n" ::IO()
                 ((\ (g, tab4) ->
                    do return (g)
                       let k = 0
                       let l = (strlen - 1)
                       let h j =
                             (if (j <= l)
                             then do printf "%c" =<< ((readIOA tab4 j) :: IO Char)
                                     (h (j + 1))
                             else return (())) in
                             (h k)) =<< (array_init_withenv strlen (\ toto () ->
                                                                     hGetChar stdin >>= ((\ tmpc ->
                                                                                           do c <- ((fmap ord (return (tmpc))))
                                                                                              printf "%c" (tmpc :: Char)::IO()
                                                                                              printf ":" ::IO()
                                                                                              printf "%d" (c :: Int)::IO()
                                                                                              printf " " ::IO()
                                                                                              o <- (if (tmpc /= ' ')
                                                                                                   then do p <- ((+) <$> (rem <$> ((+) <$> (((-) c) <$> ((fmap ord (return ('a'))))) <*> return (13)) <*> return (26)) <*> ((fmap ord (return ('a')))))
                                                                                                           return (p)
                                                                                                   else return (c))
                                                                                              f <- ((fmap chr (return (o))))
                                                                                              return (((), f))))) ()))) =<< (array_init_withenv n (\ i_ () ->
                                                                                                                                                    do tmpi2 <- read_int
                                                                                                                                                       skip_whitespaces
                                                                                                                                                       printf "%d" (i_ :: Int)::IO()
                                                                                                                                                       printf "==>" ::IO()
                                                                                                                                                       printf "%d" (tmpi2 :: Int)::IO()
                                                                                                                                                       printf " " ::IO()
                                                                                                                                                       let d = tmpi2
                                                                                                                                                       return (((), d))) ()))) =<< (array_init_withenv n (\ i () ->
                                                                                                                                                                                                           do tmpi1 <- read_int
                                                                                                                                                                                                              skip_whitespaces
                                                                                                                                                                                                              printf "%d" (i :: Int)::IO()
                                                                                                                                                                                                              printf "=>" ::IO()
                                                                                                                                                                                                              printf "%d" (tmpi1 :: Int)::IO()
                                                                                                                                                                                                              printf " " ::IO()
                                                                                                                                                                                                              let a = tmpi1
                                                                                                                                                                                                              return (((), a))) ()))
