#lang racket
(require racket/block)

(define main
  (block
    (display "Hello World")
    (let ([a 5])
    (block
      (map display (list (* (+ 4 6) 2) " " "\n" a "foo" ""))
      (let ([b (and (eq? (- (- (+ 1 (quotient (* (* (+ 1 1) 2) (+ 3 8)) 4)) (- 1 2)) 3) 12) #t)])
      (block
        (if b
        (display "True")
        (display "False"))
        (display "\n")
        (let ([c (eq? (eq? (* (* 3 (+ (+ 4 5) 6)) 2) 45) #f)])
        (block
          (if c
          (display "True")
          (display "False"))
          (map display (list (quotient (quotient (+ 4 1) 3) (+ 2 1)) (quotient (quotient (* 4 1) 3) (* 2 1))))
          (let ([d (not (and (not (eq? a 0)) (not (eq? a 4))))])
          (block
            (if d
            (display "True")
            (display "False"))
            (let ([e (and (and #t (not #f)) (not (and #t #f)))])
            (block
              (if e
              (display "True")
              (display "False"))
              (display "\n")
              ))
            ))
          ))
        ))
      ))
    )
)

