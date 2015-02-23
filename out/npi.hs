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



is_number c =
  (((<=) <$> ((fmap ord (return (c)))) <*> ((fmap ord (return ('9'))))) <&&> ((>=) <$> ((fmap ord (return (c)))) <*> ((fmap ord (return ('0'))))))
npi0 str len =
  ((\ (b, stack) ->
     do return (b)
        let ptrStack = 0
        let ptrStr = 0
        let d k l =
              (if (l < len)
              then ifM (((==) <$> (readIOA str l) <*> return (' ')))
                       (do let m = (l + 1)
                           (d k m))
                       (ifM ((is_number =<< (readIOA str l)))
                            (do let num = 0
                                let e n o =
                                      ifM (((/=) <$> (readIOA str o) <*> return (' ')))
                                          (do p <- ((-) <$> (((+) (n * 10)) <$> ((fmap ord ((readIOA str o))))) <*> ((fmap ord (return ('0')))))
                                              let q = (o + 1)
                                              (e p q))
                                          (do writeIOA stack k n
                                              let r = (k + 1)
                                              (d r o)) in
                                      (e num l))
                            (ifM (((==) <$> (readIOA str l) <*> return ('+')))
                                 (do writeIOA stack (k - 2) =<< ((+) <$> (readIOA stack (k - 2)) <*> (readIOA stack (k - 1)))
                                     let s = (k - 1)
                                     let t = (l + 1)
                                     (d s t))
                                 ((d k l))))
              else (readIOA stack 0)) in
              (d ptrStack ptrStr)) =<< (array_init_withenv len (\ i () ->
                                                                 let a = 0
                                                                         in return (((), a))) ()))
main =
  do let len = 0
     j <- read_int
     let u = j
     skip_whitespaces
     ((\ (g, tab) ->
        do return (g)
           result <- (npi0 tab u)
           printf "%d" (result :: Int)::IO()) =<< (array_init_withenv u (\ i () ->
                                                                          do let tmp = '\000'
                                                                             hGetChar stdin >>= ((\ h ->
                                                                                                   let v = h
                                                                                                           in let f = v
                                                                                                                      in return (((), f))))) ()))

