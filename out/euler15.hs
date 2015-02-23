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
     do let bd = (n + 1)
        ((\ (b, tab) ->
           do return (b)
              let bb = 0
              let bc = (bd - 1)
              let ba l =
                     (if (l <= bc)
                     then do join (writeIOA <$> (readIOA tab (bd - 1)) <*> return (l) <*> return (1))
                             join (writeIOA <$> (readIOA tab l) <*> return ((bd - 1)) <*> return (1))
                             (ba (l + 1))
                     else do let y = 2
                             let z = bd
                             let u o =
                                   (if (o <= z)
                                   then do let r = (bd - o)
                                           let w = 2
                                           let x = bd
                                           let v p =
                                                 (if (p <= x)
                                                 then do let q = (bd - p)
                                                         join (writeIOA <$> (readIOA tab r) <*> return (q) <*> ((+) <$> join (readIOA <$> (readIOA tab (r + 1)) <*> return (q)) <*> join (readIOA <$> (readIOA tab r) <*> return ((q + 1)))))
                                                         (v (p + 1))
                                                 else (u (o + 1))) in
                                                 (v w)
                                   else do let s = 0
                                           let t = (bd - 1)
                                           let e m =
                                                 (if (m <= t)
                                                 then do let g = 0
                                                         let h = (bd - 1)
                                                         let f k =
                                                               (if (k <= h)
                                                               then do printf "%d" =<< (join (readIOA <$> (readIOA tab m) <*> return (k)) :: IO Int)
                                                                       printf " " ::IO()
                                                                       (f (k + 1))
                                                               else do printf "\n" ::IO()
                                                                       (e (m + 1))) in
                                                               (f g)
                                                 else do printf "%d" =<< (join (readIOA <$> (readIOA tab 0) <*> return (0)) :: IO Int)
                                                         printf "\n" ::IO()) in
                                                 (e s)) in
                                   (u y)) in
                     (ba bb)) =<< (array_init_withenv bd (\ i () ->
                                                           ((\ (d, tab2) ->
                                                              do return (d)
                                                                 let a = tab2
                                                                 return (((), a))) =<< (array_init_withenv bd (\ j () ->
                                                                                                                let c = 0
                                                                                                                        in return (((), c))) ()))) ()))

