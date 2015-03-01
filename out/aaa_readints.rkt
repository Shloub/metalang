#lang racket
(require racket/block)

(define main
  (let ([len (string->number (read-line))])
  (block
    (printf "~a=len\n" len)
    (let ([tab1 (list->vector (map string->number (regexp-split " " (read-line))))])
    (let ([k (- len 1)])
    (letrec ([h (lambda (i) 
                  (if (<= i k)
                  (block
                    (printf "~a=>~a\n" i (vector-ref tab1 i))
                    (h (+ i 1))
                    )
                  (let ([len (string->number (read-line))])
                  (let ([tab2 (build-vector (- len 1) (lambda (a) 
                                                        (list->vector (map string->number (regexp-split " " (read-line))))))])
                  (let ([g (- len 2)])
                  (letrec ([d (lambda (i) 
                                (if (<= i g)
                                (let ([f (- len 1)])
                                (letrec ([e (lambda (j) 
                                              (if (<= j f)
                                              (block
                                                (printf "~a " (vector-ref (vector-ref tab2 i) j))
                                                (e (+ j 1))
                                                )
                                              (block
                                                (display "\n")
                                                (d (+ i 1))
                                                )))])
                                (e 0)))
                                '()))])
                  (d 0)))))))])
  (h 0))))
))
)

