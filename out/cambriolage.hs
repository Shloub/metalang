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



max2_ a b =
  let p () = ()
             in return ((if (a > b)
                        then a
                        else b))
nbPassePartout n passepartout m serrures =
  do let max_ancient = 0
     let max_recent = 0
     let h = 0
     let o = (m - 1)
     let g i y z =
           (if (i <= o)
           then do ba <- ifM ((((==) <$> join (readIOA <$> (readIOA serrures i) <*> return (0)) <*> return ((- 1))) <&&> ((>) <$> join (readIOA <$> (readIOA serrures i) <*> return (1)) <*> return (y))))
                             (do bb <- join (readIOA <$> (readIOA serrures i) <*> return (1))
                                 return (bb))
                             (return (y))
                   bc <- ifM ((((==) <$> join (readIOA <$> (readIOA serrures i) <*> return (0)) <*> return (1)) <&&> ((>) <$> join (readIOA <$> (readIOA serrures i) <*> return (1)) <*> return (z))))
                             (do bd <- join (readIOA <$> (readIOA serrures i) <*> return (1))
                                 return (bd))
                             (return (z))
                   (g (i + 1) ba bc)
           else do let max_ancient_pp = 0
                   let max_recent_pp = 0
                   let e = 0
                   let f = (n - 1)
                   let d be bf bg =
                         (if (be <= f)
                         then do pp <- (readIOA passepartout be)
                                 ifM ((((>=) <$> (readIOA pp 0) <*> return (y)) <&&> ((>=) <$> (readIOA pp 1) <*> return (z))))
                                     (return (1))
                                     (do bh <- (max2_ bf =<< (readIOA pp 0))
                                         bi <- (max2_ bg =<< (readIOA pp 1))
                                         (d (be + 1) bh bi))
                         else let c () = ()
                                         in return ((if ((bf >= y) && (bg >= z))
                                                    then 2
                                                    else 0))) in
                         (d e max_ancient_pp max_recent_pp)) in
           (g h max_ancient max_recent)
main =
  do n <- read_int
     skip_whitespaces
     ((\ (r, passepartout) ->
        do return (r)
           m <- read_int
           skip_whitespaces
           ((\ (v, serrures) ->
              do return (v)
                 printf "%d" =<< ((nbPassePartout n passepartout m serrures) :: IO Int)) =<< (array_init_withenv m (\ k () ->
                                                                                                                     ((\ (x, out1) ->
                                                                                                                        do return (x)
                                                                                                                           let u = out1
                                                                                                                           return (((), u))) =<< (array_init_withenv 2 (\ l () ->
                                                                                                                                                                         do out_ <- read_int
                                                                                                                                                                            skip_whitespaces
                                                                                                                                                                            let w = out_
                                                                                                                                                                            return (((), w))) ()))) ()))) =<< (array_init_withenv n (\ i () ->
                                                                                                                                                                                                                                      ((\ (t, out0) ->
                                                                                                                                                                                                                                         do return (t)
                                                                                                                                                                                                                                            let q = out0
                                                                                                                                                                                                                                            return (((), q))) =<< (array_init_withenv 2 (\ j () ->
                                                                                                                                                                                                                                                                                          do out01 <- read_int
                                                                                                                                                                                                                                                                                             skip_whitespaces
                                                                                                                                                                                                                                                                                             let s = out01
                                                                                                                                                                                                                                                                                             return (((), s))) ()))) ()))

