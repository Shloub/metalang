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
     ((\ (h, tab1) ->
        do return (h)
           let bb = 0
           let bc = (len - 1)
           let ba i =
                  (if (i <= bc)
                  then do printf "%d" (i :: Int)::IO()
                          printf "=>" ::IO()
                          printf "%d" =<< ((readIOA tab1 i) :: IO Int)
                          printf "\n" ::IO()
                          (ba (i + 1))
                  else do w <- read_int
                          let bd = w
                          skip_whitespaces
                          ((\ (l, tab2) ->
                             do return (l)
                                let u = 0
                                let v = (bd - 2)
                                let p be =
                                      (if (be <= v)
                                      then do let r = 0
                                              let s = (bd - 1)
                                              let q j =
                                                    (if (j <= s)
                                                    then do printf "%d" =<< (join (readIOA <$> (readIOA tab2 be) <*> return (j)) :: IO Int)
                                                            printf " " ::IO()
                                                            (q (j + 1))
                                                    else do printf "\n" ::IO()
                                                            (p (be + 1))) in
                                                    (q r)
                                      else return (())) in
                                      (p u)) =<< (array_init_withenv (bd - 1) (\ c () ->
                                                                                ((\ (o, e) ->
                                                                                   do return (o)
                                                                                      let k = e
                                                                                      return (((), k))) =<< (array_init_withenv bd (\ f () ->
                                                                                                                                     do d <- read_int
                                                                                                                                        skip_whitespaces
                                                                                                                                        let m = d
                                                                                                                                        return (((), m))) ()))) ()))) in
                  (ba bb)) =<< (array_init_withenv len (\ a () ->
                                                         do b <- read_int
                                                            skip_whitespaces
                                                            let g = b
                                                            return (((), g))) ()))

