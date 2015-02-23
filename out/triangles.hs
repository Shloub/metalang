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
  (if (y == (len - 1))
  then join (readIOA <$> (readIOA tab y) <*> return (x))
  else (if (x > y)
       then return ((- 10000))
       else ifM (((/=) <$> join (readIOA <$> (readIOA cache y) <*> return (x)) <*> return (0)))
                (join (readIOA <$> (readIOA cache y) <*> return (x)))
                (do let result = 0
                    out0 <- (find0 len tab cache x (y + 1))
                    out1 <- (find0 len tab cache (x + 1) (y + 1))
                    r <- (if (out0 > out1)
                         then do s <- (((+) out0) <$> join (readIOA <$> (readIOA tab y) <*> return (x)))
                                 return (s)
                         else do t <- (((+) out1) <$> join (readIOA <$> (readIOA tab y) <*> return (x)))
                                 return (t))
                    join (writeIOA <$> (readIOA cache y) <*> return (x) <*> return (r))
                    return (r))))
find len tab =
  ((\ (b, tab2) ->
     (find0 len tab tab2 0 0)) =<< (array_init_withenv len (\ i b ->
                                                             ((\ (d, tab3) ->
                                                                let a = tab3
                                                                        in return (((), a))) =<< (array_init_withenv (i + 1) (\ j d ->
                                                                                                                               let c = 0
                                                                                                                                       in return (((), c))) ()))) ()))
main =
  do let len = 0
     q <- read_int
     let u = q
     skip_whitespaces
     ((\ (f, tab) ->
        do printf "%d" =<< ((find u tab) :: IO Int)
           printf "\n" ::IO()
           let m = (u - 1)
           let g k =
                 (if (k <= m)
                 then let h l =
                            (if (l <= k)
                            then do printf "%d" =<< (join (readIOA <$> (readIOA tab k) <*> return (l)) :: IO Int)
                                    printf " " ::IO()
                                    (h (l + 1))
                            else do printf "\n" ::IO()
                                    (g (k + 1))) in
                            (h 0)
                 else return (())) in
                 (g 0)) =<< (array_init_withenv u (\ i f ->
                                                    ((\ (o, tab2) ->
                                                       let e = tab2
                                                               in return (((), e))) =<< (array_init_withenv (i + 1) (\ j o ->
                                                                                                                      do let tmp = 0
                                                                                                                         p <- read_int
                                                                                                                         let v = p
                                                                                                                         skip_whitespaces
                                                                                                                         let n = v
                                                                                                                         return (((), n))) ()))) ()))

