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



okdigits ok n =
  do let f () = return (())
     (if (n == 0)
     then return (True)
     else do let digit = (n `rem` 10)
             let g () = (f ())
             ifM ((readIOA ok digit))
                 (do writeIOA ok digit False
                     o <- (okdigits ok (n `quot` 10))
                     writeIOA ok digit True
                     return (o))
                 (return (False)))
main =
  do let count = 0
     ((\ (k, allowed) ->
        do return (k)
           ((\ (m, counted) ->
              do return (m)
                 let bc = 1
                 let bd = 9
                 let p e bf =
                       (if (e <= bd)
                       then do writeIOA allowed e False
                               let ba = 1
                               let bb = 9
                               let q b bg =
                                     (if (b <= bb)
                                     then do bh <- ifM ((readIOA allowed b))
                                                       (do writeIOA allowed b False
                                                           let be = ((b * e) `rem` 10)
                                                           bi <- ifM ((readIOA allowed be))
                                                                     (do writeIOA allowed be False
                                                                         let y = 1
                                                                         let z = 9
                                                                         let r a bj =
                                                                               (if (a <= z)
                                                                               then do bk <- ifM ((readIOA allowed a))
                                                                                                 (do writeIOA allowed a False
                                                                                                     let w = 1
                                                                                                     let x = 9
                                                                                                     let s c bl =
                                                                                                           (if (c <= x)
                                                                                                           then do bm <- ifM ((readIOA allowed c))
                                                                                                                             (do writeIOA allowed c False
                                                                                                                                 let u = 1
                                                                                                                                 let v = 9
                                                                                                                                 let t d bn =
                                                                                                                                       (if (d <= v)
                                                                                                                                       then do bo <- ifM ((readIOA allowed d))
                                                                                                                                                         (do writeIOA allowed d False
                                                                                                                                                             {- 2 * 3 digits -}
                                                                                                                                                             do let product = (((a * 10) + b) * (((c * 100) + (d * 10)) + e))
                                                                                                                                                                bp <- ifM (((fmap (not) (readIOA counted product)) <&&> (okdigits allowed (product `quot` 10))))
                                                                                                                                                                          (do writeIOA counted product True
                                                                                                                                                                              let bq = (bn + product)
                                                                                                                                                                              printf "%d" (product :: Int)::IO()
                                                                                                                                                                              printf " " ::IO()
                                                                                                                                                                              return (bq))
                                                                                                                                                                          (return (bn))
                                                                                                                                                                {- 1  * 4 digits -}
                                                                                                                                                                do let product2 = (b * ((((a * 1000) + (c * 100)) + (d * 10)) + e))
                                                                                                                                                                   br <- ifM (((fmap (not) (readIOA counted product2)) <&&> (okdigits allowed (product2 `quot` 10))))
                                                                                                                                                                             (do writeIOA counted product2 True
                                                                                                                                                                                 let bs = (bp + product2)
                                                                                                                                                                                 printf "%d" (product2 :: Int)::IO()
                                                                                                                                                                                 printf " " ::IO()
                                                                                                                                                                                 return (bs))
                                                                                                                                                                             (return (bp))
                                                                                                                                                                   writeIOA allowed d True
                                                                                                                                                                   return (br))
                                                                                                                                                         (return (bn))
                                                                                                                                               (t (d + 1) bo)
                                                                                                                                       else do writeIOA allowed c True
                                                                                                                                               return (bn)) in
                                                                                                                                       (t u bl))
                                                                                                                             (return (bl))
                                                                                                                   (s (c + 1) bm)
                                                                                                           else do writeIOA allowed a True
                                                                                                                   return (bl)) in
                                                                                                           (s w bj))
                                                                                                 (return (bj))
                                                                                       (r (a + 1) bk)
                                                                               else do writeIOA allowed be True
                                                                                       return (bj)) in
                                                                               (r y bg))
                                                                     (return (bg))
                                                           writeIOA allowed b True
                                                           return (bi))
                                                       (return (bg))
                                             (q (b + 1) bh)
                                     else do writeIOA allowed e True
                                             (p (e + 1) bg)) in
                                     (q ba bf)
                       else do printf "%d" (bf :: Int)::IO()
                               printf "\n" ::IO()) in
                       (p bc count)) =<< (array_init_withenv 100000 (\ j () ->
                                                                      let l = False
                                                                              in return (((), l))) ()))) =<< (array_init_withenv 10 (\ i () ->
                                                                                                                                      let h = (i /= 0)
                                                                                                                                              in return (((), h))) ()))

