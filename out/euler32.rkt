#lang racket
(require racket/block)
(define array_init_withenv (lambda (len f env)
  (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    )))))

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
  (let ([allowed (array_init_withenv 10 (lambda (i) 
                                          (lambda (_) (let ([h (not (eq? i 0))])
                                                      (list '() h)))) '())])
  (let ([counted (array_init_withenv 100000 (lambda (j) 
                                              (lambda (_) (let ([k #f])
                                                          (list '() k)))) '())])
  (let ([bb 1])
  (let ([bc 9])
  (letrec ([l (lambda (e count) 
                (if (<= e bc)
                (block
                  (vector-set! allowed e #f)
                  (let ([z 1])
                  (let ([ba 9])
                  (letrec ([m (lambda (b count) 
                                (if (<= b ba)
                                (let ([count (if (vector-ref allowed b)
                                             (block
                                               (vector-set! allowed b #f)
                                               (let ([be (remainder (* b e) 10)])
                                               (let ([count (if (vector-ref allowed be)
                                                            (block
                                                              (vector-set! allowed be #f)
                                                              (let ([x 1])
                                                              (let ([y 9])
                                                              (letrec ([p 
                                                                (lambda (a count) 
                                                                  (if (<= a y)
                                                                  (let ([count 
                                                                  (if (vector-ref allowed a)
                                                                  (block
                                                                    (vector-set! allowed a #f)
                                                                    (let ([v 1])
                                                                    (let ([w 9])
                                                                    (letrec ([q 
                                                                    (lambda (c count) 
                                                                    (if (<= c w)
                                                                    (let ([count 
                                                                    (if (vector-ref allowed c)
                                                                    (block
                                                                    (vector-set! allowed c #f)
                                                                    (let ([s 1])
                                                                    (let ([u 9])
                                                                    (letrec ([r 
                                                                    (lambda (d count) 
                                                                    (if (<= d u)
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
                                                                    (r (+ d 1) count))
                                                                    (block
                                                                    (vector-set! allowed c #t)
                                                                    count
                                                                    )))])
                                                                    (r s count))))
                                                                    )
                                                                    count)])
                                                                    (q (+ c 1) count))
                                                                    (block
                                                                    (vector-set! allowed a #t)
                                                                    count
                                                                    )))])
                                                                    (q v count))))
                                                                  )
                                                                  count)])
                                                                  (p (+ a 1) count))
                                                                (block
                                                                  (vector-set! allowed be #t)
                                                                  count
                                                                  )))])
                                                              (p x count))))
                                               )
                                               count)])
                                             (block
                                               (vector-set! allowed b #t)
                                               count
                                               )))
                                )
                                count)])
                    (m (+ b 1) count))
                  (block
                    (vector-set! allowed e #t)
                    (l (+ e 1) count)
                    )))])
                (m z count))))
  )
  (block
    (map display (list count "\n"))
    )))])
(l bb count)))))))
)

