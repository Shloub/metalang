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
okdigits ok n =
  if n == 0
  then return True
  else do let digit = n `rem` 10
          ifM (readIOA ok digit)
              (do writeIOA ok digit False
                  o <- okdigits ok (n `quot` 10)
                  writeIOA ok digit True
                  return o)
              (return False)

main =
  do let count = 0
     allowed <- array_init 10 (\ i ->
                                return (i /= 0))
     counted <- array_init 100000 (\ j ->
                                    return False)
     let l e s =
           if e <= 9
           then do writeIOA allowed e False
                   let m b t =
                         if b <= 9
                         then ifM (readIOA allowed b)
                                  (do writeIOA allowed b False
                                      let be = (b * e) `rem` 10
                                      u <- ifM (readIOA allowed be)
                                               (do writeIOA allowed be False
                                                   let p a v =
                                                         if a <= 9
                                                         then ifM (readIOA allowed a)
                                                                  (do writeIOA allowed a False
                                                                      let q c w =
                                                                            if c <= 9
                                                                            then ifM (readIOA allowed c)
                                                                                     (do writeIOA allowed c False
                                                                                         let r d x =
                                                                                               if d <= 9
                                                                                               then ifM (readIOA allowed d)
                                                                                                        (do writeIOA allowed d False
                                                                                                            {- 2 * 3 digits -}
                                                                                                            do let product = (a * 10 + b) * (c * 100 + d * 10 + e)
                                                                                                               y <- ifM ((fmap not (readIOA counted product)) <&&> (okdigits allowed (product `quot` 10)))
                                                                                                                        (do writeIOA counted product True
                                                                                                                            let z = x + product
                                                                                                                            printf "%d" (product :: Int) :: IO ()
                                                                                                                            printf " " :: IO ()
                                                                                                                            return z)
                                                                                                                        (return x)
                                                                                                               {- 1  * 4 digits -}
                                                                                                               do let product2 = b * (a * 1000 + c * 100 + d * 10 + e)
                                                                                                                  ba <- ifM ((fmap not (readIOA counted product2)) <&&> (okdigits allowed (product2 `quot` 10)))
                                                                                                                            (do writeIOA counted product2 True
                                                                                                                                let bb = y + product2
                                                                                                                                printf "%d" (product2 :: Int) :: IO ()
                                                                                                                                printf " " :: IO ()
                                                                                                                                return bb)
                                                                                                                            (return y)
                                                                                                                  writeIOA allowed d True
                                                                                                                  r (d + 1) ba)
                                                                                                        (r (d + 1) x)
                                                                                               else do writeIOA allowed c True
                                                                                                       q (c + 1) x in
                                                                                               r 1 w)
                                                                                     (q (c + 1) w)
                                                                            else do writeIOA allowed a True
                                                                                    p (a + 1) w in
                                                                            q 1 v)
                                                                  (p (a + 1) v)
                                                         else do writeIOA allowed be True
                                                                 return v in
                                                         p 1 t)
                                               (return t)
                                      writeIOA allowed b True
                                      m (b + 1) u)
                                  (m (b + 1) t)
                         else do writeIOA allowed e True
                                 l (e + 1) t in
                         m 1 s
           else do printf "%d" (s :: Int) :: IO ()
                   printf "\n" :: IO () in
           l 1 count


