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
     let e j f =
           if j <= 19
           then ifM (readIOA t j)
                    (e (j + 1) j)
                    (e (j + 1) f)
           else let g k =
                      if k <= (f `quot` 2)
                      then ifM ((/=) <$> (readIOA t k) <*> (readIOA t (f - k)))
                               (return False)
                               (g (k + 1))
                      else return True in
                      g 0 in
           e 1 0

main =
  (array_init_withenv 20 (\ i bf ->
                            let bg = bf * 2
                                     in let bh = bg `quot` 2
                                                 in return (bg, bh)) 1) >>= (\ (h, pow2) ->
                                                                              let l d m =
                                                                                    if d <= 9
                                                                                    then do o <- ifM (palindrome2 pow2 d)
                                                                                                     (do printf "%d\n" (d::Int) :: IO()
                                                                                                         let r = m + d
                                                                                                         return r)
                                                                                                     (return m)
                                                                                            ifM (palindrome2 pow2 (d * 10 + d))
                                                                                                (do printf "%d\n" ((d * 10 + d)::Int) :: IO()
                                                                                                    let q = o + d * 10 + d
                                                                                                    l (d + 1) q)
                                                                                                (l (d + 1) o)
                                                                                    else let s a0 u =
                                                                                               if a0 <= 4
                                                                                               then do let a = a0 * 2 + 1
                                                                                                       let v b w =
                                                                                                             if b <= 9
                                                                                                             then let x c y =
                                                                                                                        if c <= 9
                                                                                                                        then do let num0 = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a
                                                                                                                                z <- ifM (palindrome2 pow2 num0)
                                                                                                                                         (do printf "%d\n" (num0::Int) :: IO()
                                                                                                                                             let bb = y + num0
                                                                                                                                             return bb)
                                                                                                                                         (return y)
                                                                                                                                let num1 = a * 10000 + b * 1000 + c * 100 + b * 10 + a
                                                                                                                                ifM (palindrome2 pow2 num1)
                                                                                                                                    (do printf "%d\n" (num1::Int) :: IO()
                                                                                                                                        let ba = z + num1
                                                                                                                                        x (c + 1) ba)
                                                                                                                                    (x (c + 1) z)
                                                                                                                        else do let num2 = a * 100 + b * 10 + a
                                                                                                                                bc <- ifM (palindrome2 pow2 num2)
                                                                                                                                          (do printf "%d\n" (num2::Int) :: IO()
                                                                                                                                              let be = y + num2
                                                                                                                                              return be)
                                                                                                                                          (return y)
                                                                                                                                let num3 = a * 1000 + b * 100 + b * 10 + a
                                                                                                                                ifM (palindrome2 pow2 num3)
                                                                                                                                    (do printf "%d\n" (num3::Int) :: IO()
                                                                                                                                        let bd = bc + num3
                                                                                                                                        v (b + 1) bd)
                                                                                                                                    (v (b + 1) bc) in
                                                                                                                        x 0 w
                                                                                                             else s (a0 + 1) w in
                                                                                                             v 0 u
                                                                                               else printf "sum=%d\n" (u::Int) :: IO() in
                                                                                               s 0 m in
                                                                                    l 1 0)


