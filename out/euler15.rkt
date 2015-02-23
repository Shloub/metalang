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

(define main
  (let ([n 10])
  ; normalement on doit mettre 20 mais là on se tape un overflow 
  (let ([n (+ n 1)])
  ((lambda (internal_env) (apply (lambda (b tab) 
                                        (block
                                          b
                                          (let ([w (- n 1)])
                                          (letrec ([v (lambda (l) 
                                                        (if (<= l w)
                                                        (block
                                                          (vector-set! (vector-ref tab (- n 1)) l 1)
                                                          (vector-set! (vector-ref tab l) (- n 1) 1)
                                                          (v (+ l 1))
                                                          )
                                                        (letrec ([s (lambda (o) 
                                                                      (if (<= o n)
                                                                      (let ([r (- n o)])
                                                                      (letrec ([u 
                                                                        (lambda (p) 
                                                                          (if (<= p n)
                                                                          (let ([q (- n p)])
                                                                          (block
                                                                            (vector-set! (vector-ref tab r) q (+ (vector-ref (vector-ref tab (+ r 1)) q) (vector-ref (vector-ref tab r) (+ q 1))))
                                                                            (u (+ p 1))
                                                                            ))
                                                                          (s (+ o 1))))])
                                                                      (u 2)))
                                                                      (let ([h (- n 1)])
                                                                      (letrec ([e 
                                                                        (lambda (m) 
                                                                          (if (<= m h)
                                                                          (let ([g (- n 1)])
                                                                          (letrec ([f 
                                                                            (lambda (k) 
                                                                              (if (<= k g)
                                                                              (block
                                                                                (map display (list (vector-ref (vector-ref tab m) k) " "))
                                                                                (f (+ k 1))
                                                                                )
                                                                              (block
                                                                                (display "\n")
                                                                                (e (+ m 1))
                                                                                )))])
                                                                          (f 0)))
                                                                          (block
                                                                            (map display (list (vector-ref (vector-ref tab 0) 0) "\n"))
                                                                            )))])
                                                                      (e 0)))))])
                                          (s 2))))])
  (v 0)))
)) internal_env)) (array_init_withenv n (lambda (i) 
                                          (lambda (_) ((lambda (internal_env) (apply (lambda
                                           (d tab2) 
                                          (block
                                            d
                                            (let ([a tab2])
                                            (list '() a))
                                            )) internal_env)) (array_init_withenv n 
                                          (lambda (j) 
                                            (lambda (_) (let ([c 0])
                                                        (list '() c)))) '())))) '()))))
)

