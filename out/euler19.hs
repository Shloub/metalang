import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e

main :: IO ()
is_leap year =
  return ((year `rem` 400) == 0 || ((year `rem` 100) /= 0 && (year `rem` 4) == 0))

ndayinmonth month year =
  if month == 0
  then return 31
  else if month == 1
       then ifM (is_leap year)
                (return 29)
                (return 28)
       else return (if month == 2
                    then 31
                    else if month == 3
                         then 30
                         else if month == 4
                              then 31
                              else if month == 5
                                   then 30
                                   else if month == 6
                                        then 31
                                        else if month == 7
                                             then 31
                                             else if month == 8
                                                  then 30
                                                  else if month == 9
                                                       then 31
                                                       else if month == 10
                                                            then 30
                                                            else if month == 11
                                                                 then 31
                                                                 else 0)

main =
  do let month = 0
     let year = 1901
     let dayofweek = 1
     {- 01-01-1901 : mardi -}
     do let count = 0
        let a b c d e =
              if e /= 2001
              then do ndays <- ndayinmonth d e
                      let f = (c + ndays) `rem` 7
                      let g = d + 1
                      (\ (h, i) ->
                        if (f `rem` 7) == 6
                        then do let j = b + 1
                                a j f h i
                        else a b f h i) (if g == 12
                                         then let k = 0
                                                      in let l = e + 1
                                                                 in (k, l)
                                         else (g, e))
              else printf "%d\n" (b::Int) :: IO() in
              a count dayofweek month year


