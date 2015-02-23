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



min2_ a b =
  let o () = ()
             in return ((if (a < b)
                        then a
                        else b))
pathfind_aux cache tab x y posX posY =
  do let k () = return (())
     (if ((posX == (x - 1)) && (posY == (y - 1)))
     then return (0)
     else do let l () = (k ())
             (if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
             then return (((x * y) * 10))
             else do let m () = (l ())
                     ifM (((==) <$> join (readIOA <$> (readIOA tab posY) <*> return (posX)) <*> return ('#')))
                         (return (((x * y) * 10)))
                         (do let n () = (m ())
                             ifM (((/=) <$> join (readIOA <$> (readIOA cache posY) <*> return (posX)) <*> return ((- 1))))
                                 (join (readIOA <$> (readIOA cache posY) <*> return (posX)))
                                 (do join (writeIOA <$> (readIOA cache posY) <*> return (posX) <*> return (((x * y) * 10)))
                                     val1 <- (pathfind_aux cache tab x y (posX + 1) posY)
                                     val2 <- (pathfind_aux cache tab x y (posX - 1) posY)
                                     val3 <- (pathfind_aux cache tab x y posX (posY - 1))
                                     val4 <- (pathfind_aux cache tab x y posX (posY + 1))
                                     out0 <- (((+) 1) <$> (join (min2_ <$> (join (min2_ <$> (min2_ val1 val2) <*> (return val3))) <*> (return val4))))
                                     join (writeIOA <$> (readIOA cache posY) <*> return (posX) <*> return (out0))
                                     return (out0)))))
pathfind tab x y =
  ((\ (f, cache) ->
     do return (f)
        (pathfind_aux cache tab x y 0 0)) =<< (array_init_withenv y (\ i () ->
                                                                      ((\ (h, tmp) ->
                                                                         do return (h)
                                                                            let e = tmp
                                                                            return (((), e))) =<< (array_init_withenv x (\ j () ->
                                                                                                                          let g = (- 1)
                                                                                                                                  in return (((), g))) ()))) ()))
main =
  do let x = 0
     let y = 0
     v <- read_int
     let w = v
     skip_whitespaces
     u <- read_int
     let z = u
     skip_whitespaces
     ((\ (q, tab) ->
        do return (q)
           result <- (pathfind tab w z)
           printf "%d" (result :: Int)::IO()) =<< (array_init_withenv z (\ i () ->
                                                                          ((\ (s, tab2) ->
                                                                             do return (s)
                                                                                skip_whitespaces
                                                                                let p = tab2
                                                                                return (((), p))) =<< (array_init_withenv w (\ j () ->
                                                                                                                              do let tmp = '\000'
                                                                                                                                 hGetChar stdin >>= ((\ t ->
                                                                                                                                                       let ba = t
                                                                                                                                                                in let r = ba
                                                                                                                                                                           in return (((), r))))) ()))) ()))
