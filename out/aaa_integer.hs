import Text.Printf

main =
  do
    i <- return $ 0
    i <- return $ ((i) + (-(1)))
    printf "%d" (i :: Integer)
    printf "%s" ("\n" :: String)
    i <- return $ i + 55
    printf "%d" (i :: Integer)
    printf "%s" ("\n" :: String)
    i <- return $ i * 13
    printf "%d" (i :: Integer)
    printf "%s" ("\n" :: String)
    i <- return $ (quot (i) (2))
    printf "%d" (i :: Integer)
    printf "%s" ("\n" :: String)
    i <- return $ i + 1
    printf "%d" (i :: Integer)
    printf "%s" ("\n" :: String)
    i <- return $ (quot (i) (3))
    printf "%d" (i :: Integer)
    printf "%s" ("\n" :: String)
    i <- return $ ((i) + (-(1)))
    printf "%d" (i :: Integer)
    printf "%s" ("\n" :: String)
    {-|
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
-}
    printf "%d" ((quot (117) (17)) :: Integer)
    printf "%s" ("\n" :: String)
    printf "%d" ((quot (117) ((-17))) :: Integer)
    printf "%s" ("\n" :: String)
    printf "%d" ((quot ((-117)) (17)) :: Integer)
    printf "%s" ("\n" :: String)
    printf "%d" ((quot ((-117)) ((-17))) :: Integer)
    printf "%s" ("\n" :: String)
    printf "%d" ((rem (117) (17)) :: Integer)
    printf "%s" ("\n" :: String)
    printf "%d" ((rem (117) ((-17))) :: Integer)
    printf "%s" ("\n" :: String)
    printf "%d" ((rem ((-117)) (17)) :: Integer)
    printf "%s" ("\n" :: String)
    printf "%d" ((rem ((-117)) ((-17))) :: Integer)
    printf "%s" ("\n" :: String)
  

 