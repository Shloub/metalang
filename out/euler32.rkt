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

(define (okdigits ok n)
  ;toto
  (let ([f (lambda (_) 
             '())])
  (if (eq? n 0)
  #t
  (let ([digit (remainder n 10)])
  (let ([g (lambda (_) 
             (f 'nil))])
  (if (vector-ref ok digit)
  (block
    (vector-set! ok digit #f)
    (let ([o (okdigits ok (quotient n 10))])
    (block
      (vector-set! ok digit #t)
      o
      ))
    )
  #f)))))
)
(define main
  (let ([count 0])
  ((lambda (internal_env) (apply (lambda (k allowed) 
                                        (block
                                          k
                                          ((lambda (internal_env) (apply (lambda
                                           (m counted) 
                                          (block
                                            m
                                            (let ([bd 1])
                                            (let ([bf 9])
                                            (letrec ([p (lambda (e count) 
                                                          (if (<= e bf)
                                                          (block
                                                            (vector-set! allowed e #f)
                                                            (let ([bb 1])
                                                            (let ([bc 9])
                                                            (letrec ([q 
                                                              (lambda (b count) 
                                                                (if (<= b bc)
                                                                (let ([count 
                                                                (if (vector-ref allowed b)
                                                                (block
                                                                  (vector-set! allowed b #f)
                                                                  (let ([be (remainder (* b e) 10)])
                                                                  (let ([count 
                                                                  (if (vector-ref allowed be)
                                                                  (block
                                                                    (vector-set! allowed be #f)
                                                                    (let ([z 1])
                                                                    (let ([ba 9])
                                                                    (letrec ([r 
                                                                    (lambda (a count) 
                                                                    (if (<= a ba)
                                                                    (let ([count 
                                                                    (if (vector-ref allowed a)
                                                                    (block
                                                                    (vector-set! allowed a #f)
                                                                    (let ([x 1])
                                                                    (let ([y 9])
                                                                    (letrec ([s 
                                                                    (lambda (c count) 
                                                                    (if (<= c y)
                                                                    (let ([count 
                                                                    (if (vector-ref allowed c)
                                                                    (block
                                                                    (vector-set! allowed c #f)
                                                                    (let ([v 1])
                                                                    (let ([w 9])
                                                                    (letrec ([u 
                                                                    (lambda (d count) 
                                                                    (if (<= d w)
                                                                    (let ([count 
                                                                    (if (vector-ref allowed d)
                                                                    (block
                                                                    (vector-set! allowed d #f)
                                                                    ; 2 * 3 digits 
                                                                    (let ([product (* (+ (* a 10) b) (+ (+ (* c 100) (* d 10)) e))])
                                                                    (let ([count 
                                                                    (if (and (not (vector-ref counted product)) (okdigits allowed (quotient product 10)))
                                                                    (block
                                                                    (vector-set! counted product #t)
                                                                    (let ([count (+ count product)])
                                                                    (block
                                                                    (map display (list product " "))
                                                                    count
                                                                    ))
                                                                    )
                                                                    count)])
                                                                    ; 1  * 4 digits 
                                                                    (let ([product2 (* b (+ (+ (+ (* a 1000) (* c 100)) (* d 10)) e))])
                                                                    (let ([count 
                                                                    (if (and (not (vector-ref counted product2)) (okdigits allowed (quotient product2 10)))
                                                                    (block
                                                                    (vector-set! counted product2 #t)
                                                                    (let ([count (+ count product2)])
                                                                    (block
                                                                    (map display (list product2 " "))
                                                                    count
                                                                    ))
                                                                    )
                                                                    count)])
                                                                    (block
                                                                    (vector-set! allowed d #t)
                                                                    count
                                                                    )))))
                                                                    )
                                                                    count)])
                                                                    (u (+ d 1) count))
                                                                    (block
                                                                    (vector-set! allowed c #t)
                                                                    count
                                                                    )))])
                                                                    (u v count))))
                                                                    )
                                                                    count)])
                                                                    (s (+ c 1) count))
                                                                    (block
                                                                    (vector-set! allowed a #t)
                                                                    count
                                                                    )))])
                                                                    (s x count))))
                                                                    )
                                                                    count)])
                                                                    (r (+ a 1) count))
                                                                    (block
                                                                    (vector-set! allowed be #t)
                                                                    count
                                                                    )))])
                                                                    (r z count))))
                                                                  )
                                                                  count)])
                                                                (block
                                                                  (vector-set! allowed b #t)
                                                                  count
                                                                  )))
                                                                )
                                                                count)])
                                                              (q (+ b 1) count))
                                                            (block
                                                              (vector-set! allowed e #t)
                                                              (p (+ e 1) count)
                                                              )))])
                                                          (q bb count))))
                                            )
                                            (block
                                              (map display (list count "\n"))
                                              )))])
                                          (p bd count))))
  )) internal_env)) (array_init_withenv 100000 (lambda (j) 
                                                 (lambda (_) (let ([l #f])
                                                             (list '() l)))) '()))
)) internal_env)) (array_init_withenv 10 (lambda (i) 
                                           (lambda (_) (let ([h (not (eq? i 0))])
                                                       (list '() h)))) '())))
)
