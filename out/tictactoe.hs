import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef

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
                                                                                                                                                                                                                                                                        
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

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
     let p y =
           (if (y <= 2)
           then let q x =
                      (if (x <= 2)
                      then do ifM (((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y)) <*> return (0)))
                                  (printf " " ::IO())
                                  (ifM (((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y)) <*> return (1)))
                                       (printf "O" ::IO())
                                       (printf "X" ::IO()))
                              printf "|" ::IO()
                              (q (x + 1))
                      else (if (y /= 2)
                           then do printf "\n|-|-|-|\n|" ::IO()
                                   (p (y + 1))
                           else (p (y + 1)))) in
                      (q 0)
           else printf "\n" ::IO()) in
           (p 0)

eval0 g =
  do let win = 0
     let freecase = 0
     let n y t u =
           (if (y <= 2)
           then do let col = (- 1)
                   let lin = (- 1)
                   let o x v w z =
                         (if (x <= 2)
                         then do ba <- ifM (((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y)) <*> return (0)))
                                           (let bb = (w + 1)
                                                     in return (bb))
                                           (return (w))
                                 colv <- join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y))
                                 linv <- join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (y)) <*> return (x))
                                 let bc = (if ((v == (- 1)) && (colv /= 0))
                                          then let bd = colv
                                                        in bd
                                          else (if (colv /= v)
                                               then let be = (- 2)
                                                             in be
                                               else v))
                                 (if ((z == (- 1)) && (linv /= 0))
                                 then do let bf = linv
                                         (o (x + 1) bc ba bf)
                                 else (if (linv /= z)
                                      then do let bg = (- 2)
                                              (o (x + 1) bc ba bg)
                                      else (o (x + 1) bc ba z)))
                         else (if (v >= 0)
                              then do let bh = v
                                      (n (y + 1) w bh)
                              else (if (z >= 0)
                                   then do let bi = z
                                           (n (y + 1) w bi)
                                   else (n (y + 1) w u)))) in
                         (o 0 col t lin)
           else let l x bj =
                      (if (x <= 2)
                      then do bk <- ifM (((((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (0)) <*> return (0)) <*> return (x)) <&&> ((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (1)) <*> return (1)) <*> return (x))) <&&> ((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (2)) <*> return (2)) <*> return (x))))
                                        (let bl = x
                                                  in return (bl))
                                        (return (bj))
                              ifM (((((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (0)) <*> return (2)) <*> return (x)) <&&> ((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (1)) <*> return (1)) <*> return (x))) <&&> ((==) <$> join (readIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (2)) <*> return (0)) <*> return (x))))
                                  (do let bm = x
                                      (l (x + 1) bm))
                                  ((l (x + 1) bk))
                      else do (writeIORef (_ended g) ((bj /= 0) || (t == 0)))
                              (if (bj == 1)
                              then (writeIORef (_note g) 1000)
                              else (if (bj == 2)
                                   then (writeIORef (_note g) (- 1000))
                                   else (writeIORef (_note g) 0)))) in
                      (l 1 u)) in
           (n 0 freecase win)

apply_move_xy x y g =
  do let player = 2
     bn <- ifM ((readIORef (_firstToPlay g)))
               (let bo = 1
                         in return (bo))
               (return (player))
     join (writeIOA <$> join (readIOA <$> (readIORef (_cases g)) <*> return (x)) <*> return (y) <*> return (bn))
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
             bp <- ifM ((fmap (not) (readIORef (_firstToPlay g))))
                       (let bq = 10000
                                 in return (bq))
                       (return (maxNote))
             let h x br =
                   (if (x <= 2)
                   then let k y bs =
                              (if (y <= 2)
                              then ifM ((can_move_xy x y g))
                                       (do (apply_move_xy x y g)
                                           currentNote <- (minmax g)
                                           (cancel_move_xy x y g)
                                           {- Minimum ou Maximum selon le coté ou l'on joue-}
                                           ifM ((((==) (currentNote > bs)) <$> (readIORef (_firstToPlay g))))
                                               (do let bt = currentNote
                                                   (k (y + 1) bt))
                                               ((k (y + 1) bs)))
                                       ((k (y + 1) bs))
                              else (h (x + 1) bs)) in
                              (k 0 br)
                   else return (br)) in
                   (h 0 bp))

play g =
  do minMove <- (Move <$> (newIORef 0) <*> (newIORef 0))
     let minNote = 10000
     let e x bu =
           (if (x <= 2)
           then let f y bv =
                      (if (y <= 2)
                      then ifM ((can_move_xy x y g))
                               (do (apply_move_xy x y g)
                                   currentNote <- (minmax g)
                                   printf "%d" (x :: Int)::IO()
                                   printf ", " ::IO()
                                   printf "%d" (y :: Int)::IO()
                                   printf ", " ::IO()
                                   printf "%d" (currentNote :: Int)::IO()
                                   printf "\n" ::IO()
                                   (cancel_move_xy x y g)
                                   (if (currentNote < bv)
                                   then do let bw = currentNote
                                           (writeIORef (_x minMove) x)
                                           (writeIORef (_y minMove) y)
                                           (f (y + 1) bw)
                                   else (f (y + 1) bv)))
                               ((f (y + 1) bv))
                      else (e (x + 1) bv)) in
                      (f 0 bu)
           else do printf "%d" =<< ((readIORef (_x minMove)) :: IO Int)
                   printf "%d" =<< ((readIORef (_y minMove)) :: IO Int)
                   printf "\n" ::IO()
                   return (minMove)) in
           (e 0 minNote)

init0 () =
  ((\ (b, cases) ->
     (Gamestate <$> (newIORef cases) <*> (newIORef True) <*> (newIORef 0) <*> (newIORef False))) =<< (array_init_withenv 3 (\ i b ->
                                                                                                                             ((\ (d, tab) ->
                                                                                                                                let a = tab
                                                                                                                                        in return (((), a))) =<< (array_init_withenv 3 (\ j d ->
                                                                                                                                                                                         let c = 0
                                                                                                                                                                                                 in return (((), c))) ()))) ()))

read_move () =
  do x <- read_int
     skip_whitespaces
     y <- read_int
     skip_whitespaces
     (Move <$> (newIORef x) <*> (newIORef y))

main =
  let r i =
        (if (i <= 1)
        then do state <- (init0 ())
                (join (apply_move <$> (Move <$> (newIORef 1) <*> (newIORef 1)) <*> (return state)))
                (join (apply_move <$> (Move <$> (newIORef 0) <*> (newIORef 0)) <*> (return state)))
                let s () =
                      ifM ((fmap (not) (readIORef (_ended state))))
                          (do (print_state state)
                              (join (apply_move <$> (play state) <*> (return state)))
                              (eval0 state)
                              (print_state state)
                              ifM ((fmap (not) (readIORef (_ended state))))
                                  (do (join (apply_move <$> (play state) <*> (return state)))
                                      (eval0 state)
                                      (s ()))
                                  ((s ())))
                          (do (print_state state)
                              printf "%d" =<< ((readIORef (_note state)) :: IO Int)
                              printf "\n" ::IO()
                              (r (i + 1))) in
                      (s ())
        else return (())) in
        (r 0)


