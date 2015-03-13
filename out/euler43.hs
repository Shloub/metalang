import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

(<&&>) a b =
	do c <- a
	   if c then b
		 else return False
(<||>) a b =
	do c <- a
	   if c then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
main =
  {-
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17
Find the sum of all 0 to 9 pandigital numbers with this property.

d4 % 2 == 0
(d3 + d4 + d5) % 3 == 0
d6 = 5 ou d6 = 0
(d5 * 100 + d6 * 10 + d7  ) % 7 == 0
(d6 * 100 + d7 * 10 + d8  ) % 11 == 0
(d7 * 100 + d8 * 10 + d9  ) % 13 == 0
(d8 * 100 + d9 * 10 + d10 ) % 17 == 0


d4 % 2 == 0
d6 = 5 ou d6 = 0

(d3 + d4 + d5) % 3 == 0
(d5 * 2 + d6 * 3 + d7) % 7 == 0
-}
  do allowed <- array_init 10 (\ i ->
                                 return True)
     let c i6 =
           if i6 <= 1
           then do let d6 = i6 * 5
                   ifM (readIOA allowed d6)
                       (do writeIOA allowed d6 False
                           let d d7 =
                                 if d7 <= 9
                                 then ifM (readIOA allowed d7)
                                          (do writeIOA allowed d7 False
                                              let e d8 =
                                                    if d8 <= 9
                                                    then ifM (readIOA allowed d8)
                                                             (do writeIOA allowed d8 False
                                                                 let f d9 =
                                                                       if d9 <= 9
                                                                       then ifM (readIOA allowed d9)
                                                                                (do writeIOA allowed d9 False
                                                                                    let g d10 =
                                                                                          if d10 <= 9
                                                                                          then ifM (((&&) (((d8 * 100 + d9 * 10 + d10) `rem` 17) == 0)) <$> (((&&) (((d7 * 100 + d8 * 10 + d9) `rem` 13) == 0)) <$> (((&&) (((d6 * 100 + d7 * 10 + d8) `rem` 11) == 0)) <$> (readIOA allowed d10))))
                                                                                                   (do writeIOA allowed d10 False
                                                                                                       let h d5 =
                                                                                                             if d5 <= 9
                                                                                                             then ifM (readIOA allowed d5)
                                                                                                                      (do writeIOA allowed d5 False
                                                                                                                          if ((d5 * 100 + d6 * 10 + d7) `rem` 7) == 0
                                                                                                                          then let j i4 =
                                                                                                                                     if i4 <= 4
                                                                                                                                     then do let d4 = i4 * 2
                                                                                                                                             ifM (readIOA allowed d4)
                                                                                                                                                 (do writeIOA allowed d4 False
                                                                                                                                                     let k d3 =
                                                                                                                                                           if d3 <= 9
                                                                                                                                                           then ifM (readIOA allowed d3)
                                                                                                                                                                    (do writeIOA allowed d3 False
                                                                                                                                                                        if ((d3 + d4 + d5) `rem` 3) == 0
                                                                                                                                                                        then let l d2 =
                                                                                                                                                                                   if d2 <= 9
                                                                                                                                                                                   then ifM (readIOA allowed d2)
                                                                                                                                                                                            (do writeIOA allowed d2 False
                                                                                                                                                                                                let m d1 =
                                                                                                                                                                                                      if d1 <= 9
                                                                                                                                                                                                      then ifM (readIOA allowed d1)
                                                                                                                                                                                                               (do writeIOA allowed d1 False
                                                                                                                                                                                                                   printf "%d%d%d%d%d%d%d%d%d%d + " (d1::Int) (d2::Int) (d3::Int) (d4::Int) (d5::Int) (d6::Int) (d7::Int) (d8::Int) (d9::Int) (d10::Int) :: IO()
                                                                                                                                                                                                                   writeIOA allowed d1 True
                                                                                                                                                                                                                   m (d1 + 1))
                                                                                                                                                                                                               (m (d1 + 1))
                                                                                                                                                                                                      else do writeIOA allowed d2 True
                                                                                                                                                                                                              l (d2 + 1) in
                                                                                                                                                                                                      m 0)
                                                                                                                                                                                            (l (d2 + 1))
                                                                                                                                                                                   else return () in
                                                                                                                                                                                   l 0
                                                                                                                                                                        else return ()
                                                                                                                                                                        writeIOA allowed d3 True
                                                                                                                                                                        k (d3 + 1))
                                                                                                                                                                    (k (d3 + 1))
                                                                                                                                                           else do writeIOA allowed d4 True
                                                                                                                                                                   j (i4 + 1) in
                                                                                                                                                           k 0)
                                                                                                                                                 (j (i4 + 1))
                                                                                                                                     else return () in
                                                                                                                                     j 0
                                                                                                                          else return ()
                                                                                                                          writeIOA allowed d5 True
                                                                                                                          h (d5 + 1))
                                                                                                                      (h (d5 + 1))
                                                                                                             else do writeIOA allowed d10 True
                                                                                                                     g (d10 + 1) in
                                                                                                             h 0)
                                                                                                   (g (d10 + 1))
                                                                                          else do writeIOA allowed d9 True
                                                                                                  f (d9 + 1) in
                                                                                          g 1)
                                                                                (f (d9 + 1))
                                                                       else do writeIOA allowed d8 True
                                                                               e (d8 + 1) in
                                                                       f 0)
                                                             (e (d8 + 1))
                                                    else do writeIOA allowed d7 True
                                                            d (d7 + 1) in
                                                    e 0)
                                          (d (d7 + 1))
                                 else do writeIOA allowed d6 True
                                         c (i6 + 1) in
                                 d 0)
                       (c (i6 + 1))
           else printf "%d\n" (0::Int) :: IO() in
           c 0


