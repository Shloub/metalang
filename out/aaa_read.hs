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
  do len <- read_int
     skip_whitespaces
     printf "%d" (len :: Int) :: IO ()
     printf "=len\n" :: IO ()
     let l = len * 2
     printf "len*2=" :: IO ()
     printf "%d" (l :: Int) :: IO ()
     printf "\n" :: IO ()
     let m = l `quot` 2
     ((array_init_withenv m (\ i b ->
                              do tmpi1 <- read_int
                                 skip_whitespaces
                                 printf "%d" (i :: Int) :: IO ()
                                 printf "=>" :: IO ()
                                 printf "%d" (tmpi1 :: Int) :: IO ()
                                 printf " " :: IO ()
                                 let a = tmpi1
                                 return ((), a)) ()) >>= (\ (b, tab) ->
                                                           do printf "\n" :: IO ()
                                                              ((array_init_withenv m (\ i_ e ->
                                                                                       do tmpi2 <- read_int
                                                                                          skip_whitespaces
                                                                                          printf "%d" (i_ :: Int) :: IO ()
                                                                                          printf "==>" :: IO ()
                                                                                          printf "%d" (tmpi2 :: Int) :: IO ()
                                                                                          printf " " :: IO ()
                                                                                          let d = tmpi2
                                                                                          return ((), d)) ()) >>= (\ (e, tab2) ->
                                                                                                                    do strlen <- read_int
                                                                                                                       skip_whitespaces
                                                                                                                       printf "%d" (strlen :: Int) :: IO ()
                                                                                                                       printf "=strlen\n" :: IO ()
                                                                                                                       ((array_init_withenv strlen (\ toto g ->
                                                                                                                                                     hGetChar stdin >>= ((\ tmpc ->
                                                                                                                                                                           do c <- ((fmap ord (return tmpc)))
                                                                                                                                                                              printf "%c" (tmpc :: Char) :: IO ()
                                                                                                                                                                              printf ":" :: IO ()
                                                                                                                                                                              printf "%d" (c :: Int) :: IO ()
                                                                                                                                                                              printf " " :: IO ()
                                                                                                                                                                              n <- if tmpc /= ' '
                                                                                                                                                                                   then do o <- ((+) <$> (rem <$> (((+) 13) <$> (((-) c) <$> ((fmap ord (return 'a'))))) <*> return 26) <*> ((fmap ord (return 'a'))))
                                                                                                                                                                                           return o
                                                                                                                                                                                   else return c
                                                                                                                                                                              f <- ((fmap chr (return n)))
                                                                                                                                                                              return ((), f)))) ()) >>= (\ (g, tab4) ->
                                                                                                                                                                                                          do let k = strlen - 1
                                                                                                                                                                                                             let h j =
                                                                                                                                                                                                                   if j <= k
                                                                                                                                                                                                                   then do printf "%c" =<< ((readIOA tab4 j) :: IO Char)
                                                                                                                                                                                                                           (h (j + 1))
                                                                                                                                                                                                                   else return () in
                                                                                                                                                                                                                   (h 0)))))))


