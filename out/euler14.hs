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



next0 n =
  let d () = ()
             in return ((if ((n `rem` 2) == 0)
                        then (n `quot` 2)
                        else ((3 * n) + 1)))
find n m =
  do let a () = return (())
     (if (n == 1)
     then return (1)
     else do let b () = (a ())
             (if (n >= 1000000)
             then (((+) 1) <$> (join (find <$> (next0 n) <*> (return m))))
             else do let c () = (b ())
                     ifM (((/=) <$> (readIOA m n) <*> return (0)))
                         ((readIOA m n))
                         (do writeIOA m n =<< (((+) 1) <$> (join (find <$> (next0 n) <*> (return m))))
                             (readIOA m n))))
main =
  ((\ (f, m) ->
     do return (f)
        let max0 = 0
        let maxi = 0
        let h = 1
        let k = 999
        let g i l o =
              (if (i <= k)
              then {- normalement on met 999999 mais ça dépasse les int32... -}
                   do n2 <- (find i m)
                      ((\ (p, q) ->
                         (g (i + 1) p q)) (if (n2 > l)
                                          then let r = n2
                                                       in let s = i
                                                                  in (r, s)
                                          else (l, o)))
              else do printf "%d" (l :: Int)::IO()
                      printf "\n" ::IO()
                      printf "%d" (o :: Int)::IO()
                      printf "\n" ::IO()) in
              (g h max0 maxi)) =<< (array_init_withenv 1000000 (\ j () ->
                                                                 let e = 0
                                                                         in return (((), e))) ()))

