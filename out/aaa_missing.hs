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



result len tab =
  ((\ (d, tab2) ->
     do let h = (len - 1)
        let g i1 =
              (if (i1 <= h)
              then do printf "%d" =<< ((readIOA tab i1) :: IO Int)
                      printf " " ::IO()
                      join (writeIOA tab2 <$> (readIOA tab i1) <*> return (True))
                      (g (i1 + 1))
              else do printf "\n" ::IO()
                      let f = (len - 1)
                      let e i2 =
                            (if (i2 <= f)
                            then ifM ((fmap (not) (readIOA tab2 i2)))
                                     (return (i2))
                                     ((e (i2 + 1)))
                            else return ((- 1))) in
                            (e 0)) in
              (g 0)) =<< (array_init_withenv len (\ i d ->
                                                   let c = False
                                                           in return (((), c))) ()))
main =
  do len <- read_int
     skip_whitespaces
     printf "%d" (len :: Int)::IO()
     printf "\n" ::IO()
     ((\ (k, tab) ->
        do printf "%d" =<< ((result len tab) :: IO Int)
           printf "\n" ::IO()) =<< (array_init_withenv len (\ a k ->
                                                             do b <- read_int
                                                                skip_whitespaces
                                                                let j = b
                                                                return (((), j))) ()))

