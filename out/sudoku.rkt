#lang racket
(require racket/block)
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
(define mread-int (lambda ()
  (if (eq? #\- last-char)
  (block
    (next-char) (- 0 (mread-int)))
    (letrec ([w (lambda (out)
      (if (eof-object? last-char)
        out
        (if (and last-char (>= (char->integer last-char) (char->integer #\0)) (<= (char->integer last-char) (char->integer #\9)))
          (let ([out (+ (* 10 out) (- (char->integer last-char) (char->integer #\0)))])
            (block
              (next-char)
              (w out)
          ))
        out
      )))]) (w 0)))))
(define mread-blank (lambda ()
  (if (or (eq? last-char #\NewLine) (eq? last-char #\Space) ) (block (next-char) (mread-blank)) '())
))

(define (read_sudoku _)
  (build-vector (* 9 9) (lambda (i) 
                          ((lambda (k) 
                             (block
                               (mread-blank)
                               k
                               )) (mread-int))))
)

(define (print_sudoku sudoku0)
  (letrec ([a (lambda (y) (if (<= y 8)
                          (letrec ([b (lambda (x) (if (<= x 8)
                                                  (block
                                                    (printf "~a " (vector-ref sudoku0 (+ x (* y 9))))
                                                    (if (eq? (remainder x 3) 2)
                                                    (block
                                                      (display " ")
                                                      (b (+ x 1))
                                                      )
                                                    (b (+ x 1)))
                                                    )
                                                  (block
                                                    (display "\n")
                                                    (if (eq? (remainder y 3) 2)
                                                    (block
                                                      (display "\n")
                                                      (a (+ y 1))
                                                      )
                                                    (a (+ y 1)))
                                                    )))])
                            (b 0))
                          (display "\n")))])
    (a 0))
)

(define (sudoku_done s)
  (letrec ([c (lambda (i) (if (<= i 80)
                          (if (eq? (vector-ref s i) 0)
                          #f
                          (c (+ i 1)))
                          #t))])
    (c 0))
)

(define (sudoku_error s)
  (let ([out1 #f])
  (letrec ([d (lambda (x out1) (if (<= x 8)
                               (let ([out1 (or out1 (and (not (eq? (vector-ref s x) 0)) (eq? (vector-ref s x) (vector-ref s (+ x 9)))) (and (not (eq? (vector-ref s x) 0)) (eq? (vector-ref s x) (vector-ref s (+ x (* 9 2))))) (and (not (eq? (vector-ref s (+ x 9)) 0)) (eq? (vector-ref s (+ x 9)) (vector-ref s (+ x (* 9 2))))) (and (not (eq? (vector-ref s x) 0)) (eq? (vector-ref s x) (vector-ref s (+ x (* 9 3))))) (and (not (eq? (vector-ref s (+ x 9)) 0)) (eq? (vector-ref s (+ x 9)) (vector-ref s (+ x (* 9 3))))) (and (not (eq? (vector-ref s (+ x (* 9 2))) 0)) (eq? (vector-ref s (+ x (* 9 2))) (vector-ref s (+ x (* 9 3))))) (and (not (eq? (vector-ref s x) 0)) (eq? (vector-ref s x) (vector-ref s (+ x (* 9 4))))) (and (not (eq? (vector-ref s (+ x 9)) 0)) (eq? (vector-ref s (+ x 9)) (vector-ref s (+ x (* 9 4))))) (and (not (eq? (vector-ref s (+ x (* 9 2))) 0)) (eq? (vector-ref s (+ x (* 9 2))) (vector-ref s (+ x (* 9 4))))) (and (not (eq? (vector-ref s (+ x (* 9 3))) 0)) (eq? (vector-ref s (+ x (* 9 3))) (vector-ref s (+ x (* 9 4))))) (and (not (eq? (vector-ref s x) 0)) (eq? (vector-ref s x) (vector-ref s (+ x (* 9 5))))) (and (not (eq? (vector-ref s (+ x 9)) 0)) (eq? (vector-ref s (+ x 9)) (vector-ref s (+ x (* 9 5))))) (and (not (eq? (vector-ref s (+ x (* 9 2))) 0)) (eq? (vector-ref s (+ x (* 9 2))) (vector-ref s (+ x (* 9 5))))) (and (not (eq? (vector-ref s (+ x (* 9 3))) 0)) (eq? (vector-ref s (+ x (* 9 3))) (vector-ref s (+ x (* 9 5))))) (and (not (eq? (vector-ref s (+ x (* 9 4))) 0)) (eq? (vector-ref s (+ x (* 9 4))) (vector-ref s (+ x (* 9 5))))) (and (not (eq? (vector-ref s x) 0)) (eq? (vector-ref s x) (vector-ref s (+ x (* 9 6))))) (and (not (eq? (vector-ref s (+ x 9)) 0)) (eq? (vector-ref s (+ x 9)) (vector-ref s (+ x (* 9 6))))) (and (not (eq? (vector-ref s (+ x (* 9 2))) 0)) (eq? (vector-ref s (+ x (* 9 2))) (vector-ref s (+ x (* 9 6))))) (and (not (eq? (vector-ref s (+ x (* 9 3))) 0)) (eq? (vector-ref s (+ x (* 9 3))) (vector-ref s (+ x (* 9 6))))) (and (not (eq? (vector-ref s (+ x (* 9 4))) 0)) (eq? (vector-ref s (+ x (* 9 4))) (vector-ref s (+ x (* 9 6))))) (and (not (eq? (vector-ref s (+ x (* 9 5))) 0)) (eq? (vector-ref s (+ x (* 9 5))) (vector-ref s (+ x (* 9 6))))) (and (not (eq? (vector-ref s x) 0)) (eq? (vector-ref s x) (vector-ref s (+ x (* 9 7))))) (and (not (eq? (vector-ref s (+ x 9)) 0)) (eq? (vector-ref s (+ x 9)) (vector-ref s (+ x (* 9 7))))) (and (not (eq? (vector-ref s (+ x (* 9 2))) 0)) (eq? (vector-ref s (+ x (* 9 2))) (vector-ref s (+ x (* 9 7))))) (and (not (eq? (vector-ref s (+ x (* 9 3))) 0)) (eq? (vector-ref s (+ x (* 9 3))) (vector-ref s (+ x (* 9 7))))) (and (not (eq? (vector-ref s (+ x (* 9 4))) 0)) (eq? (vector-ref s (+ x (* 9 4))) (vector-ref s (+ x (* 9 7))))) (and (not (eq? (vector-ref s (+ x (* 9 5))) 0)) (eq? (vector-ref s (+ x (* 9 5))) (vector-ref s (+ x (* 9 7))))) (and (not (eq? (vector-ref s (+ x (* 9 6))) 0)) (eq? (vector-ref s (+ x (* 9 6))) (vector-ref s (+ x (* 9 7))))) (and (not (eq? (vector-ref s x) 0)) (eq? (vector-ref s x) (vector-ref s (+ x (* 9 8))))) (and (not (eq? (vector-ref s (+ x 9)) 0)) (eq? (vector-ref s (+ x 9)) (vector-ref s (+ x (* 9 8))))) (and (not (eq? (vector-ref s (+ x (* 9 2))) 0)) (eq? (vector-ref s (+ x (* 9 2))) (vector-ref s (+ x (* 9 8))))) (and (not (eq? (vector-ref s (+ x (* 9 3))) 0)) (eq? (vector-ref s (+ x (* 9 3))) (vector-ref s (+ x (* 9 8))))) (and (not (eq? (vector-ref s (+ x (* 9 4))) 0)) (eq? (vector-ref s (+ x (* 9 4))) (vector-ref s (+ x (* 9 8))))) (and (not (eq? (vector-ref s (+ x (* 9 5))) 0)) (eq? (vector-ref s (+ x (* 9 5))) (vector-ref s (+ x (* 9 8))))) (and (not (eq? (vector-ref s (+ x (* 9 6))) 0)) (eq? (vector-ref s (+ x (* 9 6))) (vector-ref s (+ x (* 9 8))))) (and (not (eq? (vector-ref s (+ x (* 9 7))) 0)) (eq? (vector-ref s (+ x (* 9 7))) (vector-ref s (+ x (* 9 8))))))])
                               (d (+ x 1) out1))
                               (let ([out2 #f])
                               (letrec ([e (lambda (x out2) (if (<= x 8)
                                                            (let ([out2 (or out2 (and (not (eq? (vector-ref s (* x 9)) 0)) (eq? (vector-ref s (* x 9)) (vector-ref s (+ (* x 9) 1)))) (and (not (eq? (vector-ref s (* x 9)) 0)) (eq? (vector-ref s (* x 9)) (vector-ref s (+ (* x 9) 2)))) (and (not (eq? (vector-ref s (+ (* x 9) 1)) 0)) (eq? (vector-ref s (+ (* x 9) 1)) (vector-ref s (+ (* x 9) 2)))) (and (not (eq? (vector-ref s (* x 9)) 0)) (eq? (vector-ref s (* x 9)) (vector-ref s (+ (* x 9) 3)))) (and (not (eq? (vector-ref s (+ (* x 9) 1)) 0)) (eq? (vector-ref s (+ (* x 9) 1)) (vector-ref s (+ (* x 9) 3)))) (and (not (eq? (vector-ref s (+ (* x 9) 2)) 0)) (eq? (vector-ref s (+ (* x 9) 2)) (vector-ref s (+ (* x 9) 3)))) (and (not (eq? (vector-ref s (* x 9)) 0)) (eq? (vector-ref s (* x 9)) (vector-ref s (+ (* x 9) 4)))) (and (not (eq? (vector-ref s (+ (* x 9) 1)) 0)) (eq? (vector-ref s (+ (* x 9) 1)) (vector-ref s (+ (* x 9) 4)))) (and (not (eq? (vector-ref s (+ (* x 9) 2)) 0)) (eq? (vector-ref s (+ (* x 9) 2)) (vector-ref s (+ (* x 9) 4)))) (and (not (eq? (vector-ref s (+ (* x 9) 3)) 0)) (eq? (vector-ref s (+ (* x 9) 3)) (vector-ref s (+ (* x 9) 4)))) (and (not (eq? (vector-ref s (* x 9)) 0)) (eq? (vector-ref s (* x 9)) (vector-ref s (+ (* x 9) 5)))) (and (not (eq? (vector-ref s (+ (* x 9) 1)) 0)) (eq? (vector-ref s (+ (* x 9) 1)) (vector-ref s (+ (* x 9) 5)))) (and (not (eq? (vector-ref s (+ (* x 9) 2)) 0)) (eq? (vector-ref s (+ (* x 9) 2)) (vector-ref s (+ (* x 9) 5)))) (and (not (eq? (vector-ref s (+ (* x 9) 3)) 0)) (eq? (vector-ref s (+ (* x 9) 3)) (vector-ref s (+ (* x 9) 5)))) (and (not (eq? (vector-ref s (+ (* x 9) 4)) 0)) (eq? (vector-ref s (+ (* x 9) 4)) (vector-ref s (+ (* x 9) 5)))) (and (not (eq? (vector-ref s (* x 9)) 0)) (eq? (vector-ref s (* x 9)) (vector-ref s (+ (* x 9) 6)))) (and (not (eq? (vector-ref s (+ (* x 9) 1)) 0)) (eq? (vector-ref s (+ (* x 9) 1)) (vector-ref s (+ (* x 9) 6)))) (and (not (eq? (vector-ref s (+ (* x 9) 2)) 0)) (eq? (vector-ref s (+ (* x 9) 2)) (vector-ref s (+ (* x 9) 6)))) (and (not (eq? (vector-ref s (+ (* x 9) 3)) 0)) (eq? (vector-ref s (+ (* x 9) 3)) (vector-ref s (+ (* x 9) 6)))) (and (not (eq? (vector-ref s (+ (* x 9) 4)) 0)) (eq? (vector-ref s (+ (* x 9) 4)) (vector-ref s (+ (* x 9) 6)))) (and (not (eq? (vector-ref s (+ (* x 9) 5)) 0)) (eq? (vector-ref s (+ (* x 9) 5)) (vector-ref s (+ (* x 9) 6)))) (and (not (eq? (vector-ref s (* x 9)) 0)) (eq? (vector-ref s (* x 9)) (vector-ref s (+ (* x 9) 7)))) (and (not (eq? (vector-ref s (+ (* x 9) 1)) 0)) (eq? (vector-ref s (+ (* x 9) 1)) (vector-ref s (+ (* x 9) 7)))) (and (not (eq? (vector-ref s (+ (* x 9) 2)) 0)) (eq? (vector-ref s (+ (* x 9) 2)) (vector-ref s (+ (* x 9) 7)))) (and (not (eq? (vector-ref s (+ (* x 9) 3)) 0)) (eq? (vector-ref s (+ (* x 9) 3)) (vector-ref s (+ (* x 9) 7)))) (and (not (eq? (vector-ref s (+ (* x 9) 4)) 0)) (eq? (vector-ref s (+ (* x 9) 4)) (vector-ref s (+ (* x 9) 7)))) (and (not (eq? (vector-ref s (+ (* x 9) 5)) 0)) (eq? (vector-ref s (+ (* x 9) 5)) (vector-ref s (+ (* x 9) 7)))) (and (not (eq? (vector-ref s (+ (* x 9) 6)) 0)) (eq? (vector-ref s (+ (* x 9) 6)) (vector-ref s (+ (* x 9) 7)))) (and (not (eq? (vector-ref s (* x 9)) 0)) (eq? (vector-ref s (* x 9)) (vector-ref s (+ (* x 9) 8)))) (and (not (eq? (vector-ref s (+ (* x 9) 1)) 0)) (eq? (vector-ref s (+ (* x 9) 1)) (vector-ref s (+ (* x 9) 8)))) (and (not (eq? (vector-ref s (+ (* x 9) 2)) 0)) (eq? (vector-ref s (+ (* x 9) 2)) (vector-ref s (+ (* x 9) 8)))) (and (not (eq? (vector-ref s (+ (* x 9) 3)) 0)) (eq? (vector-ref s (+ (* x 9) 3)) (vector-ref s (+ (* x 9) 8)))) (and (not (eq? (vector-ref s (+ (* x 9) 4)) 0)) (eq? (vector-ref s (+ (* x 9) 4)) (vector-ref s (+ (* x 9) 8)))) (and (not (eq? (vector-ref s (+ (* x 9) 5)) 0)) (eq? (vector-ref s (+ (* x 9) 5)) (vector-ref s (+ (* x 9) 8)))) (and (not (eq? (vector-ref s (+ (* x 9) 6)) 0)) (eq? (vector-ref s (+ (* x 9) 6)) (vector-ref s (+ (* x 9) 8)))) (and (not (eq? (vector-ref s (+ (* x 9) 7)) 0)) (eq? (vector-ref s (+ (* x 9) 7)) (vector-ref s (+ (* x 9) 8)))))])
                                                            (e (+ x 1) out2))
                                                            (let ([out3 #f])
                                                            (letrec ([f (lambda (x out3) 
                                                              (if (<= x 8)
                                                              (let ([out3 (or out3 (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 2)) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 2)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 2)) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 2)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 1)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) 0)) (eq? (vector-ref s (+ (* (remainder x 3) 3 9) (* (quotient x 3) 3) 2)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 2)) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 1) 9) (* (quotient x 3) 3) 2)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3))) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 2)))) (and (not (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 1)) 0)) (eq? (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 1)) (vector-ref s (+ (* (+ (* (remainder x 3) 3) 2) 9) (* (quotient x 3) 3) 2)))))])
                                                              (f (+ x 1) out3))
                                                              (or out1 out2 out3)))])
                                                              (f 0 out3)))))])
                                 (e 0 out2)))))])
    (d 0 out1)))
)

(define (solve sudoku0)
  (if (sudoku_error sudoku0)
  #f
  (if (sudoku_done sudoku0)
  #t
  (letrec ([g (lambda (i) (if (<= i 80)
                          (if (eq? (vector-ref sudoku0 i) 0)
                          (letrec ([h (lambda (p) (if (<= p 9)
                                                  (block
                                                    (vector-set! sudoku0 i p)
                                                    (if (solve sudoku0)
                                                    #t
                                                    (h (+ p 1)))
                                                    )
                                                  (block
                                                    (vector-set! sudoku0 i 0)
                                                    #f
                                                    )))])
                            (h 1))
                          (g (+ i 1)))
                          #f))])
    (g 0))))
)

(define main
  (let ([sudoku0 (read_sudoku 'nil)])
  (block
    (print_sudoku sudoku0)
    (if (solve sudoku0)
    (block
      (print_sudoku sudoku0)
      '()
      )
    (display "no solution\n"))
    ))
)

