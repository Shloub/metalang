#lang racket
(require racket/block)

(define main
  (let ([len (string->number (read-line))])
  (block
    (printf "~a=len\n" len)
    (let ([tab1 (list->vector (map string->number (regexp-split " " (read-line))))])
    (letrec ([b (lambda (i) (if (<= i (- len 1))
                            (block
                              (printf "~a=>~a\n" i (vector-ref tab1 i))
                              (b (+ i 1))
                              )
                            (let ([len (string->number (read-line))])
                            (let ([tab2 (build-vector (- len 1) (lambda (a) 
                                                                  (list->vector (map string->number (regexp-split " " (read-line))))))])
                            (letrec ([c (lambda (i) (if (<= i (- len 2))
                                                    (letrec ([d (lambda (j) (if (<= j (- len 1))
                                                                            (block
                                                                              (printf "~a " (vector-ref (vector-ref tab2 i) j))
                                                                              (d (+ j 1))
                                                                              )
                                                                            (block
                                                                              (display "\n")
                                                                              (c (+ i 1))
                                                                              )))])
                                                      (d 0))
                                                    '()))])
                              (c 0))))))])
    (b 0)))
  ))
)

