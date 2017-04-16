#lang racket
(require racket/block)

(define (dichofind len tab tofind a b)
  (if (>= a (- b 1))
  a
  (let ([c (quotient (+ a b) 2)])
  (if (< (vector-ref tab c) tofind)
  (dichofind len tab tofind c b)
  (dichofind len tab tofind a c))))
)

(define (process len tab)
  (let ([size (build-vector len (lambda (j) 
                                  (if (eq? j 0)
                                  0
                                  (* len 2))))])
  (letrec ([d (lambda (i) (if (<= i (- len 1))
                          (let ([k (dichofind len size (vector-ref tab i) 0 (- len 1))])
                          (if (> (vector-ref size (+ k 1)) (vector-ref tab i))
                          (block
                            (vector-set! size (+ k 1) (vector-ref tab i))
                            (d (+ i 1))
                            )
                          (d (+ i 1))))
                          (letrec ([e (lambda (l) (if (<= l (- len 1))
                                                  (block
                                                    (printf "~a " (vector-ref size l))
                                                    (e (+ l 1))
                                                    )
                                                  (letrec ([f (lambda (m) (if (<= m (- len 1))
                                                                          (let ([k (- (- len 1) m)])
                                                                          (if (not (eq? (vector-ref size k) (* len 2)))
                                                                          k
                                                                          (f (+ m 1))))
                                                                          0))])
                                                    (f 0))))])
                            (e 0))))])
    (d 0)))
)

(define main
  (let ([n (string->number (read-line))])
  (letrec ([g (lambda (i) (if (<= i n)
                          (let ([len (string->number (read-line))])
                          (block
                            (printf "~a\n" (process len (list->vector (map string->number (regexp-split " " (read-line))))))
                            (g (+ i 1))
                            ))
                          '()))])
    (g 1)))
)

