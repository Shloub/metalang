#lang racket
(require racket/block)

(define main
  (block
    (display "Hello World")
    (let ([a 5])
    (block
      (printf "~a \n~afoo" (* (+ 4 6) 2) a)
      (if (and (eq? (- (- (+ 1 (quotient (* (+ 1 1) 2 (+ 3 8)) 4)) (- 1 2)) 3) 12) #t)
      (display "True")
      (display "False"))
      (display "\n")
      (if (eq? (eq? (* 3 (+ 4 5 6) 2) 45) #f)
      (display "True")
      (display "False"))
      (display " ")
      (if (eq? (eq? 2 1) #f)
      (display "True")
      (display "False"))
      (printf " ~a~a" (quotient (quotient (+ 4 1) 3) (+ 2 1)) (quotient (quotient (* 4 1) 3) (* 2 1)))
      (if (not (and (not (eq? a 0)) (not (eq? a 4))))
      (display "True")
      (display "False"))
      (if (and #t (not #f) (not (and #t #f)))
      (display "True")
      (display "False"))
      (display "\n")
      ))
    )
)

