import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

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
  do len <- read_int
     skip_whitespaces
     printf "%d" (len :: Int)::IO()
     printf "=len\n" ::IO()
     ((array_init_withenv len (\ a h ->
                                do b <- read_int
                                   skip_whitespaces
                                   let g = b
                                   return ((), g)) ()) >>= (\ (h, tab1) ->
                                                             do let w = (len - 1)
                                                                let v i =
                                                                      (if (i <= w)
                                                                      then do printf "%d" (i :: Int)::IO()
                                                                              printf "=>" ::IO()
                                                                              printf "%d" =<< ((readIOA tab1 i) :: IO Int)
                                                                              printf "\n" ::IO()
                                                                              (v (i + 1))
                                                                      else do u <- read_int
                                                                              let ba = u
                                                                              skip_whitespaces
                                                                              ((array_init_withenv (ba - 1) (\ c l ->
                                                                                                              ((array_init_withenv ba (\ f s ->
                                                                                                                                        do d <- read_int
                                                                                                                                           skip_whitespaces
                                                                                                                                           let r = d
                                                                                                                                           return ((), r)) ()) >>= (\ (s, e) ->
                                                                                                                                                                     let k = e
                                                                                                                                                                             in return ((), k)))) ()) >>= (\ (l, tab2) ->
                                                                                                                                                                                                            do let q = (ba - 2)
                                                                                                                                                                                                               let m bb =
                                                                                                                                                                                                                     (if (bb <= q)
                                                                                                                                                                                                                     then do let p = (ba - 1)
                                                                                                                                                                                                                             let o j =
                                                                                                                                                                                                                                   (if (j <= p)
                                                                                                                                                                                                                                   then do printf "%d" =<< ((join $ readIOA <$> (readIOA tab2 bb) <*> return j) :: IO Int)
                                                                                                                                                                                                                                           printf " " ::IO()
                                                                                                                                                                                                                                           (o (j + 1))
                                                                                                                                                                                                                                   else do printf "\n" ::IO()
                                                                                                                                                                                                                                           (m (bb + 1))) in
                                                                                                                                                                                                                                   (o 0)
                                                                                                                                                                                                                     else return ()) in
                                                                                                                                                                                                                     (m 0)))) in
                                                                      (v 0)))


