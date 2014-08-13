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

(define max2 (lambda (a b) 
               (let ([v (lambda (a b) 
                          '())])
               (if (> a b)
                 a
                 b))))
(define nbPassePartout (lambda (n passepartout m serrures) 
                         (let ([max_ancient 0])
                           (let ([max_recent 0])
                             (let ([s 0])
                               (let ([u (- m 1)])
                                 (letrec ([p (lambda (i max_recent max_ancient n passepartout m serrures) 
                                               (if (<= i u)
                                                 (let ([r (lambda (max_recent max_ancient n passepartout m serrures) 
                                                            (let ([q 
                                                              (lambda (max_recent max_ancient n passepartout m serrures) 
                                                                (p (+ i 1) max_recent max_ancient n passepartout m serrures))])
                                                            (if (and (eq? (vector-ref (vector-ref serrures i) 0) 1) (> (vector-ref (vector-ref serrures i) 1) max_recent))
                                                              (let ([max_recent (vector-ref (vector-ref serrures i) 1)])
                                                                (q max_recent max_ancient n passepartout m serrures))
                                                              (q max_recent max_ancient n passepartout m serrures))))])
                                               (if (and (eq? (vector-ref (vector-ref serrures i) 0) (- 1)) (> (vector-ref (vector-ref serrures i) 1) max_ancient))
                                                 (let ([max_ancient (vector-ref (vector-ref serrures i) 1)])
                                                   (r max_recent max_ancient n passepartout m serrures))
                                                 (r max_recent max_ancient n passepartout m serrures)))
                                   (let ([max_ancient_pp 0])
                                     (let ([max_recent_pp 0])
                                       (let ([h 0])
                                         (let ([o (- n 1)])
                                           (letrec ([f (lambda (i max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures) 
                                                         (if (<= i o)
                                                           (let ([pp (vector-ref passepartout i)])
                                                             (let ([g 
                                                               (lambda (pp max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures) 
                                                                 (let ([max_ancient_pp (max2 max_ancient_pp (vector-ref pp 0))])
                                                                   (let ([max_recent_pp (max2 max_recent_pp (vector-ref pp 1))])
                                                                    (f (+ i 1) max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures))))])
                                                             (if (and (>= (vector-ref pp 0) max_ancient) (>= (vector-ref pp 1) max_recent))
                                                               1
                                                               (g pp max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures))))
                                                         (let ([e (lambda (max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures) 
                                                                    '())])
                                                         (if (and (>= max_ancient_pp max_ancient) (>= max_recent_pp max_recent))
                                                           2
                                                           0))))])
                                       (f h max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures))))))))])
  (p s max_recent max_ancient n passepartout m serrures))))))))
(define main ((lambda (n) 
                (block (mread-blank) (let ([passepartout (array_init_withenv n 
                                       (lambda (i) 
                                         (lambda (n) 
                                           (let ([c 2])
                                             (let ([out0 (array_init_withenv c 
                                               (lambda (j) 
                                                 (lambda (internal_env) (apply (lambda
                                                  (c i n) 
                                                 ((lambda (out__) 
                                                    (block (mread-blank) 
                                                    (let ([x out__])
                                                      (list (list c i n) x)) )) (mread-int))) internal_env))) (list c i n))])
                                           (let ([w out0])
                                             (list n w)))))) n)])
((lambda (m) 
   (block (mread-blank) (let ([serrures (array_init_withenv m (lambda (k) 
                                                                (lambda (internal_env) (apply (lambda
                                                                 (m n) 
                                                                (let ([d 2])
                                                                  (let ([out1 (array_init_withenv d 
                                                                    (lambda (l) 
                                                                    (lambda (internal_env) (apply (lambda
                                                                     (d k m n) 
                                                                    (
                                                                    (lambda (out_) 
                                                                    (block (mread-blank) 
                                                                    (let ([z out_])
                                                                    (list (list d k m n) z)) )) (mread-int))) internal_env))) (list d k m n))])
                                                                (let ([y out1])
                                                                  (list (list m n) y))))) internal_env))) (list m n))])
(display (nbPassePartout n passepartout m serrures))) )) (mread-int))) )) (mread-int)))

