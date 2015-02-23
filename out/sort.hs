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



copytab tab len =
  ((\ (k, o) ->
     do return (k)
        return (o)) =<< (array_init_withenv len (\ i () ->
                                                  do h <- (readIOA tab i)
                                                     return (((), h))) ()))
bubblesort tab len =
  do let f = 0
     let g = (len - 1)
     let b i =
           (if (i <= g)
           then do let d = (i + 1)
                   let e = (len - 1)
                   let c j =
                         (if (j <= e)
                         then do ifM (((>) <$> (readIOA tab i) <*> (readIOA tab j)))
                                     (do tmp <- (readIOA tab i)
                                         writeIOA tab i =<< (readIOA tab j)
                                         writeIOA tab j tmp)
                                     (return (()))
                                 (c (j + 1))
                         else (b (i + 1))) in
                         (c d)
           else return (())) in
           (b f)
qsort0 tab len i j =
  ((\ (w, x) ->
     return (())) =<< (if (i < j)
                      then do let i0 = i
                              let j0 = j
                              {- pivot : tab[0] -}
                              let a y z =
                                    (if (y /= z)
                                    then ((\ (ba, bb) ->
                                            (a ba bb)) =<< ifM (((>) <$> (readIOA tab y) <*> (readIOA tab z)))
                                                               (do bc <- (if (y == (z - 1))
                                                                         then {- on inverse simplement-}
                                                                              do tmp <- (readIOA tab y)
                                                                                 writeIOA tab y =<< (readIOA tab z)
                                                                                 writeIOA tab z tmp
                                                                                 let bd = (y + 1)
                                                                                 return (bd)
                                                                         else {- on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] -}
                                                                              do tmp <- (readIOA tab y)
                                                                                 writeIOA tab y =<< (readIOA tab z)
                                                                                 writeIOA tab z =<< (readIOA tab (y + 1))
                                                                                 writeIOA tab (y + 1) tmp
                                                                                 let be = (y + 1)
                                                                                 return (be))
                                                                   return ((bc, z)))
                                                               (let bf = (z - 1)
                                                                         in return ((y, bf))))
                                    else do (qsort0 tab len i0 (y - 1))
                                            (qsort0 tab len (y + 1) j0)
                                            return ((y, z))) in
                                    (a i j)
                      else return ((i, j))))
main =
  do let len = 2
     v <- read_int
     let bg = v
     skip_whitespaces
     ((\ (m, tab) ->
        do return (m)
           tab2 <- (copytab tab bg)
           (bubblesort tab2 bg)
           let t = 0
           let u = (bg - 1)
           let s i =
                 (if (i <= u)
                 then do printf "%d" =<< ((readIOA tab2 i) :: IO Int)
                         printf " " ::IO()
                         (s (i + 1))
                 else do printf "\n" ::IO()
                         tab3 <- (copytab tab bg)
                         (qsort0 tab3 bg 0 (bg - 1))
                         let q = 0
                         let r = (bg - 1)
                         let p bh =
                               (if (bh <= r)
                               then do printf "%d" =<< ((readIOA tab3 bh) :: IO Int)
                                       printf " " ::IO()
                                       (p (bh + 1))
                               else printf "\n" ::IO()) in
                               (p q)) in
                 (s t)) =<< (array_init_withenv bg (\ i_ () ->
                                                     do let tmp = 0
                                                        n <- read_int
                                                        let bi = n
                                                        skip_whitespaces
                                                        let l = bi
                                                        return (((), l))) ()))

