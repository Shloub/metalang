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
                                                                                                                                                                                                                                                                         

max2_ a b =
  return (if (a > b)
         then a
         else b)

nbPassePartout n passepartout m serrures =
  do let max_ancient = 0
     let max_recent = 0
     let f = (m - 1)
     let e i u v =
           (if (i <= f)
           then do w <- ifM (((==) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 0) <*> return (- 1)) <&&> ((>) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 1) <*> return u))
                            (do x <- (join $ readIOA <$> (readIOA serrures i) <*> return 1)
                                return x)
                            (return u)
                   ifM (((==) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 0) <*> return 1) <&&> ((>) <$> (join $ readIOA <$> (readIOA serrures i) <*> return 1) <*> return v))
                       (do y <- (join $ readIOA <$> (readIOA serrures i) <*> return 1)
                           (e (i + 1) w y))
                       ((e (i + 1) w v))
           else do let max_ancient_pp = 0
                   let max_recent_pp = 0
                   let d = (n - 1)
                   let c z ba bb =
                         (if (z <= d)
                         then do pp <- (readIOA passepartout z)
                                 ifM (((>=) <$> (readIOA pp 0) <*> return u) <&&> ((>=) <$> (readIOA pp 1) <*> return v))
                                     (return 1)
                                     (do bc <- (max2_ ba =<< (readIOA pp 0))
                                         bd <- (max2_ bb =<< (readIOA pp 1))
                                         (c (z + 1) bc bd))
                         else return (if ((ba >= u) && (bb >= v))
                                     then 2
                                     else 0)) in
                         (c 0 max_ancient_pp max_recent_pp)) in
           (e 0 max_ancient max_recent)

main =
  do n <- read_int
     skip_whitespaces
     ((array_init_withenv n (\ i h ->
                              ((array_init_withenv 2 (\ j t ->
                                                       do out01 <- read_int
                                                          skip_whitespaces
                                                          let s = out01
                                                          return ((), s)) ()) >>= (\ (t, out0) ->
                                                                                    let g = out0
                                                                                            in return ((), g)))) ()) >>= (\ (h, passepartout) ->
                                                                                                                           do m <- read_int
                                                                                                                              skip_whitespaces
                                                                                                                              ((array_init_withenv m (\ k p ->
                                                                                                                                                       ((array_init_withenv 2 (\ l r ->
                                                                                                                                                                                do out_ <- read_int
                                                                                                                                                                                   skip_whitespaces
                                                                                                                                                                                   let q = out_
                                                                                                                                                                                   return ((), q)) ()) >>= (\ (r, out1) ->
                                                                                                                                                                                                             let o = out1
                                                                                                                                                                                                                     in return ((), o)))) ()) >>= (\ (p, serrures) ->
                                                                                                                                                                                                                                                    printf "%d" =<< ((nbPassePartout n passepartout m serrures) :: IO Int)))))


