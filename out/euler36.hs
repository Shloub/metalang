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
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init_withenv :: Int -> ( Int -> env -> IO(env, tabcontent)) -> env -> IO(env, IOArray Int tabcontent)
array_init_withenv len f env =
  do (env, li) <- g 0 env
     (,) env <$> newListArray (0, len - 1) li
  where g i env =
           if i == len
           then return (env, [])
           else do (env', item) <- f i env
                   (env'', li) <- g (i+1) env'
                   return (env'', item:li)
array_init len f = fmap snd (array_init_withenv len (\x () -> fmap ((,) ()) (f x)) ())

main :: IO ()
palindrome2 pow2 n =
  do t <- array_init 20 (\ i ->
                           (((==) 1) <$> (rem <$> ((quot n) <$> (readIOA pow2 i)) <*> (return 2))))
     let h j u =
           if j <= 19
           then ifM (readIOA t j)
                    (h (j + 1) j)
                    (h (j + 1) u)
           else let g k =
                      if k <= (u `quot` 2)
                      then ifM ((/=) <$> (readIOA t k) <*> (readIOA t (u - k)))
                               (return False)
                               (g (k + 1))
                      else return True in
                      g 0 in
           h 1 0

main =
  (array_init_withenv 20 (\ i bk ->
                            let bl = bk * 2
                                     in let l = bl `quot` 2
                                                in return (bl, l)) 1) >>= (\ (w, pow2) ->
                                                                            let s d x =
                                                                                  if d <= 9
                                                                                  then do y <- ifM (palindrome2 pow2 d)
                                                                                                   (do printf "%d\n" (d::Int) :: IO()
                                                                                                       let z = x + d
                                                                                                       return z)
                                                                                                   (return x)
                                                                                          ifM (palindrome2 pow2 (d * 10 + d))
                                                                                              (do printf "%d\n" ((d * 10 + d)::Int) :: IO()
                                                                                                  let ba = y + d * 10 + d
                                                                                                  s (d + 1) ba)
                                                                                              (s (d + 1) y)
                                                                                  else let o a0 bb =
                                                                                             if a0 <= 4
                                                                                             then do let a = a0 * 2 + 1
                                                                                                     let q b bc =
                                                                                                           if b <= 9
                                                                                                           then let r c bd =
                                                                                                                      if c <= 9
                                                                                                                      then do let num0 = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a
                                                                                                                              be <- ifM (palindrome2 pow2 num0)
                                                                                                                                        (do printf "%d\n" (num0::Int) :: IO()
                                                                                                                                            let bf = bd + num0
                                                                                                                                            return bf)
                                                                                                                                        (return bd)
                                                                                                                              let num1 = a * 10000 + b * 1000 + c * 100 + b * 10 + a
                                                                                                                              ifM (palindrome2 pow2 num1)
                                                                                                                                  (do printf "%d\n" (num1::Int) :: IO()
                                                                                                                                      let bg = be + num1
                                                                                                                                      r (c + 1) bg)
                                                                                                                                  (r (c + 1) be)
                                                                                                                      else do let num2 = a * 100 + b * 10 + a
                                                                                                                              bh <- ifM (palindrome2 pow2 num2)
                                                                                                                                        (do printf "%d\n" (num2::Int) :: IO()
                                                                                                                                            let bi = bd + num2
                                                                                                                                            return bi)
                                                                                                                                        (return bd)
                                                                                                                              let num3 = a * 1000 + b * 100 + b * 10 + a
                                                                                                                              ifM (palindrome2 pow2 num3)
                                                                                                                                  (do printf "%d\n" (num3::Int) :: IO()
                                                                                                                                      let bj = bh + num3
                                                                                                                                      q (b + 1) bj)
                                                                                                                                  (q (b + 1) bh) in
                                                                                                                      r 0 bc
                                                                                                           else o (a0 + 1) bc in
                                                                                                           q 0 bb
                                                                                             else printf "sum=%d\n" (bb::Int) :: IO() in
                                                                                             o 0 x in
                                                                                  s 1 0)


