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
  let g () = ()
             in return ((if (a > b)
                        then a
                        else b))
main =
  do let i = 1
     ((\ (l, last) ->
        do let p = l
           let max0 = p
           let index = 0
           let nskipdiv = 0
           let n = 1
           let o = 995
           let m k q r s t =
                 (if (k <= o)
                 then hGetChar stdin >>= ((\ e ->
                                            do f <- ((-) <$> ((fmap ord (return (e)))) <*> ((fmap ord (return ('0')))))
                                               ((\ (u, v) ->
                                                  do writeIOA last r f
                                                     let w = ((r + 1) `rem` 5)
                                                     x <- (max2_ s u)
                                                     (m (k + 1) u w x v)) =<< (if (f == 0)
                                                                              then let y = 1
                                                                                           in let z = 4
                                                                                                      in return ((y, z))
                                                                              else do let ba = (q * f)
                                                                                      bb <- (if (t < 0)
                                                                                            then do bc <- ((quot ba) <$> (readIOA last r))
                                                                                                    return (bc)
                                                                                            else return (ba))
                                                                                      let bd = (t - 1)
                                                                                      return ((bb, bd))))))
                 else do printf "%d" (s :: Int)::IO()
                         printf "\n" ::IO()) in
                 (m n p index max0 nskipdiv)) =<< (array_init_withenv 5 (\ j be ->
                                                                          hGetChar stdin >>= ((\ c ->
                                                                                                do d <- ((-) <$> ((fmap ord (return (c)))) <*> ((fmap ord (return ('0')))))
                                                                                                   let bf = (be * d)
                                                                                                   let h = d
                                                                                                   return ((bf, h))))) i))

