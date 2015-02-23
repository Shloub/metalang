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



data Gamestate = Gamestate {
                              _cases :: IORef (IOArray Int (IOArray Int Int)),
                              _firstToPlay :: IORef Bool,
                              _note :: IORef Int,
                              _ended :: IORef Bool
                              }
  deriving Eq

data Move = Move {
                    _x :: IORef Int,
                    _y :: IORef Int
                    }
  deriving Eq

print_state g =
  do printf "\n|" ::IO()
     let bj = 0
     let bk = 2
     let bf y =
            (if (y <= bk)
            then do let bh = 0
                    let bi = 2
                    let bg x =
                           (if (x <= bi)
                           then do ifM (((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y)) <*> return (0)))
                                       (printf " " ::IO())
                                       (do ifM (((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y)) <*> return (1)))
                                               (printf "O" ::IO())
                                               (printf "X" ::IO())
                                           return (()))
                                   printf "|" ::IO()
                                   (bg (x + 1))
                           else do (if (y /= 2)
                                   then printf "\n|-|-|-|\n|" ::IO()
                                   else return (()))
                                   (bf (y + 1))) in
                           (bg bh)
            else printf "\n" ::IO()) in
            (bf bj)
eval0 g =
  do let win = 0
     let freecase = 0
     let bd = 0
     let be = 2
     let z y bp bq =
           (if (y <= be)
           then do let col = (- 1)
                   let lin = (- 1)
                   let bb = 0
                   let bc = 2
                   let ba x br bs bt =
                          (if (x <= bc)
                          then do bu <- ifM (((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y)) <*> return (0)))
                                            (let bv = (bs + 1)
                                                      in return (bv))
                                            (return (bs))
                                  colv <- join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y))
                                  linv <- join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (y)) <*> return (x))
                                  let bw = (if ((br == (- 1)) && (colv /= 0))
                                           then let bx = colv
                                                         in bx
                                           else let by = (if (colv /= br)
                                                         then let bz = (- 2)
                                                                       in bz
                                                         else br)
                                                         in by)
                                  let ca = (if ((bt == (- 1)) && (linv /= 0))
                                           then let cb = linv
                                                         in cb
                                           else let cc = (if (linv /= bt)
                                                         then let cd = (- 2)
                                                                       in cd
                                                         else bt)
                                                         in cc)
                                  (ba (x + 1) bw bu ca)
                          else do let ce = (if (br >= 0)
                                           then let cf = br
                                                         in cf
                                           else let cg = (if (bt >= 0)
                                                         then let ch = bt
                                                                       in ch
                                                         else bq)
                                                         in cg)
                                  (z (y + 1) bs ce)) in
                          (ba bb col bp lin)
           else do let v = 1
                   let w = 2
                   let u x ci =
                         (if (x <= w)
                         then do cj <- ifM (((((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (0)) <*> return (0)) <*> return (x)) <&&> ((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (1)) <*> return (1)) <*> return (x))) <&&> ((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (2)) <*> return (2)) <*> return (x))))
                                           (let ck = x
                                                     in return (ck))
                                           (return (ci))
                                 cl <- ifM (((((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (0)) <*> return (2)) <*> return (x)) <&&> ((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (1)) <*> return (1)) <*> return (x))) <&&> ((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (2)) <*> return (0)) <*> return (x))))
                                           (let cm = x
                                                     in return (cm))
                                           (return (cj))
                                 (u (x + 1) cl)
                         else do (writeIORef (_ended g) ((ci /= 0) || (bp == 0)))
                                 (if (ci == 1)
                                 then (writeIORef (_note g) 1000)
                                 else do (if (ci == 2)
                                         then (writeIORef (_note g) (- 1000))
                                         else (writeIORef (_note g) 0))
                                         return (()))
                                 return (())) in
                         (u v bq)) in
           (z bd freecase win)
apply_move_xy x y g =
  do let player = 2
     cn <- ifM ((readIORef (_firstToPlay g)))
               (let co = 1
                         in return (co))
               (return (player))
     join (writeIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y) <*> return (cn))
     (join (writeIORef (_firstToPlay g) <$> (fmap (not) (readIORef (_firstToPlay g)))))
apply_move m g =
  do (join (apply_move_xy <$> (readIORef (_x m)) <*> (readIORef (_y m)) <*> (return g)))
     return (())
cancel_move_xy x y g =
  do join (writeIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y) <*> return (0))
     (join (writeIORef (_firstToPlay g) <$> (fmap (not) (readIORef (_firstToPlay g)))))
     (writeIORef (_ended g) False)
cancel_move m g =
  do (join (cancel_move_xy <$> (readIORef (_x m)) <*> (readIORef (_y m)) <*> (return g)))
     return (())
can_move_xy x y g =
  ((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y)) <*> return (0))
can_move m g =
  (join (can_move_xy <$> (readIORef (_x m)) <*> (readIORef (_y m)) <*> (return g)))
minmax g =
  do (eval0 g)
     ifM ((readIORef (_ended g)))
         ((readIORef (_note g)))
         (do let maxNote = (- 10000)
             cp <- ifM ((fmap (not) (readIORef (_firstToPlay g))))
                       (let cq = 10000
                                 in return (cq))
                       (return (maxNote))
             let s = 0
             let t = 2
             let o x cr =
                   (if (x <= t)
                   then do let q = 0
                           let r = 2
                           let p y cs =
                                 (if (y <= r)
                                 then do ct <- ifM ((can_move_xy x y g))
                                                   (do (apply_move_xy x y g)
                                                       currentNote <- (minmax g)
                                                       (cancel_move_xy x y g)
                                                       {- Minimum ou Maximum selon le coté ou l'on joue-}
                                                       do cu <- ifM ((((==) (currentNote > cs)) <$> (readIORef (_firstToPlay g))))
                                                                    (let cv = currentNote
                                                                              in return (cv))
                                                                    (return (cs))
                                                          return (cu))
                                                   (return (cs))
                                         (p (y + 1) ct)
                                 else (o (x + 1) cs)) in
                                 (p q cr)
                   else return (cr)) in
                   (o s cp))
play g =
  do minMove <- (Move <$> (newIORef 0) <*> (newIORef 0))
     let minNote = 10000
     let l = 0
     let n = 2
     let e x cw =
           (if (x <= n)
           then do let h = 0
                   let k = 2
                   let f y cx =
                         (if (y <= k)
                         then do cy <- ifM ((can_move_xy x y g))
                                           (do (apply_move_xy x y g)
                                               currentNote <- (minmax g)
                                               printf "%d" (x :: Int)::IO()
                                               printf ", " ::IO()
                                               printf "%d" (y :: Int)::IO()
                                               printf ", " ::IO()
                                               printf "%d" (currentNote :: Int)::IO()
                                               printf "\n" ::IO()
                                               (cancel_move_xy x y g)
                                               cz <- (if (currentNote < cx)
                                                     then do let da = currentNote
                                                             (writeIORef (_x minMove) x)
                                                             (writeIORef (_y minMove) y)
                                                             return (da)
                                                     else return (cx))
                                               return (cz))
                                           (return (cx))
                                 (f (y + 1) cy)
                         else (e (x + 1) cx)) in
                         (f h cw)
           else do printf "%d" =<< ((readIORef (_x minMove)) :: IO Int)
                   printf "%d" =<< ((readIORef (_y minMove)) :: IO Int)
                   printf "\n" ::IO()
                   return (minMove)) in
           (e l minNote)
init0 () =
  ((\ (b, cases) ->
     do return (b)
        (Gamestate <$> (newIORef cases) <*> (newIORef True) <*> (newIORef 0) <*> (newIORef False))) =<< (array_init_withenv 3 (\ i () ->
                                                                                                                                ((\ (d, tab) ->
                                                                                                                                   do return (d)
                                                                                                                                      let a = tab
                                                                                                                                      return (((), a))) =<< (array_init_withenv 3 (\ j () ->
                                                                                                                                                                                    let c = 0
                                                                                                                                                                                            in return (((), c))) ()))) ()))
read_move () =
  do x <- read_int
     skip_whitespaces
     y <- read_int
     skip_whitespaces
     (Move <$> (newIORef x) <*> (newIORef y))
main =
  do let bn = 0
     let bo = 1
     let bl i =
            (if (i <= bo)
            then do state <- (init0 ())
                    (join (apply_move <$> (Move <$> (newIORef 1) <*> (newIORef 1)) <*> (return state)))
                    (join (apply_move <$> (Move <$> (newIORef 0) <*> (newIORef 0)) <*> (return state)))
                    let bm () =
                           ifM ((fmap (not) (readIORef (_ended state))))
                               (do (print_state state)
                                   (join (apply_move <$> (play state) <*> (return state)))
                                   (eval0 state)
                                   (print_state state)
                                   ifM ((fmap (not) (readIORef (_ended state))))
                                       (do (join (apply_move <$> (play state) <*> (return state)))
                                           (eval0 state)
                                           return (()))
                                       (return (()))
                                   (bm ()))
                               (do (print_state state)
                                   printf "%d" =<< ((readIORef (_note state)) :: IO Int)
                                   printf "\n" ::IO()
                                   (bl (i + 1))) in
                           (bm ())
            else return (())) in
            (bl bn)

