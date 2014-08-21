#lang racket
(require racket/block)

(define main
  (let ([i 0])
  (let ([i (- i 1)])
  (block
    (map display (list i "\n"))
    (let ([i (+ i 55)])
    (block
      (map display (list i "\n"))
      (let ([i (* i 13)])
      (block
        (map display (list i "\n"))
        (let ([i (quotient i 2)])
        (block
          (map display (list i "\n"))
          (let ([i (+ i 1)])
          (block
            (map display (list i "\n"))
            (let ([i (quotient i 3)])
            (block
              (map display (list i "\n"))
              (let ([i (- i 1)])
              (block
                (map display (list i "\n"))
                ;
                ;http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
                ;
                (block
                  (map display (list (quotient 117 17) "\n" (quotient 117 (- 17)) "\n" (quotient (- 117) 17) "\n" (quotient (- 117) (- 17)) "\n" (remainder 117 17) "\n" (remainder 117 (- 17)) "\n" (remainder (- 117) 17) "\n" (remainder (- 117) (- 17)) "\n"))
                  )
                ))
              ))
            ))
          ))
        ))
      ))
    )))
)

