#lang racket
(require racket/block)

(define (okdigits ok n)
  (if (eq? n 0)
  #t
  (let ([digit (remainder n 10)])
  (if (vector-ref ok digit)
  (block
    (vector-set! ok digit #f)
    (let ([o (okdigits ok (quotient n 10))])
    (block
      (vector-set! ok digit #t)
      o
      ))
    )
  #f)))
)
(define main
  (let ([count 0])
  (let ([allowed (build-vector 10 (lambda (i) 
                                    (not (eq? i 0))))])
  (let ([counted (build-vector 100000 (lambda (j) 
                                        #f))])
  (letrec ([l (lambda (e count) 
                (if (<= e 9)
                (block
                  (vector-set! allowed e #f)
                  (letrec ([m (lambda (b count) 
                                (if (<= b 9)
                                (if (vector-ref allowed b)
                                (block
                                  (vector-set! allowed b #f)
                                  (let ([be (remainder (* b e) 10)])
                                  (let ([count (if (vector-ref allowed be)
                                               (block
                                                 (vector-set! allowed be #f)
                                                 (letrec ([p (lambda (a count) 
                                                               (if (<= a 9)
                                                               (if (vector-ref allowed a)
                                                               (block
                                                                 (vector-set! allowed a #f)
                                                                 (letrec ([q (lambda (c count) 
                                                                               (if (<= c 9)
                                                                               (if (vector-ref allowed c)
                                                                               (block
                                                                                (vector-set! allowed c #f)
                                                                                (letrec ([r 
                                                                                (lambda (d count) 
                                                                                (if (<= d 9)
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
                                                                                (printf "~a " product)
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
                                                                                (printf "~a " product2)
                                                                                count
                                                                                ))
                                                                                )
                                                                                count)])
                                                                                (block
                                                                                (vector-set! allowed d #t)
                                                                                (r (+ d 1) count)
                                                                                )))))
                                                                                )
                                                                                (r (+ d 1) count))
                                                                                (block
                                                                                (vector-set! allowed c #t)
                                                                                (q (+ c 1) count)
                                                                                )))])
                                                                                (r 1 count))
                                                                               )
                                                                               (q (+ c 1) count))
                                                                               (block
                                                                                (vector-set! allowed a #t)
                                                                                (p (+ a 1) count)
                                                                                )))])
                                                               (q 1 count))
                                                               )
                                                               (p (+ a 1) count))
                                                   (block
                                                     (vector-set! allowed be #t)
                                                     count
                                                     )))])
                                  (p 1 count))
                                  )
                                  count)])
                                (block
                                  (vector-set! allowed b #t)
                                  (m (+ b 1) count)
                                  )))
                                )
                    (m (+ b 1) count))
                  (block
                    (vector-set! allowed e #t)
                    (l (+ e 1) count)
                    )))])
    (m 1 count))
  )
  (printf "~a\n" count)))])
(l 1 count)))))
)

