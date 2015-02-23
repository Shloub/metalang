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
                                          (let ([bc 0])
                                          (let ([bd (- n 1)])
                                          (letrec ([bb (lambda (l) 
                                                         (if (<= l bd)
                                                         (block
                                                           (vector-set! (vector-ref tab (- n 1)) l 1)
                                                           (vector-set! (vector-ref tab l) (- n 1) 1)
                                                           (bb (+ l 1))
                                                           )
                                                         (let ([z 2])
                                                         (let ([ba n])
                                                         (letrec ([v (lambda (o) 
                                                                       (if (<= o ba)
                                                                       (let ([r (- n o)])
                                                                       (let ([x 2])
                                                                       (let ([y n])
                                                                       (letrec ([w 
                                                                         (lambda (p) 
                                                                           (if (<= p y)
                                                                           (let ([q (- n p)])
                                                                           (block
                                                                             (vector-set! (vector-ref tab r) q (+ (vector-ref (vector-ref tab (+ r 1)) q) (vector-ref (vector-ref tab r) (+ q 1))))
                                                                             (w (+ p 1))
                                                                             ))
                                                                           (v (+ o 1))))])
                                                                       (w x)))))
                                                                       (let ([s 0])
                                                                       (let ([u (- n 1)])
                                                                       (letrec ([e 
                                                                         (lambda (m) 
                                                                           (if (<= m u)
                                                                           (let ([g 0])
                                                                           (let ([h (- n 1)])
                                                                           (letrec ([f 
                                                                             (lambda (k) 
                                                                               (if (<= k h)
                                                                               (block
                                                                                (map display (list (vector-ref (vector-ref tab m) k) " "))
                                                                                (f (+ k 1))
                                                                                )
                                                                               (block
                                                                                (display "\n")
                                                                                (e (+ m 1))
                                                                                )))])
                                                                           (f g))))
                                                                           (block
                                                                             (map display (list (vector-ref (vector-ref tab 0) 0) "\n"))
                                                                             )))])
                                                                       (e s))))))])
                                                         (v z))))))])
  (bb bc))))
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

