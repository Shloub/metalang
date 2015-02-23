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
  ;
  ;a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  ;  a ^ 5 +
  ;  b ^ 5 +
  ;  c ^ 5 +
  ;  d ^ 5 +
  ;  e ^ 5
  ;
  ((lambda (internal_env) (apply (lambda (h p) 
                                        (block
                                          h
                                          (let ([sum 0])
                                          (let ([bd 0])
                                          (let ([be 9])
                                          (letrec ([j (lambda (a sum) 
                                                        (if (<= a be)
                                                        (let ([bb 0])
                                                        (let ([bc 9])
                                                        (letrec ([k (lambda (b sum) 
                                                                      (if (<= b bc)
                                                                      (let ([z 0])
                                                                      (let ([ba 9])
                                                                      (letrec ([l 
                                                                        (lambda (c sum) 
                                                                          (if (<= c ba)
                                                                          (let ([x 0])
                                                                          (let ([y 9])
                                                                          (letrec ([m 
                                                                            (lambda (d sum) 
                                                                              (if (<= d y)
                                                                              (let ([v 0])
                                                                              (let ([w 9])
                                                                              (letrec ([n 
                                                                                (lambda (e sum) 
                                                                                (if (<= e w)
                                                                                (let ([q 0])
                                                                                (let ([u 9])
                                                                                (letrec ([o 
                                                                                (lambda (f sum) 
                                                                                (if (<= f u)
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
                                                                                (o (+ f 1) sum))))
                                                                                (n (+ e 1) sum)))])
                                                                                (o q sum))))
                                                                                (m (+ d 1) sum)))])
                                                                              (n v sum))))
                                                                            (l (+ c 1) sum)))])
                                                                          (m x sum))))
                                                                      (k (+ b 1) sum)))])
                                                                      (l z sum))))
                                                        (j (+ a 1) sum)))])
                                            (k bb sum))))
                                          (display sum)))])
  (j bd sum)))))
)) internal_env)) (array_init_withenv 10 (lambda (i) 
                                           (lambda (_) (let ([g (* (* (* (* i i) i) i) i)])
                                                       (list '() g)))) '()))
)

