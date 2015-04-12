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
  (array_init_withenv 20 (\ i bc ->
                            let bd = bc * 2
                                     in let be = bd `quot` 2
                                                 in return (bd, be)) 1) >>= (\ (h, pow2) ->
                                                                              let l d m =
                                                                                    if d <= 9
                                                                                    then do o <- ifM (palindrome2 pow2 d)
                                                                                                     (do printf "%d\n" (d::Int) :: IO()
                                                                                                         return (m + d))
                                                                                                     (return m)
                                                                                            ifM (palindrome2 pow2 (d * 10 + d))
                                                                                                (do printf "%d\n" ((d * 10 + d)::Int) :: IO()
                                                                                                    let q = o + d * 10 + d
                                                                                                    l (d + 1) q)
                                                                                                (l (d + 1) o)
                                                                                    else let r a0 s =
                                                                                               if a0 <= 4
                                                                                               then do let a = a0 * 2 + 1
                                                                                                       let u b v =
                                                                                                             if b <= 9
                                                                                                             then let w c x =
                                                                                                                        if c <= 9
                                                                                                                        then do let num0 = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a
                                                                                                                                y <- ifM (palindrome2 pow2 num0)
                                                                                                                                         (do printf "%d\n" (num0::Int) :: IO()
                                                                                                                                             return (x + num0))
                                                                                                                                         (return x)
                                                                                                                                let num1 = a * 10000 + b * 1000 + c * 100 + b * 10 + a
                                                                                                                                ifM (palindrome2 pow2 num1)
                                                                                                                                    (do printf "%d\n" (num1::Int) :: IO()
                                                                                                                                        let z = y + num1
                                                                                                                                        w (c + 1) z)
                                                                                                                                    (w (c + 1) y)
                                                                                                                        else do let num2 = a * 100 + b * 10 + a
                                                                                                                                ba <- ifM (palindrome2 pow2 num2)
                                                                                                                                          (do printf "%d\n" (num2::Int) :: IO()
                                                                                                                                              return (x + num2))
                                                                                                                                          (return x)
                                                                                                                                let num3 = a * 1000 + b * 100 + b * 10 + a
                                                                                                                                ifM (palindrome2 pow2 num3)
                                                                                                                                    (do printf "%d\n" (num3::Int) :: IO()
                                                                                                                                        let bb = ba + num3
                                                                                                                                        u (b + 1) bb)
                                                                                                                                    (u (b + 1) ba) in
                                                                                                                        w 0 v
                                                                                                             else r (a0 + 1) v in
                                                                                                             u 0 s
                                                                                               else printf "sum=%d\n" (s::Int) :: IO() in
                                                                                               r 0 m in
                                                                                    l 1 0)


