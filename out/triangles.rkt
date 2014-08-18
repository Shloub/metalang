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
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
(define mread-char (lambda ()
  (let ([ out last-char])
    (block
      (next-char)
      out
    ))))

(define mread-int (lambda ()
  (if (eq? #\- last-char)
  (block
    (next-char) (- 0 (mread-int)))
    (letrec ([w (lambda (out)
      (if (eof-object? last-char)
        out
        (if (and last-char (>= (char->integer last-char) (char->integer #\0)) (<= (char->integer last-char) (char->integer #\9)))
          (let ([out (+ (* 10 out) (- (char->integer last-char) (char->integer #\0)))])
            (block
              (next-char)
              (w out)
          ))
        out
      )))]) (w 0)))))

(define mread-blank (lambda ()
  (if (or (eq? last-char #\NewLine) (eq? last-char #\Space) ) (block (next-char) (mread-blank)) '())
))

(define find0 (lambda (len tab cache x y) 
                ;
                ;	Cette fonction est récursive
                ;	
                (let ([f (lambda (len tab cache x y) 
                           (let ([result 0])
                             (let ([out0 (find0 len tab cache x (+ y 1))])
                               (let ([out1 (find0 len tab cache (+ x 1) (+ y 1))])
                                 (let ([e (lambda (out1 out0 result len tab cache x y) 
                                            (block
                                              (vector-set! (vector-ref cache y) x result)
                                              result
                                              ))])
                                 (if (> out0 out1)
                                   (let ([result (+ out0 (vector-ref (vector-ref tab y) x))])
                                     (e out1 out0 result len tab cache x y))
                                   (let ([result (+ out1 (vector-ref (vector-ref tab y) x))])
                                     (e out1 out0 result len tab cache x y))))))))])
  (if (eq? y (- len 1))
    (vector-ref (vector-ref tab y) x)
    (let ([g (lambda (len tab cache x y) 
               (f len tab cache x y))])
    (if (> x y)
      (- 10000)
      (let ([h (lambda (len tab cache x y) 
                 (g len tab cache x y))])
      (if (not (eq? (vector-ref (vector-ref cache y) x) 0))
        (vector-ref (vector-ref cache y) x)
        (h len tab cache x y)))))))))
(define find_ (lambda (len tab) 
                (let ([tab2 (array_init_withenv len (lambda (i) 
                                                      (lambda (internal_env) (apply (lambda
                                                       (len tab) 
                                                      (let ([a (+ i 1)])
                                                        (let ([tab3 (array_init_withenv a 
                                                          (lambda (j) 
                                                            (lambda (internal_env) (apply (lambda
                                                             (a i len tab) 
                                                            (let ([d 0])
                                                              (list (list a i len tab) d))) internal_env))) (list a i len tab))])
                                                        (let ([c tab3])
                                                          (list (list len tab) c))))) internal_env))) (list len tab))])
  (find0 len tab tab2 0 0))))
(define main (let ([len 0])
               ((lambda (w) 
                  (let ([len w])
                    (block (mread-blank) (let ([tab (array_init_withenv len 
                                           (lambda (i) 
                                             (lambda (len) 
                                               (let ([b (+ i 1)])
                                                 (let ([tab2 (array_init_withenv b 
                                                   (lambda (j) 
                                                     (lambda (internal_env) (apply (lambda
                                                      (b i len) 
                                                     (let ([tmp 0])
                                                       ((lambda (o) 
                                                          (let ([tmp o])
                                                            (block (mread-blank) 
                                                            (let ([n tmp])
                                                              (list (list b i len) n)) ))) (mread-int)))) internal_env))) (list b i len))])
                                               (let ([m tab2])
                                                 (list len m)))))) len)])
  (block
    (display (find_ len tab))
    (display "\n")
    (let ([u 0])
      (let ([v (- len 1)])
        (letrec ([p (lambda (k len) 
                      (if (<= k v)
                        (let ([r 0])
                          (let ([s k])
                            (letrec ([q (lambda (l len) 
                                          (if (<= l s)
                                            (block
                                              (display (vector-ref (vector-ref tab k) l))
                                              (display " ")
                                              (q (+ l 1) len)
                                              )
                                            (block
                                              (display "\n")
                                              (p (+ k 1) len)
                                              )))])
                            (q r len))))
                      '()))])
      (p u len))))
)) ))) (mread-int))))

