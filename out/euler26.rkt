#lang racket
(require racket/block)
(define array_init_withenv (lambda (len f env)
  (let ((tab (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    ))))) (list env tab))))

(define (periode restes len a b)
  ;toto
  (letrec ([c (lambda (a len) 
                (if (not (eq? a 0))
                (let ([chiffre (quotient a b)])
                (let ([reste (remainder a b)])
                (let ([e (- len 1)])
                (letrec ([d (lambda (i) 
                              (if (<= i e)
                              (if (eq? (vector-ref restes i) reste)
                              (- len i)
                              (d (+ i 1)))
                              (block
                                (vector-set! restes len reste)
                                (let ([len (+ len 1)])
                                (let ([a (* reste 10)])
                                (c a len)))
                                )))])
                (d 0)))))
                0))])
(c a len))
)
(define main
  ((lambda (internal_env) (apply (lambda (g t0) 
                                        (block
                                          g
                                          (let ([m 0])
                                          (let ([mi 0])
                                          (letrec ([h (lambda (i m mi) 
                                                        (if (<= i 1000)
                                                        (let ([p (periode t0 0 1 i)])
                                                        (if (> p m)
                                                        (let ([mi i])
                                                        (let ([m p])
                                                        (h (+ i 1) m mi)))
                                                        (h (+ i 1) m mi)))
                                                        (block
                                                          (map display (list mi "\n" m "\n"))
                                                          )))])
                                          (h 1 m mi))))
                                        )) internal_env)) (array_init_withenv 1000 
(lambda (j) 
  (lambda (_) (let ([f 0])
              (list '() f)))) '()))
)

