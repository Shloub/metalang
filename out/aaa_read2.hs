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
     ((\ (k, tab) ->
        do return (k)
           let bb = 0
           let bc = (len - 1)
           let ba i =
                  (if (i <= bc)
                  then do printf "%d" (i :: Int)::IO()
                          printf "=>" ::IO()
                          printf "%d" =<< ((readIOA tab i) :: IO Int)
                          printf " " ::IO()
                          (ba (i + 1))
                  else do printf "\n" ::IO()
                          ((\ (m, tab2) ->
                             do return (m)
                                let y = 0
                                let z = (len - 1)
                                let x i_ =
                                      (if (i_ <= z)
                                      then do printf "%d" (i_ :: Int)::IO()
                                              printf "==>" ::IO()
                                              printf "%d" =<< ((readIOA tab2 i_) :: IO Int)
                                              printf " " ::IO()
                                              (x (i_ + 1))
                                      else do strlen <- read_int
                                              skip_whitespaces
                                              printf "%d" (strlen :: Int)::IO()
                                              printf "=strlen\n" ::IO()
                                              ((\ (p, tab4) ->
                                                 do return (p)
                                                    skip_whitespaces
                                                    let v = 0
                                                    let w = (strlen - 1)
                                                    let u i3 =
                                                          (if (i3 <= w)
                                                          then do tmpc <- (readIOA tab4 i3)
                                                                  c <- ((fmap ord (return (tmpc))))
                                                                  printf "%c" (tmpc :: Char)::IO()
                                                                  printf ":" ::IO()
                                                                  printf "%d" (c :: Int)::IO()
                                                                  printf " " ::IO()
                                                                  bd <- (if (tmpc /= ' ')
                                                                        then do be <- ((+) <$> (rem <$> ((+) <$> (((-) c) <$> ((fmap ord (return ('a'))))) <*> return (13)) <*> return (26)) <*> ((fmap ord (return ('a')))))
                                                                                return (be)
                                                                        else return (c))
                                                                  writeIOA tab4 i3 =<< ((fmap chr (return (bd))))
                                                                  (u (i3 + 1))
                                                          else do let r = 0
                                                                  let s = (strlen - 1)
                                                                  let q j =
                                                                        (if (j <= s)
                                                                        then do printf "%c" =<< ((readIOA tab4 j) :: IO Char)
                                                                                (q (j + 1))
                                                                        else return (())) in
                                                                        (q r)) in
                                                          (u v)) =<< (array_init_withenv strlen (\ f () ->
                                                                                                  hGetChar stdin >>= ((\ g ->
                                                                                                                        let o = g
                                                                                                                                in return (((), o))))) ()))) in
                                      (x y)) =<< (array_init_withenv len (\ d () ->
                                                                           do e <- read_int
                                                                              skip_whitespaces
                                                                              let l = e
                                                                              return (((), l))) ()))) in
                  (ba bb)) =<< (array_init_withenv len (\ a () ->
                                                         do b <- read_int
                                                            skip_whitespaces
                                                            let h = b
                                                            return (((), h))) ()))
