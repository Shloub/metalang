#lang racket
(require racket/block)

(define main
  (let ([len (string->number (read-line))])
  (block
    (printf "~a=len\n" len)
    (let ([tab1 (list->vector (map string->number (regexp-split " " (read-line))))])
    (letrec ([f (lambda (i) 
                  (if (<= i (- len 1))
                  (block
                    (printf "~a=>~a\n" i (vector-ref tab1 i))
                    (f (+ i 1))
                    )
                  (let ([len (string->number (read-line))])
                  (let ([tab2 (build-vector (- len 1) (lambda (a) 
                                                        (list->vector (map string->number (regexp-split " " (read-line))))))])
                  (letrec ([d (lambda (i) 
                                (if (<= i (- len 2))
                                (letrec ([e (lambda (j) 
                                              (if (<= j (- len 1))
                                              (block
                                                (printf "~a " (vector-ref (vector-ref tab2 i) j))
                                                (e (+ j 1))
                                                )
                                              (block
                                                (display "\n")
                                                (d (+ i 1))
                                                )))])
                                (e 0))
                                '()))])
                  (d 0))))))])
  (f 0)))
))
)

