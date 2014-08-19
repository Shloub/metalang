#lang racket
(require racket/block)

(define main
  (let ([i 0])
  (let ([i (- i 1)])
  (block
    (display i)
    (display "\n")
    (let ([i (+ i 55)])
    (block
      (display i)
      (display "\n")
      (let ([i (* i 13)])
      (block
        (display i)
        (display "\n")
        (let ([i (quotient i 2)])
        (block
          (display i)
          (display "\n")
          (let ([i (+ i 1)])
          (block
            (display i)
            (display "\n")
            (let ([i (quotient i 3)])
            (block
              (display i)
              (display "\n")
              (let ([i (- i 1)])
              (block
                (display i)
                (display "\n")
                ;
                ;http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
                ;
                (block
                  (display (quotient 117 17))
                  (display "\n")
                  (display (quotient 117 (- 17)))
                  (display "\n")
                  (display (quotient (- 117) 17))
                  (display "\n")
                  (display (quotient (- 117) (- 17)))
                  (display "\n")
                  (display (remainder 117 17))
                  (display "\n")
                  (display (remainder 117 (- 17)))
                  (display "\n")
                  (display (remainder (- 117) 17))
                  (display "\n")
                  (display (remainder (- 117) (- 17)))
                  (display "\n")
                  )
                ))
              ))
            ))
          ))
        ))
      ))
    )))
)

