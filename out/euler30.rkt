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

(define main
  ;
  ;a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  ;  a ^ 5 +
  ;  b ^ 5 +
  ;  c ^ 5 +
  ;  d ^ 5 +
  ;  e ^ 5
  ;
  (let ([p (array_init_withenv 10 (lambda (i) 
                                    (lambda (_) (let ([g (* (* (* (* i i) i) i) i)])
                                                (list '() g)))) '())])
  (let ([sum 0])
  (let ([bc 0])
  (let ([bd 9])
  (letrec ([h (lambda (a sum) 
                (if (<= a bd)
                (let ([ba 0])
                (let ([bb 9])
                (letrec ([j (lambda (b sum) 
                              (if (<= b bb)
                              (let ([y 0])
                              (let ([z 9])
                              (letrec ([k (lambda (c sum) 
                                            (if (<= c z)
                                            (let ([w 0])
                                            (let ([x 9])
                                            (letrec ([l (lambda (d sum) 
                                                          (if (<= d x)
                                                          (let ([u 0])
                                                          (let ([v 9])
                                                          (letrec ([m 
                                                            (lambda (e sum) 
                                                              (if (<= e v)
                                                              (let ([o 0])
                                                              (let ([q 9])
                                                              (letrec ([n 
                                                                (lambda (f sum) 
                                                                  (if (<= f q)
                                                                  (let ([s (+ (+ (+ (+ (+ (vector-ref p a) (vector-ref p b)) (vector-ref p c)) (vector-ref p d)) (vector-ref p e)) (vector-ref p f))])
                                                                  (let ([r (+ (+ (+ (+ (+ a (* b 10)) (* c 100)) (* d 1000)) (* e 10000)) (* f 100000))])
                                                                  (let ([sum 
                                                                  (if (and (eq? s r) (not (eq? r 1)))
                                                                  (block
                                                                    (map display (list f e d c b a " " r "\n"))
                                                                    (let ([sum (+ sum r)])
                                                                    sum)
                                                                    )
                                                                  sum)])
                                                                  (n (+ f 1) sum))))
                                                                  (m (+ e 1) sum)))])
                                                              (n o sum))))
                                                              (l (+ d 1) sum)))])
                                                          (m u sum))))
                                              (k (+ c 1) sum)))])
                                            (l w sum))))
                              (j (+ b 1) sum)))])
                              (k y sum))))
                (h (+ a 1) sum)))])
    (j ba sum))))
  (display sum)))])
(h bc sum))))))
)

