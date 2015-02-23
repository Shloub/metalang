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



find0 len tab cache x y =
  {-
	Cette fonction est récursive
	-}
  do let e () = do let result = 0
                   out0 <- (find0 len tab cache x (y + 1))
                   out1 <- (find0 len tab cache (x + 1) (y + 1))
                   w <- (if (out0 > out1)
                        then do z <- (((+) out0) <$> join (readIOA <$> (readIOA tab y) <*> return (x)))
                                return (z)
                        else do ba <- (((+) out1) <$> join (readIOA <$> (readIOA tab y) <*> return (x)))
                                return (ba))
                   join (writeIOA <$> (readIOA cache y) <*> return (x) <*> return (w))
                   return (w)
     (if (y == (len - 1))
     then join (readIOA <$> (readIOA tab y) <*> return (x))
     else do let f () = (e ())
             (if (x > y)
             then return ((- 10000))
             else ifM (((/=) <$> join (readIOA <$> (readIOA cache y) <*> return (x)) <*> return (0)))
                      (join (readIOA <$> (readIOA cache y) <*> return (x)))
                      ((f ()))))
find len tab =
  ((\ (b, tab2) ->
     do return (b)
        (find0 len tab tab2 0 0)) =<< (array_init_withenv len (\ i () ->
                                                                ((\ (d, tab3) ->
                                                                   do return (d)
                                                                      let a = tab3
                                                                      return (((), a))) =<< (array_init_withenv (i + 1) (\ j () ->
                                                                                                                          let c = 0
                                                                                                                                  in return (((), c))) ()))) ()))
main =
  do let len = 0
     v <- read_int
     let bb = v
     skip_whitespaces
     ((\ (h, tab) ->
        do return (h)
           printf "%d" =<< ((find bb tab) :: IO Int)
           printf "\n" ::IO()
           let t = 0
           let u = (bb - 1)
           let p k =
                 (if (k <= u)
                 then do let r = 0
                         let s = k
                         let q l =
                               (if (l <= s)
                               then do printf "%d" =<< (join (readIOA <$> (readIOA tab k) <*> return (l)) :: IO Int)
                                       printf " " ::IO()
                                       (q (l + 1))
                               else do printf "\n" ::IO()
                                       (p (k + 1))) in
                               (q r)
                 else return (())) in
                 (p t)) =<< (array_init_withenv bb (\ i () ->
                                                     ((\ (n, tab2) ->
                                                        do return (n)
                                                           let g = tab2
                                                           return (((), g))) =<< (array_init_withenv (i + 1) (\ j () ->
                                                                                                               do let tmp = 0
                                                                                                                  o <- read_int
                                                                                                                  let bc = o
                                                                                                                  skip_whitespaces
                                                                                                                  let m = bc
                                                                                                                  return (((), m))) ()))) ()))

