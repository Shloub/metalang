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
  do allowed <- array_init 10 (\ i ->
                                 return (i /= 0))
     counted <- array_init 100000 (\ j ->
                                     return False)
     let f e g =
           if e <= 9
           then do writeIOA allowed e False
                   let h b k =
                         if b <= 9
                         then ifM (readIOA allowed b)
                                  (do writeIOA allowed b False
                                      let be = (b * e) `rem` 10
                                      l <- ifM (readIOA allowed be)
                                               (do writeIOA allowed be False
                                                   let m a p =
                                                         if a <= 9
                                                         then ifM (readIOA allowed a)
                                                                  (do writeIOA allowed a False
                                                                      let q c r =
                                                                            if c <= 9
                                                                            then ifM (readIOA allowed c)
                                                                                     (do writeIOA allowed c False
                                                                                         let s d t =
                                                                                               if d <= 9
                                                                                               then ifM (readIOA allowed d)
                                                                                                        (do writeIOA allowed d False
                                                                                                            {- 2 * 3 digits -}
                                                                                                            do let product = (a * 10 + b) * (c * 100 + d * 10 + e)
                                                                                                               u <- ifM ((fmap not (readIOA counted product)) <&&> (okdigits allowed (product `quot` 10)))
                                                                                                                        (do writeIOA counted product True
                                                                                                                            let v = t + product
                                                                                                                            printf "%d " (product::Int) :: IO()
                                                                                                                            return v)
                                                                                                                        (return t)
                                                                                                               {- 1  * 4 digits -}
                                                                                                               do let product2 = b * (a * 1000 + c * 100 + d * 10 + e)
                                                                                                                  w <- ifM ((fmap not (readIOA counted product2)) <&&> (okdigits allowed (product2 `quot` 10)))
                                                                                                                           (do writeIOA counted product2 True
                                                                                                                               let x = u + product2
                                                                                                                               printf "%d " (product2::Int) :: IO()
                                                                                                                               return x)
                                                                                                                           (return u)
                                                                                                                  writeIOA allowed d True
                                                                                                                  s (d + 1) w)
                                                                                                        (s (d + 1) t)
                                                                                               else do writeIOA allowed c True
                                                                                                       q (c + 1) t in
                                                                                               s 1 r)
                                                                                     (q (c + 1) r)
                                                                            else do writeIOA allowed a True
                                                                                    m (a + 1) r in
                                                                            q 1 p)
                                                                  (m (a + 1) p)
                                                         else do writeIOA allowed be True
                                                                 return p in
                                                         m 1 k)
                                               (return k)
                                      writeIOA allowed b True
                                      h (b + 1) l)
                                  (h (b + 1) k)
                         else do writeIOA allowed e True
                                 f (e + 1) k in
                         h 1 g
           else printf "%d\n" (g::Int) :: IO() in
           f 1 0


