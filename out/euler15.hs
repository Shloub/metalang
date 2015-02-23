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
  do let n = 10
     {- normalement on doit mettre 20 mais là on se tape un overflow -}
     do let w = (n + 1)
        ((\ (b, tab) ->
           do return (b)
              let v = (w - 1)
              let u l =
                    (if (l <= v)
                    then do join (writeIOA <$> (readIOA tab (w - 1)) <*> return (l) <*> return (1))
                            join (writeIOA <$> (readIOA tab l) <*> return ((w - 1)) <*> return (1))
                            (u (l + 1))
                    else let s o =
                               (if (o <= w)
                               then do let r = (w - o)
                                       let t p =
                                             (if (p <= w)
                                             then do let q = (w - p)
                                                     join (writeIOA <$> (readIOA tab r) <*> return (q) <*> ((+) <$> join (readIOA <$> (readIOA tab (r + 1)) <*> return (q)) <*> join (readIOA <$> (readIOA tab r) <*> return ((q + 1)))))
                                                     (t (p + 1))
                                             else (s (o + 1))) in
                                             (t 2)
                               else do let h = (w - 1)
                                       let e m =
                                             (if (m <= h)
                                             then do let g = (w - 1)
                                                     let f k =
                                                           (if (k <= g)
                                                           then do printf "%d" =<< (join (readIOA <$> (readIOA tab m) <*> return (k)) :: IO Int)
                                                                   printf " " ::IO()
                                                                   (f (k + 1))
                                                           else do printf "\n" ::IO()
                                                                   (e (m + 1))) in
                                                           (f 0)
                                             else do printf "%d" =<< (join (readIOA <$> (readIOA tab 0) <*> return (0)) :: IO Int)
                                                     printf "\n" ::IO()) in
                                             (e 0)) in
                               (s 2)) in
                    (u 0)) =<< (array_init_withenv w (\ i () ->
                                                       ((\ (d, tab2) ->
                                                          do return (d)
                                                             let a = tab2
                                                             return (((), a))) =<< (array_init_withenv w (\ j () ->
                                                                                                           let c = 0
                                                                                                                   in return (((), c))) ()))) ()))

