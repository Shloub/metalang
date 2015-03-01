#lang racket
(require racket/block)

(define main
  (let ([i 0])
  (let ([i (- i 1)])
  (block
    (printf "~a\n" i)
    (let ([i (+ i 55)])
    (block
      (printf "~a\n" i)
      (let ([i (* i 13)])
      (block
        (printf "~a\n" i)
        (let ([i (quotient i 2)])
        (block
          (printf "~a\n" i)
          (let ([i (+ i 1)])
          (block
            (printf "~a\n" i)
            (let ([i (quotient i 3)])
            (block
              (printf "~a\n" i)
              (let ([i (- i 1)])
              (block
                (printf "~a\n" i)
                ;
                ;http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
                ;
                (printf "~a\n~a\n~a\n~a\n~a\n~a\n~a\n~a\n" (quotient 117 17) (quotient 117 (- 17)) (quotient (- 117) 17) (quotient (- 117) (- 17)) (remainder 117 17) (remainder 117 (- 17)) (remainder (- 117) 17) (remainder (- 117) (- 17)))
                ))
              ))
            ))
          ))
        ))
      ))
    )))
)

