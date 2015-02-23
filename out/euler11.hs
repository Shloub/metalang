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
  let l () = ()
             in return ((if (a > b)
                        then a
                        else b))
find n m x y dx dy =
  do let h () = return (())
     (if ((((x < 0) || (x == 20)) || (y < 0)) || (y == 20))
     then return ((- 1))
     else do let k () = (h ())
             (if (n == 0)
             then return (1)
             else ((*) <$> join (readIOA <$> (readIOA m y) <*> return (x)) <*> (find (n - 1) m (x + dx) (y + dy) dx dy))))
main =
  ((\ (p, directions) ->
     do return (p)
        let max0 = 0
        let c = 20
        ((\ (bc, m) ->
           do return (bc)
              let bm = 0
              let bn = 7
              let bf j bo =
                     (if (j <= bn)
                     then ((\ (dx, dy) ->
                             do let bk = 0
                                let bl = 19
                                let bg x bp =
                                       (if (x <= bl)
                                       then do let bi = 0
                                               let bj = 19
                                               let bh y bq =
                                                      (if (y <= bj)
                                                      then do br <- (max2_ bq =<< (find 4 m x y dx dy))
                                                              (bh (y + 1) br)
                                                      else (bg (x + 1) bq)) in
                                                      (bh bi bp)
                                       else (bf (j + 1) bp)) in
                                       (bg bk bo)) =<< (readIOA directions j))
                     else do printf "%d" (bo :: Int)::IO()
                             printf "\n" ::IO()) in
                     (bf bm max0)) =<< (array_init_withenv 20 (\ d () ->
                                                                ((\ (be, f) ->
                                                                   do return (be)
                                                                      let bb = f
                                                                      return (((), bb))) =<< (array_init_withenv c (\ g () ->
                                                                                                                     do e <- read_int
                                                                                                                        skip_whitespaces
                                                                                                                        let bd = e
                                                                                                                        return (((), bd))) ()))) ()))) =<< (array_init_withenv 8 (\ i () ->
                                                                                                                                                                                   let q () o = ((), o)
                                                                                                                                                                                                in return ((if (i == 0)
                                                                                                                                                                                                           then let o = (0, 1)
                                                                                                                                                                                                                        in ((), o)
                                                                                                                                                                                                           else let r () = (q ())
                                                                                                                                                                                                                           in (if (i == 1)
                                                                                                                                                                                                                              then let o = (1, 0)
                                                                                                                                                                                                                                           in ((), o)
                                                                                                                                                                                                                              else let s () = (r ())
                                                                                                                                                                                                                                              in (if (i == 2)
                                                                                                                                                                                                                                                 then let o = (0, (- 1))
                                                                                                                                                                                                                                                              in ((), o)
                                                                                                                                                                                                                                                 else let u () = (s ())
                                                                                                                                                                                                                                                                 in (if (i == 3)
                                                                                                                                                                                                                                                                    then let o = ((- 1), 0)
                                                                                                                                                                                                                                                                                 in ((), o)
                                                                                                                                                                                                                                                                    else let v () = (u ())
                                                                                                                                                                                                                                                                                    in (if (i == 4)
                                                                                                                                                                                                                                                                                       then let o = (1, 1)
                                                                                                                                                                                                                                                                                                    in ((), o)
                                                                                                                                                                                                                                                                                       else let w () = (v ())
                                                                                                                                                                                                                                                                                                       in (if (i == 5)
                                                                                                                                                                                                                                                                                                          then let o = (1, (- 1))
                                                                                                                                                                                                                                                                                                                       in ((), o)
                                                                                                                                                                                                                                                                                                          else let ba () = (w ())
                                                                                                                                                                                                                                                                                                                           in (if (i == 6)
                                                                                                                                                                                                                                                                                                                              then let o = ((- 1), 1)
                                                                                                                                                                                                                                                                                                                                           in ((), o)
                                                                                                                                                                                                                                                                                                                              else let o = ((- 1), (- 1))
                                                                                                                                                                                                                                                                                                                                           in ((), o)))))))))) ()))

